@echo off
cd /d "%~dp0"

set PY=
where py >nul 2>&1 && set PY=py
if not defined PY (where python >nul 2>&1 && python -c "1" >nul 2>&1 && set PY=python)

if not defined PY (
    echo ไม่พบ Python ในเครื่องนี้
    echo ติดตั้งจาก https://www.python.org/downloads/ แล้วติ๊ก "Add python.exe to PATH" ตอนติดตั้ง จากนั้นรันไฟล์นี้ใหม่
    pause
    exit /b 1
)

for /f "tokens=5" %%p in ('netstat -ano ^| findstr :5000 ^| findstr LISTENING') do taskkill /F /PID %%p >nul 2>&1
start "Personnel App Server" cmd /k %PY% -m http.server 5000
timeout /t 2 /nobreak >nul
start "" http://127.0.0.1:5000/index.html
