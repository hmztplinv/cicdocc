# Base image olarak .NET SDK 6 seçilir
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

# Çalışma dizinini ayarla
WORKDIR /app

# csproj ve restore dosyalarını kopyala
COPY *.csproj ./
RUN dotnet restore

# Tüm projeyi kopyala ve publish yap
COPY . ./
RUN dotnet publish -c Release -o out

# Runtime imajını oluştur
FROM mcr.microsoft.com/dotnet/aspnet:6.0

# Çalışma dizinini ayarla
WORKDIR /app

# Build-env'den dosyaları kopyala
COPY --from=build-env /app/out .

# Uygulamayı çalıştır
ENTRYPOINT ["dotnet", "cicdocc.dll"]
