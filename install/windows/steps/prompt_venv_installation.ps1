<#
############################################################################
# File: prompt_venv_installation.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for handling virtual environment installation prompts.
#   Provides user interaction for virtual environment setup decisions.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Interactive user prompts
#   - Input validation
#   - Color-coded output
#
# Version: 1.0.0
# Last Updated: 2024-01-20
#
# Copyright (c) 2024 Stride Information Technology LLC
# Licensed under the MIT License
#
# ISO/IEC 25010:2011 Compliance:
# - Usability
# - User Interface Aesthetics
# - User Error Protection
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Virtual Environment Documentation: https://docs.python.org/3/library/venv.html
############################################################################
#>

<#
.SYNOPSIS
    Request user decision on virtual environment installation.

.DESCRIPTION
    Presents an interactive prompt to the user asking whether to install and
    activate a Python virtual environment. The function includes:
    - Color-coded options for better readability
    - Input validation with error handling
    - Case-insensitive input processing
    - Clear user feedback

.OUTPUTS
    System.String
    Returns the user's choice as a lowercase string:
    - "yes" or "y" for affirmative
    - "no" or "n" for negative

.EXAMPLE
    $choice = Request-VenvInstallation
    if ($choice -eq "yes" -or $choice -eq "y") {
        # Proceed with virtual environment setup
    }

.NOTES
    The function will continue prompting until a valid input is received.
    Valid inputs are: yes, y, no, n (case-insensitive)

.LINK
    https://docs.python.org/3/library/venv.html
#>
function Request-VenvInstallation {
    # Import required variables
    . "$PSScriptRoot\..\variables.ps1"

    # Set initial prompt color
    $Host.UI.RawUI.ForegroundColor = "Yellow"
    
    # Display main prompt
    Write-Host "`nDo you want to install a virtual environment (venv)?" -ForegroundColor Yellow
    Write-Host "Options:" -ForegroundColor Cyan
    
    # Display color-coded options
    Write-Host "  Yes - Install and activate virtual environment" -ForegroundColor Green
    Write-Host "  No  - Skip virtual environment setup" -ForegroundColor Red
    
    # Reset color for user input
    $Host.UI.RawUI.ForegroundColor = "White"
    
    # Input validation loop
    do {
        $venvChoice = Read-Host "`nEnter your choice (y/n)"
        $venvChoice = $venvChoice.ToLower()
        if ($venvChoice -eq "yes" -or $venvChoice -eq "y" -or $venvChoice -eq "no" -or $venvChoice -eq "n") {
            break
        }
        Write-Host "Invalid input. Please enter Yes/No or Y/N" -ForegroundColor Red
    } while ($true)
    
    return $venvChoice
}
