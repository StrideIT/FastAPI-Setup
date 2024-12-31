<#
############################################################################
# File: completion_message.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for displaying the final installation summary and
#   configuration details. Provides a visually formatted output with server
#   settings, API documentation links, and environment information.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Color-coded information display
#   - Server configuration details
#   - API documentation links
#   - Environment validation
#   - Visual formatting with box drawing characters
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
# - Information Quality
# - User Error Protection
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - FastAPI Documentation: https://fastapi.tiangolo.com/
# - ANSI Color Codes: https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
############################################################################
#>

<#
.SYNOPSIS
    Display a formatted completion message with installation details.

.DESCRIPTION
    Shows a comprehensive installation summary including:
    - Server configuration details
    - Available endpoints
    - API documentation locations
    - Environment information
    - Installation status
    
    The output is formatted using box-drawing characters and color-coded
    for better readability and user experience.

.OUTPUTS
    None. The function outputs directly to the console with formatted text.

.EXAMPLE
    Show-CompletionMessage
    Displays the complete installation summary with all configuration details.

.NOTES
    - Uses ANSI color codes for text formatting
    - Validates FastAPI installation
    - Handles missing FastAPI gracefully
    - Automatically resets console colors after execution
    - Requires variables.ps1 for configuration settings

.LINK
    https://fastapi.tiangolo.com/
#>
function Show-CompletionMessage {
    # Import required variables
    . "$PSScriptRoot\..\variables.ps1"

    try {
        # Begin formatted output
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "`n╔════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║                                                                            ║"
        
        # Installation status
        $Host.UI.RawUI.ForegroundColor = "Green"
        Write-Host "║                        Installation Complete!                              ║"
        
        # Server configuration section
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "╠════════════════════════════════════════════════════════════════════════════╣"
        Write-Host "║                                                                            ║"
        $Host.UI.RawUI.ForegroundColor = "Cyan"
        Write-Host "║  Server Configuration:                                                     ║"
        Write-Host "║                                                                            ║"
        
        # Server endpoints
        $Host.UI.RawUI.ForegroundColor = "Yellow"
        Write-Host "║  1. Default Server:                                                        ║"
        Write-Host "║     $defaultServerCommand ║"
        Write-Host "║     -> $localhost8000                                              ║"
        Write-Host "║                                                                            ║"
        Write-Host "║  2. Custom Port:                                                          ║"
        Write-Host "║     $customPortCommand ║"
        Write-Host "║     -> $localhost8000                                              ║"
        Write-Host "║                                                                            ║"
        Write-Host "║  3. Network Access:                                                       ║"
        Write-Host "║     $networkAccessCommand ║"
        Write-Host "║     -> $localhost8000                                                ║"
        Write-Host "║                                                                            ║"
        
        # API documentation section
        $Host.UI.RawUI.ForegroundColor = "Cyan"
        Write-Host "║  API Documentation:                                                        ║"
        $Host.UI.RawUI.ForegroundColor = "Yellow"
        Write-Host "║  - Swagger UI: $localhost8000Docs                                 ║"
        Write-Host "║  - ReDoc: $localhost8000Redoc                                     ║"
        
        # Success message
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "║                                                                            ║"
        $Host.UI.RawUI.ForegroundColor = "Green"
        Write-Host "║  Happy coding with APPOINT SE!                                            ║"
        
        # Environment details section
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "║                                                                            ║"
        Write-Host "╠════════════════════════════════════════════════════════════════════════════╣"
        Write-Host "║                                                                            ║"
        $Host.UI.RawUI.ForegroundColor = "Yellow"
        Write-Host "║  Environment Details:                                                      ║"
        
        # Python environment validation
        Write-Host "║  Python Path: $pythonPath                                                 ║" -ForegroundColor Green
        
        # FastAPI validation
        Try {
            $fastApiPath = & $venvPythonPath -c "import fastapi; print(fastapi.__file__)"
            Write-Host "║  FastAPI Path: $fastApiPath                                           ║" -ForegroundColor Green
        }
        Catch {
            Write-Host "║  FastAPI Path: Not Found                                              ║" -ForegroundColor Red
        }
        
        # Close the formatted box
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "║                                                                            ║"
        Write-Host "╚════════════════════════════════════════════════════════════════════════════╝"
    }
    finally {
        # Always reset console color
        $Host.UI.RawUI.ForegroundColor = "White"
    }
}
