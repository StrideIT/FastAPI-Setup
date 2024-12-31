<#
############################################################################
# File: banner.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script for displaying the welcome banner and initial setup
#   instructions for the FastAPI installation process. Provides a visually
#   appealing ASCII art banner with color-coded information.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - ASCII art banner
#   - Color-coded information display
#   - Installation instructions
#   - Server configuration details
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
# - User Experience
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - ANSI Color Codes: https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
############################################################################
#>

<#
.SYNOPSIS
    Display the welcome banner for FastAPI installation.

.DESCRIPTION
    Shows a formatted welcome banner with:
    - ASCII art logo
    - Installation welcome message
    - Basic usage instructions
    - Server configuration information
    
    Uses color coding for better readability and visual appeal.

.OUTPUTS
    None. The function outputs directly to the console with formatted text.

.EXAMPLE
    Show-WelcomeBanner
    Displays the welcome banner with all information.

.NOTES
    - Uses ANSI color codes for text formatting
    - Requires variables.ps1 for server configuration details
    - Automatically resets console colors after execution
#>
function Show-WelcomeBanner {
    [CmdletBinding()]
    param()

    try {
        # Import required variables
        . "$PSScriptRoot\..\variables.ps1"

        # Display banner header
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "`n╔════════════════════════════════════════════════════════════════════════════╗"
        Write-Host "║                                                                            ║"

        # ASCII Art Logo
        $Host.UI.RawUI.ForegroundColor = "Green"
        Write-Host "║    █████╗ ██████╗ ██████╗  ██████╗ ██╗███╗   ██╗████████╗    ███████╗███████╗  ║"
        Write-Host "║   ██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝    ██╔════╝██╔════╝  ║"
        Write-Host "║   ███████║██████╔╝██████╔╝██║   ██║██║██╔██╗ ██║   ██║       ███████╗█████╗    ║"
        Write-Host "║   ██╔══██║██╔═══╝ ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║       ╚════██║██╔══╝    ║"
        Write-Host "║   ██║  ██║██║     ██║     ╚██████╔╝██║██║ ╚████║   ██║       ███████║███████╗  ║"
        Write-Host "║   ╚═╝  ╚═╝╚═╝     ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝       ╚══════╝╚══════╝  ║"

        # Welcome message
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "║                                                                            ║"
        Write-Host "╠════════════════════════════════════════════════════════════════════════════╣"
        $Host.UI.RawUI.ForegroundColor = "Green"
        Write-Host "║                          Welcome to APPOINT SE                             ║"
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "╠════════════════════════════════════════════════════════════════════════════╣"
        Write-Host "║                                                                            ║"

        # Installation instructions
        $Host.UI.RawUI.ForegroundColor = "Cyan"
        Write-Host "║  Thank you for installing our package!                                     ║"
        Write-Host "║                                                                            ║"
        Write-Host "║  To run the server after installation:                                     ║"

        # Usage notes
        $Host.UI.RawUI.ForegroundColor = "Green"
        Write-Host "║  Note: Commands use absolute paths - can be run from any directory        ║"
        Write-Host "║  Note: Virtual environment activation is not required                      ║"

        # Server configuration
        $Host.UI.RawUI.ForegroundColor = "Yellow"
        Write-Host "║  Run: $defaultServerCommand ║"
        Write-Host "║  4. Visit: $localhost8000 in your browser                          ║"
        Write-Host "║  5. API Documentation: $localhost8000Docs                          ║"

        # Close banner
        $Host.UI.RawUI.ForegroundColor = "Blue"
        Write-Host "║                                                                            ║"
        Write-Host "╚════════════════════════════════════════════════════════════════════════════╝`n"
    }
    finally {
        # Always reset console color
        $Host.UI.RawUI.ForegroundColor = "White"
    }
}
