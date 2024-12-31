<#
############################################################################
# File: variables.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   Central variable file for managing paths and other configurations.
#
# Usage:
#   .\variables.ps1
#
# Features:
#   - Centralized path management
#
# ISO Standard Documentation
############################################################################
#> 

# Section: Target Installation Paths
$rootDir = "D:\projects\FastAPI-Setup-local"
$requirementsDevPath = "$rootDir\requirements_dev.txt"
$requirementsProdPath = "$rootDir\requirements_prod.txt"
$pythonPath = (Get-Command python).Path
$venvPath = "$rootDir\venv"
$venvPythonPath = "$venvPath\Scripts\python.exe"

# Section: Script Paths
$installRequirementsPath = "$PSScriptRoot\steps\install_requirements.ps1"
$bannerPath = "$PSScriptRoot\steps\banner.ps1"
$checkPythonInstallationPath = "$PSScriptRoot\steps\check_python_installation.ps1"
$completionMessagePath = "$PSScriptRoot\steps\completion_message.ps1"
$configPath = "$PSScriptRoot\steps\config.ps1"
$initializeScriptEnvironmentPath = "$PSScriptRoot\steps\initialize_script_environment.ps1"
$promptVenvInstallationPath = "$PSScriptRoot\steps\prompt_venv_installation.ps1"
$setupVirtualEnvironmentPath = "$PSScriptRoot\steps\setup_virtual_environment.ps1"
$venvSetupPath = "$PSScriptRoot\steps\venv_setup.ps1"

# Section: Demo URLs
$localhost8000 = "http://localhost:8000"
$localhost8000Docs = "http://localhost:8000/docs"
$localhost8000Redoc = "http://localhost:8000/redoc"

# Section: Commands
$defaultServerCommand = "$venvPythonPath -m uvicorn main:app --reload --app-dir $rootDir"
$customPortCommand = "$venvPythonPath -m uvicorn main:app --reload --port 5000 --app-dir $rootDir"
$networkAccessCommand = "$venvPythonPath -m uvicorn main:app --reload --host 0.0.0.0 --port 8000 --app-dir $rootDir"
