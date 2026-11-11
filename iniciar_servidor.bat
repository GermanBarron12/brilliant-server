@echo off
rem Levanta el servidor con un solo comando: instala dependencias, aplica
rem las migraciones de la base y lo deja corriendo.
rem
rem Uso:
rem   iniciar_servidor.bat
rem   iniciar_servidor.bat http://192.168.1.50:5173
rem
rem El parametro opcional es el CORS_ORIGIN (el origen del cliente web, si
rem se va a probar desde un navegador). Si no se pasa nada, usa
rem http://localhost:5173. Los clientes nativos (Android/iOS) no necesitan
rem esto.

setlocal
cd /d "%~dp0"

set CORS_ORIGIN=%1
if "%CORS_ORIGIN%"=="" set CORS_ORIGIN=http://localhost:5173

echo Usando CORS_ORIGIN=%CORS_ORIGIN%

call dart pub get
if errorlevel 1 goto :error

call dart run bin/migrar.dart
if errorlevel 1 goto :error

dart run bin/servidor.dart
goto :fin

:error
echo.
echo Algo fallo antes de levantar el servidor. Revisa el mensaje de arriba.
exit /b 1

:fin
endlocal
