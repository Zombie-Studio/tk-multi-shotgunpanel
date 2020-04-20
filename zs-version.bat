@Echo off
cls
set release =

for /f %%a in ('git branch --show-current') do set branch=%%a
for /f %%b in ('git describe --tags --abbrev^=0 origin/%branch%') do ( set release=%%b )

echo -------------------------------------------------------
echo  UPDATE GIT FOR REMOTE
echo -------------------------------------------------------
echo.
git fetch
echo.
echo -------------------------------------------------------
echo  1 - MANAGING RELEASE ZOMBIE STUDIO PIPELINE
echo -------------------------------------------------------
echo  - BRANCH: %branch%
echo  - LAST RELEASE: %release%
echo.
echo -------------------------------------------------------
echo  2 - CHECKING UPDATE IN BRANCH %branch%
echo -------------------------------------------------------

echo  - UPDATE BRANCH %branch%
echo -------------------------------------------------------
echo.
git add . && git commit -am "UPDATE FILES AT THE BRANCH %branch%"
echo.
echo -------------------------------------------------------
echo  3 - PUSH BRANCH %branch% FOR GITHUB
echo -------------------------------------------------------
echo.
git push origin %branch%
echo.
echo -------------------------------------------------------
echo  4 - CREATE RELEASE FOR BRANCH %branch%
echo -------------------------------------------------------
echo.
echo  - LAST RELEASE REFERENCE: %release%
echo.

set /p version=Insert release version:
set release_version="v%version%"
git tag -a %release_version% -m "CREATE NEW RELEASE %release_version%"
echo -------------------------------------------------------
echo  4 - PUBLISH RELEASE %release_version% FROM %branch%
echo -------------------------------------------------------
git push origin %release_version%
echo -------------------------------------------------------
echo  BRANCH: %branch%
echo  LAST RELEASE: %release%
echo  NEW RELEASE: %version%
echo  DATE: %date%
echo -------------------------------------------------------
echo.

set version
set release
set release_version