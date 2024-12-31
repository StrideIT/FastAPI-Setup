<#
############################################################################
# File: install_requirements.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for managing Python package installations in the FastAPI
#   framework environment. Handles both development and production dependencies,
#   including package installation, validation, and environment verification.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Automated pip upgrade
#   - Development/Production mode support
#   - Package installation from requirements files
#   - Installation validation
#   - Comprehensive error handling
#   - Environment verification
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
# - Performance Efficiency
# - Maintainability
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Python Package Installation: https://pip.pypa.io/en/stable/cli/pip_install/
# - FastAPI Documentation: https://fastapi.tiangolo.com/
############################################################################
#>

<#
.SYNOPSIS
    Install and validate Python package requirements for FastAPI setup.

.DESCRIPTION
    Manages the installation of Python packages based on the specified mode
    (development or production). The function:
    1. Upgrades pip to the latest version
    2. Installs packages from the appropriate requirements file
    3. Validates the installation
    4. Verifies the environment setup
    
    Includes comprehensive error handling and validation at each step.

.PARAMETER requirementsFile
    The path to the requirements file. This is automatically determined based
    on the mode parameter but can be overridden if needed.

.PARAMETER mode
    The installation mode. Must be either "development" or "production".
    Determines which requirements file to use and affects the installation process.

.OUTPUTS
    None. The function uses Write-Host for progress updates and exits with
    code 1 if any critical operation fails.

.EXAMPLE
    Install-Requirements -mode "development"
    Installs development requirements from requirements_dev.txt

.EXAMPLE
    Install-Requirements -mode "production"
    Installs production requirements from requirements_prod.txt

.NOTES
    - Requires an active virtual environment
    - Needs internet connection for package downloads
    - May require significant disk space depending on requirements
    - Automatically handles pip upgrades
    - Validates FastAPI installation

.LINK
    https://fastapi.tiangolo.com/
#>
function Install-Requirements {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$requirementsFile,

        [Parameter(Mandatory = $true)]
        [ValidateSet("development", "production")]
        [string]$mode
    )

    # Import required variables
    . "$PSScriptRoot\..\variables.ps1"

    try {
        Write-Host "`nStarting $mode environment installation..." -ForegroundColor Yellow

        # Get requirements file path based on mode
        $requirementsFile = if ($mode -eq "development") {
            $requirementsDevPath
        }
        else {
            $requirementsProdPath
        }

        Write-Host "Using requirements file: $requirementsFile" -ForegroundColor Cyan

        # Validate requirements file exists
        if (-not (Test-Path $requirementsFile)) {
            Write-Host "Error: Requirements file not found at: $requirementsFile" -ForegroundColor Red
            Exit 1
        }

        # Upgrade pip
        Write-Host "Upgrading pip..." -ForegroundColor Cyan
        $pipUpgradeResult = & $venvPythonPath -m pip install --upgrade pip 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error upgrading pip:" -ForegroundColor Red
            Write-Host $pipUpgradeResult -ForegroundColor Red
            Exit 1
        }

        # Install requirements
        Write-Host "`nInstalling $mode requirements..." -ForegroundColor Green
        $installResult = & $venvPythonPath -m pip install -r $requirementsFile 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error installing packages:" -ForegroundColor Red
            Write-Host $installResult -ForegroundColor Red
            Exit 1
        }
        Write-Host "$mode requirements installed successfully." -ForegroundColor Green
    
        # Validate installation environment
        Write-Host "`nValidating installation environment:" -ForegroundColor Cyan
        Write-Host "Using Python: $venvPythonPath" -ForegroundColor Yellow
    
        # Verify FastAPI installation
        try {
            $fastApiPath = & $venvPythonPath -c "import fastapi; print(fastapi.__file__)"
            Write-Host "FastAPI installed at: $fastApiPath" -ForegroundColor Yellow
        }
        catch {
            Write-Host "Error: FastAPI installation not found!" -ForegroundColor Red
            Write-Host "Installation validation failed. Please check the requirements file and try again." -ForegroundColor Red
            Exit 1
        }
    }
    catch {
        Write-Host "Error during $mode requirements installation:" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
        Write-Host "Stack Trace:" -ForegroundColor Red
        Write-Host $_.ScriptStackTrace -ForegroundColor Red
        Exit 1
    }
}
