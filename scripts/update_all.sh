#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_error() { echo -e "${RED}$1${NC}"; }

# 1. Aktualizacja głównego repozytorium
log_info "Aktualizacja głównego repozytorium..."
git pull origin main

# 2. Aktualizacja submodułów
log_info "Aktualizacja submodułów..."
git submodule update --remote --merge

# 3. Aktualizacja szablonów
log_info "Aktualizacja szablonów..."
cd shared/templates || exit
git pull origin main
cd ../..

# 4. Aktualizacja wspólnych konfiguracji
log_info "Aktualizacja konfiguracji..."
cd shared/config || exit
git pull origin main
cd ../..

# 5. Rebuild wszystkich projektów
log_info "Rebuilding projektów..."
docker-compose build

log_success "Wszystkie komponenty zostały zaktualizowane!" 