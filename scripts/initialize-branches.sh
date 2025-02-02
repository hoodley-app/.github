#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_error() { echo -e "${RED}$1${NC}"; }

# Sprawdź czy branche już istnieją
check_branch() {
    if git rev-parse --verify $1 &>/dev/null; then
        log_error "Branch $1 już istnieje!"
        return 1
    fi
    return 0
}

# Sprawdź czy jesteśmy na main
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ "$current_branch" != "main" ]]; then
    if [[ "$current_branch" == "master" ]]; then
        log_info "Migracja z master na main..."
        git branch -m master main
        git push -u origin main
        git push origin --delete master
    else
        log_error "Musisz być na branchu main!"
        exit 1
    fi
fi

# Sprawdź czy branche już istnieją
for branch in "develop" "release"; do
    if ! check_branch $branch; then
        log_error "Inicjalizacja przerwana - branche już istnieją"
        exit 1
    fi
done

# Tworzenie branchy
log_info "Inicjalizacja branchy z $current_branch..."

# Utwórz develop
git checkout -b develop
git push -u origin develop

# Utwórz release
git checkout -b release
git push -u origin release

# Wróć na develop
git checkout develop

log_success "Branche zostały utworzone i wypushowane do origin"
log_success "Domyślny branch: develop" 