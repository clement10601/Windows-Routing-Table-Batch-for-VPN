@set str_ip=%output%
@set str_mask=255.255.0.0
@set gameip_list=(202.213.0.0 203.69.0.0 202.169.0.0 113.192.0.0 111.64.0.0)

@for /F "delims=" %%a in ('ver') do @set ver=%%a
@if "%ver:5.=%" neq "%ver%" goto WinXP
@goto Win7

:WinXP
@for /f "tokens=15" %%i in ('ipconfig ^| findstr /c:"192.168.240"') do @set output=%%i
@set str_ip=%output%
@echo 系統是XP
@goto RUNPG

:Win7
@for /f "tokens=16" %%i in ('ipconfig ^| findstr /c:"192.168.240"') do @set output=%%i
@set str_ip=%output%
@echo 系統是Win7
@goto RUNPG

:RUNPG
@echo off
@echo ##########################
@echo _____VPN連接 20140620_____
@echo ##########################
@echo 每次開遊戲前都要執行喔!!
@echo 目前支持 日版FEZ 鋼彈online
@echo.
echo 1:執行連線設定
echo 2:清除連線設定
set /p input="請輸入:" 
if %input%==1 (
call :nul
call :setup)
if %input%==2 (goto nul)

:setup
for %%i in %gameip_list% do (@route add %%i mask %str_mask% %str_ip%)
@echo 連線設定成功
@echo.
goto endd

:nul 
@echo.
for %%i in %gameip_list% do (@route delete %%i)
@echo 初始成功!
GOTO :EOF

:endd
@set input=0
exit