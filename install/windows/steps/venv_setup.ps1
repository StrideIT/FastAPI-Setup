<#
############################################################################
# File: venv_setup.ps1
# Author: Tariq Ahmed <t.ahmed@stride.ae>
# Organization: Stride Information Technology LLC
# 
# Description:
#   PowerShell script containing helper functions for virtual environment setup.
#
# Usage:
#   This script is sourced by setup.ps1 and should not be run directly.
#
# Features:
#   - Script environment initialization
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
# - Modularity
#
# References:
# - PowerShell Best Practices: https://docs.microsoft.com/en/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands
# - Virtual Environment Documentation: https://docs.python.org/3/library/venv.html
############################################################################
#>

<#
.SYNOPSIS
    Initialize the script environment and set up required variables.

.DESCRIPTION
    Sets up the root directory path and prepares the environment for installation.
    This is the first step in the installation process.

.OUTPUTS
    System.String
    Returns the root directory path.

.EXAMPLE
    $rootDir = Initialize-ScriptEnvironment
    This will initialize the script environment and return the root directory path.

.NOTES
    This function is called at the beginning of the setup process to ensure
    all required variables are properly initialized.
#>
function Initialize-ScriptEnvironment {
    # Import variables from variables.ps1
    . "$PSScriptRoot\..\variables.ps1"
    return $rootDir
}
