@echo off
setlocal

set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

if not defined JAVA_HOME (
  set "JAVA_HOME=C:\Users\HP\.jdks\ms-17.0.18"
)

set "KEYTOOL=%JAVA_HOME%\bin\keytool.exe"
if not exist "%KEYTOOL%" (
  echo keytool not found at %KEYTOOL%
  exit /b 1
)

if exist "%PROJECT_DIR%upload-keystore.jks" (
  echo upload-keystore.jks already exists. Delete or rename it before creating a new upload key.
  exit /b 1
)

set /p STORE_PASSWORD=Enter upload keystore password: 
if "%STORE_PASSWORD%"=="" (
  echo Password is required.
  exit /b 1
)

set /p KEY_PASSWORD=Enter upload key password ^(press Enter to reuse keystore password^): 
if "%KEY_PASSWORD%"=="" set "KEY_PASSWORD=%STORE_PASSWORD%"

set /p CN=Common Name ^(person or company^): 
if "%CN%"=="" set "CN=Dclub"

set /p OU=Organizational Unit: 
if "%OU%"=="" set "OU=Mobile"

set /p O=Organization: 
if "%O%"=="" set "O=Dclub"

set /p L=City or Locality: 
if "%L%"=="" set "L=Doha"

set /p ST=State or Province: 
if "%ST%"=="" set "ST=Doha"

set /p C=Two-letter country code: 
if "%C%"=="" set "C=QA"

set "DNAME=CN=%CN%, OU=%OU%, O=%O%, L=%L%, S=%ST%, C=%C%"

"%KEYTOOL%" -genkeypair ^
  -v ^
  -keystore "%PROJECT_DIR%upload-keystore.jks" ^
  -alias upload ^
  -keyalg RSA ^
  -keysize 2048 ^
  -validity 9125 ^
  -storepass "%STORE_PASSWORD%" ^
  -keypass "%KEY_PASSWORD%" ^
  -dname "%DNAME%"

if errorlevel 1 (
  echo Failed to create upload keystore.
  exit /b 1
)

(
  echo storeFile=upload-keystore.jks
  echo storePassword=%STORE_PASSWORD%
  echo keyAlias=upload
  echo keyPassword=%KEY_PASSWORD%
) > "%PROJECT_DIR%keystore.properties"

echo.
echo Upload keystore created:
echo %PROJECT_DIR%upload-keystore.jks
echo keystore.properties updated.
exit /b 0
