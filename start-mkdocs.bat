@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Sail's Blog - MkDocs Preview

echo ========================================
echo   Sail's Blog 本地预览
echo ========================================
echo.

py --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 没有找到 Python。
    echo 请先安装 Python，或请 Codex 帮你检查环境。
    echo.
    pause
    exit /b 1
)

py -m mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 没有找到 MkDocs。
    echo 可以运行: py -m pip install mkdocs mkdocs-material
    echo.
    pause
    exit /b 1
)

echo 正在启动网站，请不要关闭这个窗口。
echo 浏览器地址: http://127.0.0.1:8000
echo 如需停止预览，请在这个窗口按 Ctrl+C。
echo.

start "" powershell.exe -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 3; Start-Process 'http://127.0.0.1:8000'"
py -m mkdocs serve --dev-addr 127.0.0.1:8000

echo.
echo MkDocs 预览已停止。
pause
