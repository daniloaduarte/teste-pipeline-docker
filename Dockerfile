# Etapa 1 - Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia apenas o csproj para restaurar as dependências
COPY C:\Sistemas\teste docker\src\MeuApi\MeuApi.csproj
RUN dotnet restore MeuApi.csproj

# Copia o restante do código
COPY minha-api/. .
RUN dotnet publish -c Release -o /app

# Etapa 2 - Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app ./

ENTRYPOINT ["dotnet", "MeuApi.dll"]
