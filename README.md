# Hoodley .github

Repozytorium zawierające wspólne konfiguracje, workflow i standardy dla wszystkich projektów Hoodley.

## 🏗 Struktura

```
.github/
├── actions/                    # Reużywalne GitHub Actions
├── dockerfile-templates/       # Szablony Dockerfile
├── scripts/                   # Skrypty pomocnicze
├── template-files/            # Szablony konfiguracyjne
├── workflow-templates/        # Szablony GitHub Actions
└── docs/                     # Dokumentacja
```

## 🔄 CI/CD Pipeline

1. **Pull Request**
   - Budowanie
   - Testy
   - Linting
   - Conventional commits check
   - SonarCloud analiza
   - Security scan

2. **Main/Release**
   - Wszystkie PR checks
   - Docker build & push
   - Semantic release
   - Deployment (jeśli skonfigurowany)

## 📋 Pull Request Guidelines

1. **Tytuł**: Użyj conventional commits
   ```
   feat(auth): implementacja Google OAuth
   ```

2. **Opis**:
   - Co zostało zmienione
   - Dlaczego zmiana była potrzebna
   - Jak przetestować
   - Breaking changes (jeśli są)

3. **Checklist**:
   - [ ] Testy
   - [ ] Dokumentacja
   - [ ] Breaking changes oznaczone
   - [ ] Code review

## 🔒 Security

- Podatności zgłaszaj na security@hoodley.com
- Nie commituj sekretów i credentiali
- Używaj skanowania Snyk i SonarCloud
- Regularnie aktualizuj zależności

## 🤝 Contributing

1. Fork repozytorium
2. Stwórz feature branch
3. Commituj z conventional commits
4. Utwórz Pull Request

## 📚 Dodatkowa Dokumentacja

- [Git Workflow](./docs/git-workflow.md)
- [CI/CD](./docs/ci-cd.md)
- [Docker](./docs/docker.md)
- [Security](./SECURITY.md)

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
