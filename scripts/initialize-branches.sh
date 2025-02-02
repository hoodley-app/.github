#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }

log_info "Inicjalizacja branchy..."

# Upewnij się, że jesteśmy na main
git checkout main

# Utwórz develop z main
log_info "Tworzenie brancha develop..."
git checkout -b develop
git push -u origin develop

# Utwórz release z develop
log_info "Tworzenie brancha release..."
git checkout develop
git checkout -b release
git push -u origin release

# Wróć na develop jako domyślny branch do pracy
git checkout develop

log_success "Branche zostały utworzone i wypushowane do origin."
log_success "Domyślny branch: develop" 