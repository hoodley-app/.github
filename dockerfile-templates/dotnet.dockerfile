# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /src
COPY ["*.csproj", "./"]
RUN dotnet restore --runtime alpine-x64

COPY . .
RUN dotnet publish -c Release -o /app/publish \
    --no-restore \
    --runtime alpine-x64 \
    --self-contained true \
    /p:PublishTrimmed=true \
    /p:PublishSingleFile=true

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime-deps:9.0-alpine
WORKDIR /app
COPY --from=build /app/publish .

# Optymalizacje dla kontenera
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true \
    ASPNETCORE_URLS=http://+:80 \
    DOTNET_RUNNING_IN_CONTAINER=true \
    DOTNET_EnableDiagnostics=0

EXPOSE 80
ENTRYPOINT ["/app/$PROJECT_NAME"] 