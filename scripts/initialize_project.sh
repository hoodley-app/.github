#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Klonowanie repozytorium z submodułami...${NC}"
git clone --recursive https://github.com/hoodley-app/.github.git
cd .github || exit

echo -e "${GREEN}Nadanie uprawnień do wykonania skryptów...${NC}"
chmod +x scripts/*.sh

echo -e "${GREEN}Inicjalizacja submodułów...${NC}"
./scripts/add_submodules.sh

echo -e "${GREEN}Uruchamianie projektu lokalnie...${NC}"
docker-compose up -d

echo -e "${GREEN}Projekt został pomyślnie zainicjalizowany i uruchomiony!${NC}" 