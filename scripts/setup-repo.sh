#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_error() { echo -e "${RED}$1${NC}"; }

# 1. Inicjalizacja branchy (jeśli nie istnieją)
if ! git rev-parse --verify develop &>/dev/null; then
    log_info "Inicjalizacja branchy..."
    ./scripts/initialize-branches.sh
fi

# 2. Konfiguracja CI/CD
log_info "Konfiguracja CI/CD..."
mkdir -p .github/workflows

# Wykryj typ projektu i skopiuj odpowiedni workflow
if [[ -f "package.json" ]]; then
    log_info "Konfiguracja dla projektu Next.js..."
    cp workflow-templates/nextjs-template.yml .github/workflows/ci.yml
else
    log_info "Konfiguracja dla projektu .NET..."
    cp workflow-templates/dotnet-template.yml .github/workflows/ci.yml
fi

# 3. Konfiguracja semantic-release i commitlint
log_info "Konfiguracja semantic-release i commitlint..."
cp template-files/release.config.json .
cp template-files/commitlint.config.js .
cp workflow-templates/semantic-release.yml .github/workflows/

# 4. Konfiguracja husky (tylko dla frontendów)
if [[ -f "package.json" ]]; then
    log_info "Konfiguracja husky..."
    npm install --save-dev husky @commitlint/cli @commitlint/config-conventional
    npx husky install
    npx husky add .husky/commit-msg 'npx --no -- commitlint --edit "$1"'
fi

# 5. Konfiguracja Dockerfile
log_info "Konfiguracja Dockerfile..."
if [[ -f "package.json" ]]; then
    cat > Dockerfile <<EOL
# Użyj bazowego template
FROM ghcr.io/hoodley/.github/dockerfile-templates/nextjs:latest

# Dodaj specyficzne dla projektu konfiguracje
ENV NEXT_PUBLIC_API_URL=https://api.hoodley.com

# Miejsce na dodatkowe konfiguracje specyficzne dla projektu
EOL
else
    PROJECT_NAME=$(basename $(pwd))
    cat > Dockerfile <<EOL
# Użyj bazowego template
FROM ghcr.io/hoodley/.github/dockerfile-templates/dotnet:latest

# Specyficzne zmienne środowiskowe
ENV ASPNETCORE_ENVIRONMENT=Production
ENV PROJECT_NAME=$PROJECT_NAME

# Miejsce na dodatkowe konfiguracje specyficzne dla projektu
EOL
fi

log_success "Dockerfile został utworzony!"

log_success "Konfiguracja zakończona pomyślnie!" 