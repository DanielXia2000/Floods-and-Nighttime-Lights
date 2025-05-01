@echo off
::  字符编码
:: 适配汉语
chcp 65001 >nul

:: ① Token（请保持一整行）
set "TOKEN=eXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
:: ② 输出根目录
set "OUTROOT=E:\RawData"
:: ③ 配对文件（NUM YEAR）
set "PAIRFILE=%~dp0pairs.txt"

echo(
echo ===开始批量下载 ===
echo(

:: 循环
setlocal enabledelayedexpansion

for /f "usebackq tokens=1,2" %%A in ("%PAIRFILE%") do (
    set "NUM=%%A"
    set "YEAR=%%B"

    echo [!NUM! !YEAR!] 正在下载...
    wget -e robots=off -m -np -R .html,.tmp -nH --cut-dirs=3 ^
        "https://ladsweb.modaps.eosdis.nasa.gov/archive/orders/!NUM!/" ^
        --header "Authorization: Bearer !TOKEN!" ^
        -P "!OUTROOT!\!YEAR!"
)

echo(
echo === 全部完成 ===
pause >nul
