#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_error() { echo -e "${RED}$1${NC}"; }

# Sprawdź czy jesteśmy w głównym repozytorium
if [ ! -d ".git" ]; then
  log_error "Ten skrypt musi być uruchomiony w głównym repozytorium .github!"
  exit 1
fi

# Inicjalizuj i zaktualizuj wszystkie submoduły
log_info "Inicjalizacja i aktualizacja submodułów..."
if ! git submodule update --init --recursive; then
  log_error "Błąd podczas inicjalizacji/aktualizacji submodułów"
  exit 1
fi

# Zatwierdź zmiany
log_info "Zatwierdzanie zmian..."
if ! git add .; then
  log_error "Błąd podczas dodawania plików do commita"
  exit 1
fi

if ! git commit -m "chore: update all submodules"; then
  log_error "Błąd podczas tworzenia commita"
  exit 1
fi

log_success "Submoduły zostały pomyślnie zaktualizowane!"

# Opcjonalnie: Push zmian do zdalnego repozytorium
echo "Czy chcesz wypchnąć zmiany do zdalnego repozytorium? (y/n)"
read -r push_changes
if [ "$push_changes" = "y" ] || [ "$push_changes" = "Y" ]; then
  if ! git push origin main; then
    log_error "Błąd podczas pushowania zmian"
    exit 1
  fi
fi 