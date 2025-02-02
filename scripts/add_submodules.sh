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

# Tworzenie struktury katalogów z bezpiecznymi nazwami
mkdir -p \
  "microservices/admin" \
  "microservices/analytics" \
  "microservices/agreements" \
  "microservices/booking" \
  "microservices/catalog" \
  "microservices/communication" \
  "microservices/file-storage" \
  "microservices/identity" \
  "microservices/notification" \
  "microservices/payment" \
  "microservices/review" \
  "microservices/security" \
  "microservices/verification" \
  "frontend/web-client" \
  "frontend/mobile-client" \
  "bff/web-api" \
  "bff/mobile-api" \
  "shared/templates" \
  "shared/config"

# Mapowanie bezpiecznych nazw katalogów do repozytoriów
declare -A repositories=(
  # Mikroservisy
  ["microservices/admin"]="https://github.com/hoodley-app/Hoodley.Admin.git"
  ["microservices/analytics"]="https://github.com/hoodley-app/Hoodley.Analytics.git"
  ["microservices/file-storage"]="https://github.com/hoodley-app/Hoodley.FileStorage.git"
  ["microservices/identity"]="https://github.com/hoodley-app/Hoodley.Identity.git"
  ["microservices/agreements"]="https://github.com/hoodley-app/Hoodley.Agreements.git"
  ["microservices/booking"]="https://github.com/hoodley-app/Hoodley.Booking.git"
  ["microservices/catalog"]="https://github.com/hoodley-app/Hoodley.Catalog.git"
  ["microservices/communication"]="https://github.com/hoodley-app/Hoodley.Communication.git"
  ["microservices/notification"]="https://github.com/hoodley-app/Hoodley.Notification.git"
  ["microservices/payment"]="https://github.com/hoodley-app/Hoodley.Payment.git"
  ["microservices/review"]="https://github.com/hoodley-app/Hoodley.Review.git"
  ["microservices/security"]="https://github.com/hoodley-app/Hoodley.Security.git"
  ["microservices/verification"]="https://github.com/hoodley-app/Hoodley.Verification.git"
  
  # Frontend
  ["frontend/web-client"]="https://github.com/hoodley-app/hoodley.web.frontend.git"
  ["frontend/mobile-client"]="https://github.com/hoodley-app/Hoodley.Mobile.Frontend.git"
  
  # BFF
  ["bff/web-api"]="https://github.com/hoodley-app/Hoodley.Web.BFF.git"
  ["bff/mobile-api"]="https://github.com/hoodley-app/Hoodley.Mobile.BFF.git"
)

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
   git clone --recursive https://github.com/hoodley-app/.github.git

3. Aktualizacja submodułów:
   git submodule update --remote --merge
" 