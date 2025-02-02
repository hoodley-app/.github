# Konfiguracja Repozytoriów

## Pliki Konfiguracyjne

Wszystkie pliki konfiguracyjne znajdują się w głównym katalogu repozytorium `.github`.

### 1. Dependabot (`dependabot.yml`)

Konfiguruje automatyczne aktualizacje zależności.

```yaml
version: 2
updates:
  - package-ecosystem: "nuget"    # Ekosystem pakietów
    directory: "/"                # Katalog z plikami projektu
    schedule:
      interval: "weekly"          # Częstotliwość sprawdzania
    groups:                       # Grupowanie aktualizacji
      dependencies:
        patterns:
          - "*"                   # Wszystkie zależności w jednym PR

  - package-ecosystem: "npm"      # Analogicznie dla npm
    directory: "/"
    schedule:
      interval: "weekly"
    groups:
      dependencies:
        patterns:
          - "*"

  - package-ecosystem: "docker"   # Aktualizacje obrazów Docker
    directory: "/"
    schedule:
      interval: "weekly"
```

#### Jak używać:
1. Skopiuj plik do `.github/dependabot.yml` w swoim repozytorium
2. Dostosuj ekosystemy (`nuget`, `npm`, `docker`) do potrzeb projektu
3. Ustaw odpowiednią częstotliwość (`daily`, `weekly`, `monthly`)
4. Opcjonalnie skonfiguruj grupowanie aktualizacji

### 2. Branch Protection (`branch-protection.yml`)

Konfiguruje zasady ochrony branchy.

```yaml
branches:
  - name: main                    # Nazwa brancha
    protection:
      required_pull_request_reviews:
        required_approving_review_count: 1  # Wymagana liczba zatwierdzeń
      required_status_checks:
        strict: true             # Wymaga aktualności z bazowym branchem
        contexts:                # Wymagane testy
          - 'build-and-test'
          - 'CodeQL'
          - 'Dependency Review'
          - 'Security Scan'
      enforce_admins: true       # Zasady dotyczą też adminów
```

#### Jak używać:
1. Skopiuj plik do `.github/branch-protection.yml`
2. Dostosuj zasady dla każdego chronionego brancha
3. Skonfiguruj wymagane status checks
4. Ustaw wymaganą liczbę code review
5. Włącz/wyłącz wymuszanie dla adminów

### 3. Konfiguracja Organizacji (`config.yml`)

Główny plik konfiguracyjny dla całej organizacji.

```yaml
repository:
  default:
    # Konfiguracja ochrony branchy
    branch_protection:
      main:
        required_pull_request_reviews:
          required_approving_review_count: 1
    
    # Domyślne etykiety
    labels:
      - name: 'bug'
        color: 'd73a4a'
        description: 'Coś nie działa'

# Ustawienia dla semantic-release
semantic_release:
  branches: 
    - main
    - name: release
      prerelease: true

# Ustawienia dla GitHub Actions
actions:
  environment:
    node-version: 'lts/*'
    dotnet-version: '9.0.x'
```

#### Jak używać:
1. Skopiuj plik do `.github/config.yml`
2. Dostosuj ustawienia repozytoriów
3. Skonfiguruj etykiety
4. Ustaw zasady dla semantic-release
5. Skonfiguruj środowisko dla GitHub Actions

## Implementacja

### Nowe Repozytorium

```bash
# 1. Sklonuj repozytorium .github
git clone https://github.com/hoodley-app/.github.git

# 2. Skopiuj pliki konfiguracyjne
cp .github/dependabot.yml /sciezka/do/twojego/repo/.github/
cp .github/branch-protection.yml /sciezka/do/twojego/repo/.github/
cp .github/config.yml /sciezka/do/twojego/repo/.github/

# 3. Dostosuj konfigurację
# Edytuj pliki według potrzeb projektu

# 4. Zatwierdź zmiany
git add .github/
git commit -m "chore: add repository configuration"
git push
```

### Aktualizacja Konfiguracji

```bash
# 1. Pobierz najnowsze zmiany z .github
git clone https://github.com/hoodley-app/.github.git
cd .github

# 2. Porównaj i zaktualizuj pliki
diff .github/dependabot.yml /sciezka/do/twojego/repo/.github/dependabot.yml
diff .github/branch-protection.yml /sciezka/do/twojego/repo/.github/branch-protection.yml
diff .github/config.yml /sciezka/do/twojego/repo/.github/config.yml

# 3. Skopiuj zaktualizowane pliki
cp .github/dependabot.yml /sciezka/do/twojego/repo/.github/
# itd.

# 4. Zatwierdź zmiany
git add .github/
git commit -m "chore: update repository configuration"
git push
```

## Dobre Praktyki

1. **Regularne Aktualizacje**
   - Sprawdzaj aktualizacje plików konfiguracyjnych
   - Synchronizuj z głównym repozytorium .github

2. **Dostosowanie do Projektu**
   - Modyfikuj ustawienia według potrzeb
   - Nie kopiuj ślepo wszystkich ustawień

3. **Dokumentacja Zmian**
   - Dokumentuj niestandardowe ustawienia
   - Wyjaśniaj powody odstępstw od standardów

4. **Monitorowanie**
   - Sprawdzaj działanie Dependabota
   - Weryfikuj skuteczność branch protection
   - Monitoruj GitHub Actions 