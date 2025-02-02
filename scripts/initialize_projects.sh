#!/bin/bash

# Lista mikroserwisów i ich repozytoriów
declare -A microservices=(
  ["Hoodley.Admin"]="https://github.com/hoodley-app/Hoodley.Admin.git"
  ["Hoodley.Analytics"]="https://github.com/hoodley-app/Hoodley.Analytics.git"
  ["Hoodley.Agreements"]="https://github.com/hoodley-app/Hoodley.Agreements.git"
  ["Hoodley.Booking"]="https://github.com/hoodley-app/Hoodley.Booking.git"
  ["Hoodley.Catalog"]="https://github.com/hoodley-app/Hoodley.Catalog.git"
  ["Hoodley.Communication"]="https://github.com/hoodley-app/Hoodley.Communication.git"
  ["Hoodley.FileStorage"]="https://github.com/hoodley-app/Hoodley.FileStorage.git"
  ["Hoodley.Identity"]="https://github.com/hoodley-app/Hoodley.Identity.git"
  ["Hoodley.Mobile.BFF"]="https://github.com/hoodley-app/Hoodley.Mobile.BFF.git"
  ["Hoodley.Mobile.Frontend"]="https://github.com/hoodley-app/Hoodley.Mobile.Frontend.git"
  ["Hoodley.Notification"]="https://github.com/hoodley-app/Hoodley.Notification.git"
  ["Hoodley.Payment"]="https://github.com/hoodley-app/Hoodley.Payment.git"
  ["Hoodley.Review"]="https://github.com/hoodley-app/Hoodley.Review.git"
  ["Hoodley.Security"]="https://github.com/hoodley-app/Hoodley.Security.git"
  ["Hoodley.Verification"]="https://github.com/hoodley-app/Hoodley.Verification.git"
  ["Hoodley.Web.BFF"]="https://github.com/hoodley-app/Hoodley.Web.BFF.git"
  ["Hoodley.Web.Frontend"]="https://github.com/hoodley-app/Hoodley.Web.Frontend.git"
  # ["Hoodley.Search"]="https://github.com/hoodley-app/Hoodley.Search.git" # Opcjonalny
  # ["Hoodley.Logging"]="https://github.com/hoodley-app/Hoodley.Logging.git" # Opcjonalny
)

# Funkcja do dodawania submodule
add_submodule() {
  local name=$1
  local url=$2
  echo "Dodawanie submodule: $name z repozytorium $url"
  
  # Dodaj submodule
  git submodule add "$url" "$name"
  
  if [ $? -ne 0 ]; then
    echo "Błąd podczas dodawania submodule: $name"
    exit 1
  fi
}

# Funkcja do inicjalizacji i aktualizacji submodules
init_update_submodules() {
  echo "Inicjalizacja i aktualizacja submodules..."
  git submodule update --init --recursive
}

# Funkcja do tworzenia Dockerfile i README.md
setup_project_files() {
  local ms=$1
  echo "Tworzenie plików dla $ms..."
  
  # Dockerfile
  cat > "$ms/Dockerfile" <<EOL
# Dockerfile for $ms.Api
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["$ms.Api/$ms.Api.csproj", "$ms.Api/"]
COPY ["$ms.Application/$ms.Application.csproj", "$ms.Application/"]
COPY ["$ms.Domain/$ms.Domain.csproj", "$ms.Domain/"]
COPY ["$ms.Infrastructure/$ms.Infrastructure.csproj", "$ms.Infrastructure/"]
RUN dotnet restore "$ms.Api/$ms.Api.csproj"
COPY . .
WORKDIR "/src/$ms.Api"
RUN dotnet build "$ms.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "$ms.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "$ms.Api.dll"]
EOL

  # README.md
  echo "# $ms" > "$ms/README.md"
  echo "## Description" >> "$ms/README.md"
  echo "$ms microservice for Hoodley.app." >> "$ms/README.md"
}

# Iteruj przez wszystkie mikroserwisy, dodaj submodules i skonfiguruj pliki
for ms in "${!microservices[@]}"; do
  add_submodule "$ms" "${microservices[$ms]}"
  setup_project_files "$ms"
done

# Inicjalizuj i aktualizuj submodules
init_update_submodules

# Zatwierdź zmiany
git add .
git commit -m "Initialize all microservices with submodules, Dockerfiles, and README.md"

# Opcjonalnie: Push zmian do zdalnego repozytorium
echo "Czy chcesz wypchnąć zmiany do zdalnego repozytorium? (y/n)"
read -r push_changes
if [ "$push_changes" = "y" ] || [ "$push_changes" = "Y" ]; then
  git push origin main
fi

echo "Proces inicjalizacji mikroserwisów zakończony pomyślnie."
