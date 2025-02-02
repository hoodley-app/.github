# Hoodley .github

Repozytorium zawierające wspólne konfiguracje, workflow i standardy dla wszystkich projektów Hoodley.

## 🏗 Struktura Repozytorium

```
.github/
├── microservices/           # Mikroserwisy jako submoduły
│   ├── admin/              # Panel administracyjny
│   ├── analytics/          # Analityka i raporty
│   ├── file-storage/       # Zarządzanie plikami
│   ├── identity/           # Autoryzacja i autentykacja
│   └── ...                 # Pozostałe mikroserwisy
├── frontend/               # Aplikacje frontendowe
│   ├── web-client/        # Aplikacja webowa
│   └── mobile-client/     # Aplikacja mobilna
├── bff/                    # Backend-for-Frontend
│   ├── web-api/           # BFF dla aplikacji webowej
│   └── mobile-api/        # BFF dla aplikacji mobilnej
├── shared/                 # Współdzielone zasoby
│   ├── templates/         # Szablony konfiguracyjne
│   └── config/           # Wspólne konfiguracje
├── .github/               # GitHub Actions i konfiguracje
│   ├── actions/          # Reużywalne GitHub Actions
│   ├── workflows/        # GitHub Workflows
│   └── templates/        # Szablony PR i Issues
└── scripts/              # Skrypty pomocnicze
```

## 🛠 Skrypty

### Skrypty Inicjalizacyjne

#### initialize-branches.sh
Tworzy standardową strukturę branchy (main, develop, release).
```bash
./scripts/initialize-branches.sh
```

#### initialize_project.sh
Kompletna inicjalizacja nowego projektu.
```bash
./scripts/initialize_project.sh
```

### Skrypty Konfiguracyjne

#### setup-repo.sh
Konfiguruje repozytorium z wszystkimi wymaganymi plikami.
```bash
./scripts/setup-repo.sh
```

#### add_submodules.sh
Dodaje wszystkie wymagane submoduły.
```bash
./scripts/add_submodules.sh
```

### Skrypty Utrzymania

#### update_all.sh
Aktualizuje całe repozytorium i wszystkie komponenty.
```bash
./scripts/update_all.sh
```

## ⚙️ GitHub Actions

### dotnet-build-test
Uniwersalny action dla projektów .NET:
- Cachowanie pakietów NuGet
- Restore, build i testy
- Obsługa różnych wersji .NET

```yaml
steps:
  - uses: ./.github/actions/dotnet-build-test
```

### node-build-test
Action dla projektów Node.js:
- Cachowanie node_modules
- Instalacja zależności
- Build i testy

```yaml
steps:
  - uses: ./.github/actions/node-build-test
```

## 📋 Workflow Templates

### Szablony CI/CD

#### app-ci.yml
Podstawowy CI dla aplikacji:
- Build i testy
- Analiza kodu (CodeQL)
- Security scan

#### backend-ci.yml
CI dla backendu:
- .NET build i testy
- CodeQL analiza
- Docker build

#### frontend-ci.yml
CI dla frontendów:
- Node.js build
- E2E testy
- Docker build

### Szablony Publikacji

#### docker-publish.yml
Publikacja obrazów Docker:
- Multi-stage build
- Cache layers
- Security scan

### Szablony Kontroli Jakości

#### pr-check.yml
Sprawdzanie pull requestów:
- Conventional commits
- Code review
- Security check

#### semantic-release.yml
Automatyczne release:
- Semantic versioning
- Changelog
- GitHub Releases

## �� Workflow

1. **Nowy Projekt**
   ```bash
   ./scripts/initialize_project.sh
   ```

2. **Dodanie Submodułów**
   ```bash
   ./scripts/add_submodules.sh
   ```

3. **Aktualizacja**
   ```bash
   ./scripts/update_all.sh
   ```

## 📚 Dokumentacja

### Lokalna dokumentacja
- [Git Workflow](./docs/git-workflow.md)
- [CI/CD](./docs/ci-cd.md)
- [Docker](./docs/docker.md)
- [Security](./SECURITY.md)

### Zewnętrzna dokumentacja
- [Dokumentacja projektowa](https://dobrechlopaki.atlassian.net/wiki/spaces/Hoodleyapp/overview)

## 🔑 Sekrety

Projekt wykorzystuje tylko wbudowane sekrety GitHub:

### GITHUB_TOKEN
Automatycznie dostępny w każdym workflow, używany do:
- Publikacji obrazów w GitHub Container Registry
- Publikacji paczek w GitHub Packages
- Autoryzacji w GitHub API
- Code scanning i dependency review

### Uprawnienia
W workflow należy odpowiednio skonfigurować permissions:
```yaml
permissions:
  contents: read   # Dla operacji odczytu
  packages: write  # Dla publikacji paczek/obrazów
  security-events: write # Dla skanów bezpieczeństwa
```

## 🤝 Contributing

1. Fork repozytorium
2. Stwórz feature branch
3. Commituj z conventional commits
4. Utwórz Pull Request

## 🆘 Support

- Issue Tracker: [GitHub Issues](https://github.com/hoodley-app/.github/issues)
- Slack: #dev-support
- Email: dev-support@hoodley.com
