@echo off

:: Change directory to etherpad-lite root
cd /D "%~dp0\.."

:: Is node installed?
cmd /C node -e "" || ( echo "Please install node.js ( https://nodejs.org )" && exit /B 1 )

echo _
echo Ensure that all dependencies are up to date...  If this is the first time you have run Etherpad please be patient.
cmd /C npm install src/ --loglevel warn || exit /B 1

echo _
echo Copying custom templates...
set custom_dir=node_modules\ep_etherpad-lite\static\custom
FOR %%f IN (index pad timeslider) DO (
  if NOT EXIST "%custom_dir%\%%f.js" copy "%custom_dir%\js.template" "%custom_dir%\%%f.js"
  if NOT EXIST "%custom_dir%\%%f.css" copy "%custom_dir%\css.template" "%custom_dir%\%%f.css"
)

echo _
echo Clearing cache...
del /S var\minified*

echo _
echo Setting up settings.json...
IF NOT EXIST settings.json (
  echo Can't find settings.json.
  echo Copying settings.json.template...
  cmd /C copy settings.json.template settings.json || exit /B 1
)

echo _
echo Installed Etherpad!  To run Etherpad type start.bat
