FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY . .
RUN dotnet restore "VillamorLibraryNowAPI/VillamorLibraryNowAPI.csproj"
RUN dotnet publish "VillamorLibraryNowAPI/VillamorLibraryNowAPI.csproj" -c Release -o /app/out --no-restore

FROM base AS final
WORKDIR /app
Copy --from=build /app/out .
ENTRYPOINT ["dotnet", "VillamorLibraryNowAPI.dll"]
