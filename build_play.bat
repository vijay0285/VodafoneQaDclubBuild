@echo off
setlocal

set "PROJECT_DIR=%~dp0"
cd /d "%PROJECT_DIR%"

if not defined JAVA_HOME (
  set "JAVA_HOME=C:\Users\HP\.jdks\ms-17.0.18"
)

set "PATH=%JAVA_HOME%\bin;%PATH%"

echo Building Play Store bundle...
call ".\gradle-8.2.1\bin\gradle.bat" bundleRelease
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
