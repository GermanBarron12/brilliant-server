# Levanta el servidor con un solo comando: instala dependencias, aplica
# las migraciones de la base y lo deja corriendo.
#
# Uso:
#   .\iniciar_servidor.ps1
#   .\iniciar_servidor.ps1 -CorsOrigin "http://192.168.1.50:5173"
#
# -CorsOrigin es el origen del cliente web, si se va a probar desde un
# navegador (por defecto http://localhost:5173). Los clientes nativos
# (Android/iOS) no necesitan esto.

param(
    [string]$CorsOrigin = "http://localhost:5173"
)

$ErrorActionPreference = "Stop"
Push-Location $PSScriptRoot

Write-Host "Usando CORS_ORIGIN=$CorsOrigin" -ForegroundColor Cyan

dart pub get
dart run bin/migrar.dart

$env:CORS_ORIGIN = $CorsOrigin
dart run bin/servidor.dart

Pop-Location
