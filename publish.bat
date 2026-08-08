@echo off
setlocal
chcp 65001 >nul
cd /d "%~dp0"
title Sail's Blog - Publish to GitHub

echo ========================================
echo   Sail's Blog 检查、提交并发布
echo ========================================
echo.

if not exist "mkdocs.yml" (
    echo [错误] 当前目录中没有 mkdocs.yml。
    echo 请把这个脚本放在 E:\mywebsite 目录中。
    echo.
    pause
    exit /b 1
)

if not exist ".git" (
    echo [错误] 当前目录不是 Git 仓库。
    echo.
    pause
    exit /b 1
)

echo [1/5] 检查 Python 和 MkDocs...
py -m mkdocs --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 没有找到 MkDocs。
    echo 可以运行: py -m pip install mkdocs mkdocs-material
    echo.
    pause
    exit /b 1
)

echo [2/5] 检查 GitHub 上是否有更新的版本...
git fetch origin
if errorlevel 1 (
    echo [错误] 无法连接 GitHub。请检查网络或登录状态。
    echo.
    pause
    exit /b 1
)

git merge-base --is-ancestor origin/main HEAD
if errorlevel 1 (
    echo [错误] GitHub 上有本地还没有的新版本。
    echo 请先运行: git pull --ff-only origin main
    echo 成功后再重新双击本脚本。
    echo.
    pause
    exit /b 1
)

echo [3/5] 检查网站能否正常构建...
py -m mkdocs build --strict
if errorlevel 1 (
    echo.
    echo [错误] 网站构建失败，已取消提交和推送。
    echo 请检查上方的错误信息。
    echo.
    pause
    exit /b 1
)

set "HAS_CHANGES="
for /f "delims=" %%i in ('git status --porcelain') do set "HAS_CHANGES=1"

if not defined HAS_CHANGES (
    echo.
    echo 没有需要提交的新修改。
    echo.
    pause
    exit /b 0
)

echo.
echo [4/5] 本次将要提交的变动:
git status --short
echo.
echo 请确认上面没有密码、令牌或其他私密文件。
echo.

set "COMMIT_MSG="
set /p "COMMIT_MSG=请输入本次修改说明: "
if not defined COMMIT_MSG set "COMMIT_MSG=Update website content"

set "CONFIRM="
set /p "CONFIRM=确认提交并推送到 GitHub? 输入 Y 继续: "
if /i not "%CONFIRM%"=="Y" (
    echo.
    echo 已取消，本地文件保持不变。
    echo.
    pause
    exit /b 0
)

git add --all
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo.
    echo [错误] 创建提交失败，未执行推送。
    echo.
    pause
    exit /b 1
)

echo.
echo [5/5] 推送到 GitHub main 分支...
git push origin main
if errorlevel 1 (
    echo.
    echo [错误] 推送失败。本地提交已保留，不会丢失。
    echo 请根据上方信息检查网络或 GitHub 登录。
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   推送完成！
echo ========================================
echo GitHub Actions 会自动发布网站。
echo 通常等待 1 到 3 分钟即可看到更新。
echo 网站: https://saillll98.github.io/
echo.
pause
