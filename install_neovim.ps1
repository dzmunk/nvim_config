# Usage:
#   .\install_neovim.ps1
#   .\install_neovim.ps1 --uninstall

$ErrorActionPreference = "Stop"

$DIR     = "$env:USERPROFILE\neovim"
$INSTALL = "$env:LOCALAPPDATA\Programs\Neovim"
$BUILD   = Join-Path $DIR "build"
$BIN     = Join-Path $INSTALL "bin"
$DEPS    = Join-Path $DIR ".deps"

if ($args -contains "--uninstall") {
  if (Test-Path $INSTALL) { Remove-Item -Recurse -Force $INSTALL }
  exit 0
}

if (Test-Path (Join-Path $DIR ".git")) {
  git -C $DIR fetch --tags --force
} else {
  New-Item -ItemType Directory -Force -Path (Split-Path $DIR) | Out-Null
  git clone https://github.com/neovim/neovim.git $DIR
}

git -C $DIR -c advice.detachedHead=false checkout -f nightly
git -C $DIR reset --hard nightly

if (Test-Path $BUILD) { Remove-Item -Recurse -Force $BUILD }
New-Item -ItemType Directory -Force -Path $BUILD | Out-Null

cmake -S (Join-Path $DIR "cmake.deps") -B $DEPS -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build $DEPS --config Release --parallel

cmake -S $DIR -B $BUILD -G Ninja `
  -DCMAKE_BUILD_TYPE=Release `
  -DCMAKE_INSTALL_PREFIX="$INSTALL" `
  -DCMAKE_PREFIX_PATH="$(Join-Path $DEPS 'usr')" `
  -DUSE_BUNDLED=ON

cmake --build $BUILD --config Release
cmake --install $BUILD

$uPath = [Environment]::GetEnvironmentVariable("PATH","User")
if ($uPath -notlike "*$BIN*") {
  [Environment]::SetEnvironmentVariable("PATH", (($uPath + ";$BIN").Trim(";")), "User")
  $env:PATH = "$env:PATH;$BIN"
  Write-Host "Added to PATH (User): $BIN"
} else {
  Write-Host "Already on PATH: $BIN"
}

& (Join-Path $INSTALL "bin\nvim.exe") --version | Select-Object -First 3
