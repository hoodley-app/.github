# Git Workflow Guide

## Struktura Branchy

```
main ────────────●──────────●─────── (stabilne wydania)
                │          │
release ────────●──────────●─────── (pre-release)
                │          │
develop ────●───●───●──────●─────── (integracja)
         │      │   │
feature ─●──────●   │              (nowe funkcjonalności)
             │      │
bugfix ──────●      │              (poprawki błędów)
                    │
hotfix ─────────────●              (krytyczne poprawki)
```

### Główne Branche

- `main` - Kod produkcyjny
- `release` - Kandydaci do wydania
- `develop` - Integracja zmian

### Branche Pomocnicze

- `feature/*` - Nowe funkcjonalności
- `bugfix/*` - Poprawki błędów
- `hotfix/*` - Krytyczne poprawki
- `docs/*` - Zmiany w dokumentacji

## Konwencje Nazewnictwa

### Branche
```
feature/JIRA-123-user-authentication
bugfix/JIRA-456-login-error
hotfix/critical-security-fix
docs/update-api-docs
```

### Commity
Używamy [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add user authentication
fix: resolve login error
docs: update API documentation
chore: update dependencies
refactor: simplify login logic
test: add tests for auth module
```

## Workflow

### 1. Nowa Funkcjonalność

```bash
# Utwórz branch z develop
git checkout develop
git pull origin develop
git checkout -b feature/JIRA-123-user-authentication

# Pracuj nad zmianami
git add .
git commit -m "feat: add user authentication"

# Aktualizuj branch
git fetch origin develop
git rebase origin/develop

# Wypchnij zmiany
git push origin feature/JIRA-123-user-authentication

# Utwórz Pull Request do develop
```

### 2. Poprawka Błędu

```bash
# Utwórz branch z develop
git checkout develop
git pull origin develop
git checkout -b bugfix/JIRA-456-login-error

# Napraw błąd
git add .
git commit -m "fix: resolve login error"

# Wypchnij zmiany
git push origin bugfix/JIRA-456-login-error

# Utwórz Pull Request do develop
```

### 3. Hotfix

```bash
# Utwórz branch z main
git checkout main
git pull origin main
git checkout -b hotfix/critical-security-fix

# Napraw błąd
git add .
git commit -m "fix: resolve critical security issue"

# Wypchnij zmiany
git push origin hotfix/critical-security-fix

# Utwórz Pull Request do main i develop
```

## Pull Request

### Szablon PR
```markdown
## Opis
[JIRA-123] Dodanie autentykacji użytkowników

## Typ zmiany
- [ ] Feature
- [ ] Bugfix
- [ ] Hotfix
- [ ] Documentation

## Checklist
- [ ] Testy
- [ ] Code Review
- [ ] Dokumentacja
```

### Code Review
- Minimum jeden zatwierdzający
- Wszystkie testy przechodzą
- CodeQL analiza bez błędów
- Brak konfliktów z develop/main

## Release

### 1. Przygotowanie Release
```bash
git checkout develop
git pull origin develop
git checkout -b release/1.2.0
```

### 2. Stabilizacja
- Testy
- Bugfixy
- Dokumentacja

### 3. Finalizacja
```bash
git checkout main
git merge release/1.2.0
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin main --tags

git checkout develop
git merge release/1.2.0
git push origin develop
```

## Dobre Praktyki

1. **Commity**
   - Używaj conventional commits
   - Jeden commit = jedna zmiana
   - Jasne i zwięzłe opisy

2. **Branche**
   - Krótkotrwałe
   - Jeden cel
   - Regularne rebase z develop

3. **Code Review**
   - Konstruktywne komentarze
   - Sprawdzaj styl kodu
   - Weryfikuj testy

4. **Bezpieczeństwo**
   - Nie commituj sekretów
   - Używaj GitHub Security
   - Regularne aktualizacje zależności 