#!/bin/bash

# Kolory do logowania
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Inicjalizacja branchy...${NC}"

# Upewnij się, że jesteśmy na main
git checkout main

# Utwórz develop z main
git checkout -b develop
git push -u origin develop

# Utwórz release z develop
git checkout develop
git checkout -b release
git push -u origin release

# Wróć na develop jako domyślny branch do pracy
git checkout develop

echo -e "${GREEN}Branche zostały utworzone i wypushowane do origin.${NC}"
echo -e "${GREEN}Domyślny branch: develop${NC}" 