@echo off
setlocal

set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

if not defined JAVA_HOME (
  set "JAVA_HOME=C:\Users\HP\.jdks\ms-17.0.18"
)

set "PATH=%JAVA_HOME%\bin;%PATH%"
set "GRADLE_USER_HOME=%PROJECT_DIR%.gradle-tmp"
set "TEMP=%PROJECT_DIR%.tmp"
set "TMP=%TEMP%"

if not exist "%GRADLE_USER_HOME%" mkdir "%GRADLE_USER_HOME%"
if not exist "%TEMP%" mkdir "%TEMP%"

if not exist "%PROJECT_DIR%keystore.properties" (
  echo Missing keystore.properties. Copy keystore.properties.example to keystore.properties and fill in your signing values.
  exit /b 1
)

for /f "tokens=1,* delims==" %%A in (keystore.properties) do (
  if /i "%%A"=="storeFile" set "STORE_FILE=%%B"
)

if not defined STORE_FILE (
  echo keystore.properties is missing storeFile.
  exit /b 1
)

if not exist "%PROJECT_DIR%%STORE_FILE%" (
  echo Missing upload keystore: %PROJECT_DIR%%STORE_FILE%
  echo Put your Play upload keystore in the project root or update storeFile in keystore.properties.
  exit /b 1
)

echo Building Play Store bundle...
call ".\gradle-8.2.1\bin\gradle.bat" -Djava.io.tmpdir="%TEMP%" bundleRelease
if errorlevel 1 (
  echo.
  echo Build failed.
  exit /b 1
)

echo.
echo Build successful.
echo AAB: %PROJECT_DIR%app\build\outputs\bundle\release\app-release.aab
echo Version file: %PROJECT_DIR%version.properties
exit /b 0
