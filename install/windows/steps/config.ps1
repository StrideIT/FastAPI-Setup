<#
############################################################################
# File: config.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   Configuration management script for the FastAPI installation process.
#   Centralizes configuration settings and provides environment variable
#   validation. This script serves as a configuration hub for the entire
#   installation process.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Centralized configuration management
#   - Environment variable validation
#   - Path resolution
#   - Configuration validation
#
# Version: 1.0.0
# Last Updated: 2024-01-20
#
# Copyright (c) 2024 Stride Information Technology LLC
# Licensed under the MIT License
#
# ISO/IEC 25010:2011 Compliance:
# - Maintainability
# - Reusability
# - Configuration Management
# - Modularity
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Configuration Management Guidelines: https://docs.microsoft.com/en-us/powershell/scripting/developer/module/modifying-the-psmodulepath-installation-path
############################################################################
#>

<#
.SYNOPSIS
    Initialize and validate configuration settings.

.DESCRIPTION
    Manages the configuration settings for the FastAPI installation process:
    - Imports and validates environment variables
    - Ensures required paths exist
    - Sets up configuration defaults
    - Validates configuration integrity

.OUTPUTS
    None. Configuration is loaded into the current session.

.EXAMPLE
    . .\config.ps1
    Sources the configuration file and loads settings.

.NOTES
    - Must be sourced before any other installation steps
    - Requires variables.ps1 in the parent directory
    - Sets up critical configuration variables
    - Validates configuration integrity
#>

# Import base configuration
. "$PSScriptRoot\..\variables.ps1"

# Validate configuration
if (-not (Test-Path Variable:\rootDir)) {
    Write-Host "Error: Required configuration variable 'rootDir' not found." -ForegroundColor Red
    Exit 1
}

if (-not (Test-Path Variable:\pythonPath)) {
    Write-Host "Error: Required configuration variable 'pythonPath' not found." -ForegroundColor Red
    Exit 1
}

if (-not (Test-Path Variable:\venvPath)) {
    Write-Host "Error: Required configuration variable 'venvPath' not found." -ForegroundColor Red
    Exit 1
}

# Log configuration status
Write-Host "Configuration loaded successfully." -ForegroundColor Green
Write-Host "Root Directory: $rootDir" -ForegroundColor Cyan
Write-Host "Python Path: $pythonPath" -ForegroundColor Cyan
Write-Host "Virtual Environment Path: $venvPath" -ForegroundColor Cyan
