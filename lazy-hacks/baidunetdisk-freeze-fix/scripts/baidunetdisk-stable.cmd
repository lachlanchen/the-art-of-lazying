@echo off
setlocal

set "FIX_LAUNCHER=%USERPROFILE%\Projects\the-art-of-lazying\lazy-hacks\baidunetdisk-freeze-fix\scripts\Launch-BaiduNetdiskFixed.ps1"

if not exist "%FIX_LAUNCHER%" (
  echo Baidu Netdisk fixed launcher not found at "%FIX_LAUNCHER%".
  exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%FIX_LAUNCHER%"

endlocal
