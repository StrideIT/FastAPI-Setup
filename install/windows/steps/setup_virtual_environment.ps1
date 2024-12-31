<#
############################################################################
# File: setup_virtual_environment.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for creating and configuring Python virtual environments.
#   Handles creation, activation, and validation of virtual environments with
#   proper security policy management.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Virtual environment creation and activation
#   - Execution policy management
#   - Environment validation
#   - Error handling and recovery
#
# Version: 1.0.0
# Last Updated: 2024-01-20
#
# Copyright (c) 2024 Stride Information Technology LLC
# Licensed under the MIT License
#
# ISO/IEC 25010:2011 Compliance:
# - Security
# - Reliability
# - Maintainability
# - Functional Suitability
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Virtual Environment Documentation: https://docs.python.org/3/library/venv.html
# - PowerShell Security: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy
############################################################################
#>

<#
.SYNOPSIS
    Initialize and configure a Python virtual environment.

.DESCRIPTION
    Creates, activates, and validates a Python virtual environment. The function:
    1. Creates a new virtual environment in the specified directory
    2. Manages PowerShell execution policies for script activation
    3. Activates the virtual environment
    4. Validates the environment setup
    5. Handles security policy restoration

.PARAMETER rootDir
    The root directory where the project is located. Used for relative path resolution.

.PARAMETER pythonPath
    The full path to the Python executable that will be used to create the virtual environment.

.OUTPUTS
    None. The function exits with code 1 if any critical operation fails.

.EXAMPLE
    Initialize-VirtualEnvironment -rootDir "C:\Projects\MyProject" -pythonPath "C:\Python39\python.exe"
    Creates and activates a virtual environment using the specified Python installation.

.NOTES
    - Requires administrative privileges for execution policy modification
    - Automatically manages PowerShell execution policies
    - Restores original execution policy after activation
    - Validates environment setup before completion

.LINK
    https://docs.python.org/3/library/venv.html
#>
function Initialize-VirtualEnvironment {
    param (
        [Parameter(Mandatory = $true)]
        [string]$rootDir,
        
        [Parameter(Mandatory = $true)]
        [string]$pythonPath
    )

    # Import required variables
    . "$PSScriptRoot\..\variables.ps1"

    # Announce operation start
    Write-Host "`nProceeding with virtual environment installation..." -ForegroundColor Green
    Write-Host "`nCreating virtual environment in root directory..." -ForegroundColor Cyan

    # Create virtual environment
    & $pythonPath -m venv $venvPath

    # Validate virtual environment creation
    If (Test-Path "$venvPath\pyvenv.cfg") {
        Write-Host "Virtual environment created successfully." -ForegroundColor Green
    }
    Else {
        Write-Host "Failed to create virtual environment." -ForegroundColor Red
        Exit 1
    }

    # Begin activation process
    Write-Host "`nActivating virtual environment..." -ForegroundColor Cyan

    # Store and modify execution policy if necessary
    $executionPolicy = Get-ExecutionPolicy -Scope CurrentUser
    If ($executionPolicy -ne 'RemoteSigned' -and $executionPolicy -ne 'Unrestricted') {
        Write-Host "Current execution policy is $executionPolicy." -ForegroundColor Yellow
        Write-Host "Setting execution policy to RemoteSigned for the current user." -ForegroundColor Yellow
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    }

    # Activate the virtual environment
    . "$venvPath\Scripts\Activate.ps1"

    # Confirm activation
    Write-Host "Virtual environment activated." -ForegroundColor Green
    Write-Host "You are now working inside the virtual environment." -ForegroundColor Green

    # Validate Python interpreter
    Write-Host "`nVerifying virtual environment Python:" -ForegroundColor Cyan
    if (Test-Path $venvPythonPath) {
        Write-Host "Using virtual environment Python: $venvPythonPath" -ForegroundColor Green
    }
    else {
        Write-Host "Error: Virtual environment Python not found!" -ForegroundColor Red
        Write-Host "Expected path: $venvPythonPath" -ForegroundColor Red
        Exit 1
    }

    # Restore original execution policy if modified
    If ($executionPolicy -ne 'RemoteSigned' -and $executionPolicy -ne 'Unrestricted') {
        Write-Host "`nRestoring the original execution policy to $executionPolicy." -ForegroundColor Yellow
        Set-ExecutionPolicy -ExecutionPolicy $executionPolicy -Scope CurrentUser -Force
    }
}
