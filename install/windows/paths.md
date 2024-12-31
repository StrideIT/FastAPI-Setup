# Path Management

This document lists all the paths used in the Windows installation scripts.

## Central Variable File

The `variables.ps1` file in the `install/windows` folder centralizes the path management and other configurations.

### Sections

#### Script Paths

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName
- `$pythonPath`: (Get-Command python).Path
- `$venvPath`: "$rootDir\venv"
- `$venvPythonPath`: "$venvPath\Scripts\python.exe"
- `$requirementsDevPath`: "$rootDir\requirements_dev.txt"
- `$requirementsProdPath`: "$rootDir\requirements_prod.txt"

## Paths in Scripts

### config.ps1

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName
- `$pythonPath`: (Get-Command python).Path

### initialize_script_environment.ps1

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName

### check_python_installation.ps1

- `$pythonPath`: (Get-Command python).Path

### prompt_venv_installation.ps1

- `$venvChoice`: Read-Host "`nEnter your choice (y/n)"

### setup_virtual_environment.ps1

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName
- `$pythonPath`: (Get-Command python).Path
- `$venvPythonPath`: "$rootDir\venv\Scripts\python.exe"

### install_requirements.ps1

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName
- `$pythonPath`: (Get-Command python).Path
- `$requirementsFile`: "$rootDir\..\$requirementsFile"

### completion_message.ps1

- `$rootDir`: (Get-Item $PSScriptRoot).Parent.Parent.FullName
- `$pythonPath`: (Get-Command python).Path
- `$venvPythonPath`: "$rootDir\venv\Scripts\python.exe"
- `$fastApiPath`: & "$rootDir\venv\Scripts\python.exe" -c "import fastapi; print(fastapi.__file__)"

### setup.ps1

- `$rootDir`: Initialize-ScriptEnvironment
- `$pythonPath`: Check-PythonInstallation
- `$venvChoice`: Prompt-VenvInstallation
