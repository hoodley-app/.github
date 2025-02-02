# Hoodley .github

Repozytorium zawierające wspólne konfiguracje, workflow i standardy dla wszystkich projektów Hoodley.

## 🏗 Struktura Repozytorium

```
.github/
├── actions/                    # Reużywalne GitHub Actions
│   ├── dotnet-build-test/     # Action dla .NET projektów
│   └── node-build-test/       # Action dla Node.js projektów
├── dockerfile-templates/       # Szablony Dockerfile
│   ├── dotnet.dockerfile      # Dla .NET aplikacji
│   └── nextjs.dockerfile      # Dla Next.js aplikacji
├── scripts/                   # Skrypty pomocnicze
│   ├── initialize-branches.sh # Inicjalizacja branchy
│   ├── add_submodules.sh     # Dodawanie submodułów
│   ├── setup-repo.sh         # Konfiguracja repozytorium
│   └── update_all.sh         # Aktualizacja wszystkiego
├── template-files/            # Szablony konfiguracyjne
├── workflow-templates/        # Szablony GitHub Actions
└── docs/                     # Dokumentacja
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

#### initialize_projects.sh
Inicjalizacja wszystkich mikroserwisów.
```bash
./scripts/initialize_projects.sh
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
  - uses: Hoodley/.github/actions/dotnet-build-test@main
```

### node-build-test
Action dla projektów Node.js:
- Cachowanie node_modules
- Instalacja zależności
- Build i testy

```yaml
steps:
  - uses: Hoodley/.github/actions/node-build-test@main
```

## 📋 Workflow Templates

### Szablony CI/CD

#### app-ci.yml
Podstawowy CI dla aplikacji:
- Build i testy
- Analiza kodu
- Security scan

#### backend-ci.yml
CI dla backendu:
- .NET build i testy
- SonarCloud
- Docker build

#### bff-ci.yml
CI dla Backend-for-Frontend:
- .NET/Node.js build
- API testy
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

#### nuget-publish.yml
Publikacja paczek NuGet:
- Wersjonowanie
- Signing
- GitHub Packages

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

## 🔄 Workflow

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
- [Dokumentacja projektowa](https://dobrechlopaki.atlassian.net/wiki/spaces/Hoodleyapp/overview) - Pełna dokumentacja w Atlassian Confluence
- [Dashboard projektowy](https://github.com/orgs/hoodley-app/projects/1) - Zarządzanie zadaniami i postępem prac

## 📦 Repozytoria

### Mikroservisy
- [Hoodley.Admin](https://github.com/hoodley-app/Hoodley.Admin) - Panel administracyjny
- [Hoodley.Analytics](https://github.com/hoodley-app/Hoodley.Analytics) - Analityka i raporty
- [Hoodley.FileStorage](https://github.com/hoodley-app/Hoodley.FileStorage) - Zarządzanie plikami
- [Hoodley.Identity](https://github.com/hoodley-app/Hoodley.Identity) - Autoryzacja i autentykacja
- [Hoodley.Agreements](https://github.com/hoodley-app/Hoodley.Agreements) - Zarządzanie umowami
- [Hoodley.Booking](https://github.com/hoodley-app/Hoodley.Booking) - System rezerwacji
- [Hoodley.Catalog](https://github.com/hoodley-app/Hoodley.Catalog) - Zarządzanie katalogiem
- [Hoodley.Communication](https://github.com/hoodley-app/Hoodley.Communication) - Komunikacja
- [Hoodley.Notification](https://github.com/hoodley-app/Hoodley.Notification) - System powiadomień
- [Hoodley.Payment](https://github.com/hoodley-app/Hoodley.Payment) - Obsługa płatności
- [Hoodley.Review](https://github.com/hoodley-app/Hoodley.Review) - System recenzji
- [Hoodley.Security](https://github.com/hoodley-app/Hoodley.Security) - Bezpieczeństwo
- [Hoodley.Verification](https://github.com/hoodley-app/Hoodley.Verification) - Weryfikacja użytkowników

### Frontend
- [hoodley.web.frontend](https://github.com/hoodley-app/hoodley.web.frontend) - Aplikacja webowa
- [Hoodley.Mobile.Frontend](https://github.com/hoodley-app/Hoodley.Mobile.Frontend) - Aplikacja mobilna

### BFF (Backend For Frontend)
- [Hoodley.Web.BFF](https://github.com/hoodley-app/Hoodley.Web.BFF) - BFF dla aplikacji webowej
- [Hoodley.Mobile.BFF](https://github.com/hoodley-app/Hoodley.Mobile.BFF) - BFF dla aplikacji mobilnej

## 📊 Monitorowanie i Analityka

- **Confluence**: [Dokumentacja projektowa](https://dobrechlopaki.atlassian.net/wiki/spaces/Hoodleyapp/overview)
- **GitHub Projects**: [Dashboard projektowy](https://github.com/orgs/hoodley-app/projects/1)
- **SonarCloud**: Analiza jakości kodu
- **Snyk**: Skanowanie bezpieczeństwa
- **GitHub Security**: Code scanning i dependency review

## 🤝 Contributing

1. Fork repozytorium
2. Stwórz feature branch
3. Commituj z conventional commits
4. Utwórz Pull Request

## 🆘 Support

- Issue Tracker: [GitHub Issues](https://github.com/Hoodley/.github/issues)
- Slack: #dev-support
- Email: dev-support@hoodley.com

## 🔑 Sekrety

Projekt wykorzystuje tylko wbudowane sekrety GitHub:

### GITHUB_TOKEN
Automatycznie dostępny w każdym workflow, używany do:
- Publikacji obrazów w GitHub Container Registry
- Publikacji paczek NuGet w GitHub Packages
- Autoryzacji w GitHub API
- Code scanning i dependency review

Nie wymaga żadnej dodatkowej konfiguracji!

### Uprawnienia
W workflow należy odpowiednio skonfigurować permissions:
```yaml
permissions:
  contents: read   # Dla operacji odczytu
  packages: write  # Dla publikacji paczek/obrazów
```
