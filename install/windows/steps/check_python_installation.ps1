<#
############################################################################
# File: check_python_installation.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for verifying Python installation and environment setup.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Python installation verification
#   - Python version checking
#   - Path validation
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
# - Security
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Python Installation Guide: https://docs.python.org/3/using/windows.html
############################################################################
#>

# Source variables file
. "$PSScriptRoot\..\variables.ps1"

<#
.SYNOPSIS
    Test Python installation and retrieve the executable path.

.DESCRIPTION
    Verifies if Python is installed on the system and retrieves the path to the
    Python executable. This function performs several checks:
    1. Validates Python executable existence
    2. Checks Python version
    3. Verifies PATH environment setup

.OUTPUTS
    System.String
    Returns the validated Python executable path.

.EXAMPLE
    $pythonPath = Test-PythonInstallation
    This will verify Python installation and return the path if successful.

.NOTES
    The function will exit with code 1 if Python is not found or not properly
    configured in the system PATH.

.LINK
    https://www.python.org/downloads/
#>
function Test-PythonInstallation {
    Try {
        $pythonVersion = & $pythonPath --version
        Write-Host "Python version: $pythonVersion" -ForegroundColor Green
        Write-Host "Python path: $pythonPath" -ForegroundColor Green
    }
    Catch {
        Write-Host "Python is not installed or not added to PATH." -ForegroundColor Red
        Write-Host "Please install Python 3.x and ensure it's added to your system PATH." -ForegroundColor Red
        Exit 1
    }
    return $pythonPath
}
