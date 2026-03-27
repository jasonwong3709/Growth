#Requires -Version 5.1
<#
.SYNOPSIS
  Bootstrap ComfyUI + PyTorch (CUDA 12.8) + example checkpoints for the Growth repo (Windows).

.DESCRIPTION
  Run from repository root, e.g.:
    powershell -ExecutionPolicy Bypass -File .\scripts\setup-windows.ps1

  Installs Git/Python via winget if missing, clones ComfyUI, creates venv, installs deps, downloads SD1.5 + SDXL base weights.
#>

$ErrorActionPreference = "Stop"
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

function Refresh-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Ensure-WingetPackage {
  param([string]$Id)
  winget list --id $Id -e 2>$null | Out-Null
  if ($LASTEXITCODE -ne 0) {
    Write-Host "Installing $Id via winget..."
    winget install $Id --accept-package-agreements --accept-source-agreements
    Refresh-Path
  }
}

Write-Host "Repo root: $RepoRoot"
Set-Location $RepoRoot
Refresh-Path

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  Write-Error "winget not found. Install App Installer / Windows Package Manager, then retry."
}

Ensure-WingetPackage "Git.Git"
Ensure-WingetPackage "Python.Python.3.11"
Refresh-Path

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Write-Error "git not available after install." }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { Write-Error "python not available after install." }

$ComfyDir = Join-Path $RepoRoot "ComfyUI"
if (-not (Test-Path $ComfyDir)) {
  Write-Host "Cloning ComfyUI..."
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git $ComfyDir
}

Set-Location $ComfyDir
$VenvPython = Join-Path $ComfyDir "venv\Scripts\python.exe"
if (-not (Test-Path $VenvPython)) {
  Write-Host "Creating venv..."
  python -m venv venv
}

$pip = Join-Path $ComfyDir "venv\Scripts\pip.exe"
& $pip install --upgrade pip
Write-Host "Installing PyTorch (cu128)..."
& $pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
Write-Host "Installing ComfyUI requirements..."
& $pip install -r (Join-Path $ComfyDir "requirements.txt")

& $pip install "huggingface_hub[cli]"

$hfExe = Join-Path $ComfyDir "venv\Scripts\hf.exe"
if (-not (Test-Path $hfExe)) {
  $hfExe = Join-Path $ComfyDir "venv\Scripts\hf.cmd"
}

$ckpt = Join-Path $ComfyDir "models\checkpoints"
New-Item -ItemType Directory -Force -Path $ckpt | Out-Null

Write-Host "Downloading checkpoints (large; may take a while)..."
& $hfExe download runwayml/stable-diffusion-v1-5 v1-5-pruned-emaonly.safetensors --local-dir $ckpt
& $hfExe download stabilityai/stable-diffusion-xl-base-1.0 sd_xl_base_1.0.safetensors --local-dir $ckpt

Write-Host ""
Write-Host "Done. Activate and run:"
Write-Host "  cd `"$ComfyDir`""
Write-Host "  .\venv\Scripts\Activate.ps1"
Write-Host "  python main.py"
Write-Host "Then open http://127.0.0.1:8188"
