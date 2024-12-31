<#
############################################################################
# File: setup.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for installing FastAPI framework with development and
#   production mode options. Handles virtual environment creation, package
#   installation, and environment configuration.
#
# Usage:
#   .\setup.ps1
#
# Features:
#   - Virtual environment creation and activation
#   - Development/Production mode selection
#   - Automated package installation
#   - Error handling and validation
#
# Version: 1.0.0
# Last Updated: 2024-01-20
#
# Copyright (c) 2024 Stride Information Technology LLC
# Licensed under the MIT License
#
# ISO/IEC 25010:2011 Compliance:
# - Functional Suitability
# - Reliability
# - Maintainability
############################################################################
#>

<#
.SYNOPSIS
    FastAPI installation script with development and production mode support.

.DESCRIPTION
    This script automates the installation process of FastAPI framework by:
    1. Creating and activating a virtual environment (optional)
    2. Installing required packages based on selected mode
    3. Configuring the development environment

.NOTES
    Version: 1.0.0
    Updated: 2024-01-20
#>

# Load all required components
. "$PSScriptRoot\variables.ps1"
. "$PSScriptRoot\steps\config.ps1"
. "$PSScriptRoot\steps\check_python_installation.ps1"
. "$PSScriptRoot\steps\prompt_venv_installation.ps1"
. "$PSScriptRoot\steps\setup_virtual_environment.ps1"
. "$PSScriptRoot\steps\install_requirements.ps1"
. "$PSScriptRoot\steps\banner.ps1"
. "$PSScriptRoot\steps\completion_message.ps1"

# Display welcome banner
Show-WelcomeBanner

# Verify Python installation
$pythonPath = Test-PythonInstallation

# Handle virtual environment setup
$venvChoice = Request-VenvInstallation
if ($venvChoice -eq "yes" -or $venvChoice -eq "y") {
    Initialize-VirtualEnvironment -rootDir $rootDir -pythonPath $pythonPath
}
else {
    Write-Host "`nSkipping virtual environment installation..." -ForegroundColor Yellow
    Write-Host "Continuing with basic setup..." -ForegroundColor Cyan
}

# Installation Mode Selection
Write-Host "`nSelect installation mode:" -ForegroundColor Yellow
Write-Host "Options:" -ForegroundColor Cyan
Write-Host "  1 - Development" -ForegroundColor Green
Write-Host "  2 - Production" -ForegroundColor Magenta

do {
    $modeChoice = Read-Host "`nEnter your choice (1/2)"
    if ($modeChoice -ne "1" -and $modeChoice -ne "2") {
        Write-Host "Invalid input. Please enter either '1' or '2'" -ForegroundColor Red
    }
} while ($modeChoice -ne "1" -and $modeChoice -ne "2")

# Execute installation based on mode selection
if ($modeChoice -eq "1") {
    Write-Host "`nStarting Development Installation..." -ForegroundColor Green
    Install-Requirements -mode "development"
    Write-Host "`nDevelopment Installation Completed Successfully!" -ForegroundColor Green
}
elseif ($modeChoice -eq "2") {
    Write-Host "`nStarting Production Installation..." -ForegroundColor Cyan
    Install-Requirements -mode "production"
    Write-Host "`nProduction Installation Completed Successfully!" -ForegroundColor Cyan
}
else {
    Write-Host "`nError: Invalid installation mode selected." -ForegroundColor Red
    Exit 1
}

# Show completion message
Show-CompletionMessage
