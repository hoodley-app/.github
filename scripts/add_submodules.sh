#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}$1${NC}"; }
log_success() { echo -e "${GREEN}$1${NC}"; }
log_error() { echo -e "${RED}$1${NC}"; }

# Lista repozytoriów
declare -A repositories=(
  # Infrastruktura
  [".github"]="https://github.com/hoodley-app/.github.git"
  
  # Mikroservisy
  ["Microservices/Hoodley.Admin"]="https://github.com/hoodley-app/Hoodley.Admin.git"
  ["Microservices/Hoodley.Analytics"]="https://github.com/hoodley-app/Hoodley.Analytics.git"
  ["Microservices/Hoodley.FileStorage"]="https://github.com/hoodley-app/Hoodley.FileStorage.git"
  ["Microservices/Hoodley.Identity"]="https://github.com/hoodley-app/Hoodley.Identity.git"
  ["Microservices/Hoodley.Agreements"]="https://github.com/hoodley-app/Hoodley.Agreements.git"
  ["Microservices/Hoodley.Booking"]="https://github.com/hoodley-app/Hoodley.Booking.git"
  ["Microservices/Hoodley.Catalog"]="https://github.com/hoodley-app/Hoodley.Catalog.git"
  ["Microservices/Hoodley.Communication"]="https://github.com/hoodley-app/Hoodley.Communication.git"
  ["Microservices/Hoodley.Notification"]="https://github.com/hoodley-app/Hoodley.Notification.git"
  ["Microservices/Hoodley.Payment"]="https://github.com/hoodley-app/Hoodley.Payment.git"
  ["Microservices/Hoodley.Review"]="https://github.com/hoodley-app/Hoodley.Review.git"
  ["Microservices/Hoodley.Security"]="https://github.com/hoodley-app/Hoodley.Security.git"
  ["Microservices/Hoodley.Verification"]="https://github.com/hoodley-app/Hoodley.Verification.git"
  
  # BFF
  ["BFF/Hoodley.Web.BFF"]="https://github.com/hoodley-app/Hoodley.Web.BFF.git"
  ["BFF/Hoodley.Mobile.BFF"]="https://github.com/hoodley-app/Hoodley.Mobile.BFF.git"
  
  # Frontend
  ["Frontend/hoodley.web.frontend"]="https://github.com/hoodley-app/hoodley.web.frontend.git"
  ["Frontend/Hoodley.Mobile.Frontend"]="https://github.com/hoodley-app/Hoodley.Mobile.Frontend.git"
)

# Sprawdź czy jesteśmy w głównym repozytorium
if [ ! -d ".git" ]; then
  log_error "Ten skrypt musi być uruchomiony w głównym repozytorium!"
  exit 1
fi

# Utwórz strukturę katalogów
mkdir -p Microservices BFF Frontend

# Funkcja do dodawania submodułu
add_submodule() {
  local path=$1
  local url=$2
  
  log_info "Dodawanie submodułu: $path"
  
  if [ -d "$path" ]; then
    log_info "Katalog $path już istnieje, usuwanie..."
    rm -rf "$path"
  fi
  
  if ! git submodule add -f "$url" "$path"; then
    log_error "Błąd podczas dodawania submodułu: $path"
    return 1
  fi
  
  return 0
}

# Dodaj wszystkie submoduły
for path in "${!repositories[@]}"; do
  if ! add_submodule "$path" "${repositories[$path]}"; then
    log_error "Wystąpił błąd, przerywanie..."
    exit 1
  fi
done

# Inicjalizuj i zaktualizuj submoduły
log_info "Inicjalizacja i aktualizacja submodułów..."
git submodule update --init --recursive

# Zatwierdź zmiany
log_info "Zatwierdzanie zmian..."
git add .
git commit -m "chore: add all submodules"

log_success "Wszystkie submoduły zostały dodane pomyślnie!"

# Wyświetl instrukcje
log_info "
Następne kroki:
1. Push zmian:
   git push origin main

2. Klonowanie repozytorium z submodułami:
   git clone --recursive https://github.com/hoodley-app/Hoodley.git

3. Aktualizacja submodułów:
   git submodule update --remote --merge
" 