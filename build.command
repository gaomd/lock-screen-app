cd "$(dirname "$0")"

osacompile -o 'Lock Screen.app' 'Lock Screen.applescript'
cp Lock\ Screen.icns Lock\ Screen.app/Contents/Resources/applet.icns 
touch Lock\ Screen.app/Contents/Resources/applet.icns 

osacompile -o 'Lock Screensaver.app' 'Lock Screensaver.applescript'
cp Lock\ Screen.icns Lock\ Screensaver.app/Contents/Resources/applet.icns 
touch Lock\ Screensaver.app/Contents/Resources/applet.icns

# clang -framework Foundation main.m -o lockscreen
osacompile -o 'Lock Screen Bundle.app' 'Lock Screen Bundle.applescript'
cp Lock\ Screen.icns Lock\ Screen\ Bundle.app/Contents/Resources/applet.icns 
touch Lock\ Screen\ Bundle.app/Contents/Resources/applet.icns
cp lockscreen Lock\ Screen\ Bundle.app/Contents/Resources/Scripts/lockscreen
