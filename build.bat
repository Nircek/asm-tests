@echo off
nasm tests.asm -f bin -o tests.bin
if %errorlevel% NEQ 0 (
echo.
echo.
echo You must have NASM in path variable...
pause
)
del tests.vdi
VBoxManage >nul
if %errorlevel% NEQ 0 (
echo.
echo.
echo You must have VirtualBox in path variable...
pause
)
VBoxManage convertfromraw tests.bin tests.vdi --format VDI
VBoxManage storageattach tests --storagectl "IDE Controller" --device 0 --port 0 --medium none
VBoxManage closemedium disk tests.vdi
VBoxManage modifyvm tests --hda "tests.vdi"
VBoxManage startvm tests
