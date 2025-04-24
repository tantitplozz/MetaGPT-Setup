# MetaGPT Installation Script for Windows

# Function to print colored text
function Write-ColorOutput {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Text,
        
        [Parameter(Mandatory=$true)]
        [string]$Color
    )
    
    $originalColor = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $Color
    Write-Output $Text
    $host.UI.RawUI.ForegroundColor = $originalColor
}

Write-ColorOutput "=====================================" "Cyan"
Write-ColorOutput "   MetaGPT Installation Script      " "Cyan"
Write-ColorOutput "=====================================" "Cyan"

# Check Python version
Write-ColorOutput "`nChecking Python version..." "Cyan"
try {
    $pythonVersion = (python --version) -replace "Python ", ""
    $pythonMajor = [int]($pythonVersion.Split(".")[0])
    $pythonMinor = [int]($pythonVersion.Split(".")[1])
    
    if ($pythonMajor -eq 3 -and $pythonMinor -ge 9 -and $pythonMinor -lt 12) {
        Write-ColorOutput "Python version $pythonVersion is compatible." "Green"
    } else {
        Write-ColorOutput "Python version $pythonVersion is not compatible." "Red"
        Write-ColorOutput "MetaGPT requires Python 3.9 or later, but less than 3.12." "Red"
        
        $installPython = Read-Host "Would you like to open the Python download page? (y/n)"
        if ($installPython -eq "y" -or $installPython -eq "Y") {
            Start-Process "https://www.python.org/downloads/windows/"
            Write-ColorOutput "Please install Python 3.9 or 3.10, then run this script again." "Yellow"
            exit
        } else {
            Write-ColorOutput "Exiting installation." "Red"
            exit
        }
    }
} catch {
    Write-ColorOutput "Python not found. Please install Python 3.9 or later." "Red"
    $installPython = Read-Host "Would you like to open the Python download page? (y/n)"
    if ($installPython -eq "y" -or $installPython -eq "Y") {
        Start-Process "https://www.python.org/downloads/windows/"
        Write-ColorOutput "Please install Python 3.9 or 3.10, then run this script again." "Yellow"
    }
    exit
}

# Check for Node.js
Write-ColorOutput "`nChecking Node.js installation..." "Cyan"
try {
    $nodeVersion = (node --version)
    Write-ColorOutput "Node.js $nodeVersion is installed." "Green"
} catch {
    Write-ColorOutput "Node.js is not installed." "Red"
    $installNode = Read-Host "Would you like to open the Node.js download page? (y/n)"
    
    if ($installNode -eq "y" -or $installNode -eq "Y") {
        Start-Process "https://nodejs.org/en/download/"
        Write-ColorOutput "Please install Node.js, then run this script again." "Yellow"
        exit
    } else {
        Write-ColorOutput "Node.js is required for MetaGPT. Exiting installation." "Red"
        exit
    }
}

# Check for pnpm
Write-ColorOutput "`nChecking pnpm installation..." "Cyan"
try {
    $pnpmVersion = (pnpm --version)
    Write-ColorOutput "pnpm $pnpmVersion is installed." "Green"
} catch {
    Write-ColorOutput "pnpm is not installed." "Red"
    $installPnpm = Read-Host "Would you like to install pnpm? (y/n)"
    
    if ($installPnpm -eq "y" -or $installPnpm -eq "Y") {
        Write-ColorOutput "Installing pnpm..." "Cyan"
        try {
            npm install -g pnpm
            Write-ColorOutput "pnpm installed successfully." "Green"
        } catch {
            Write-ColorOutput "Failed to install pnpm. Please install it manually." "Red"
            exit
        }
    } else {
        Write-ColorOutput "pnpm is required for MetaGPT. Exiting installation." "Red"
        exit
    }
}

# Create a virtual environment
Write-ColorOutput "`nCreating a Python virtual environment..." "Cyan"
python -m venv metagpt-venv

# Activate the virtual environment
Write-ColorOutput "`nActivating virtual environment..." "Cyan"
& .\metagpt-venv\Scripts\Activate.ps1

# Install MetaGPT
Write-ColorOutput "`nInstalling MetaGPT..." "Cyan"
pip install --upgrade pip
pip install --upgrade metagpt

# Initialize MetaGPT configuration
Write-ColorOutput "`nInitializing MetaGPT configuration..." "Cyan"
metagpt --init-config

# Success message
Write-ColorOutput "`n=====================================" "Green"
Write-ColorOutput "MetaGPT has been successfully installed!" "Green"
Write-ColorOutput "=====================================" "Green"

Write-ColorOutput "`nTo activate the virtual environment in the future, run:" "Cyan"
Write-ColorOutput ".\metagpt-venv\Scripts\Activate.ps1" "White"

Write-ColorOutput "`nTo configure MetaGPT with your API keys, edit:" "Cyan"
Write-ColorOutput "$env:USERPROFILE\.metagpt\config2.yaml" "White"

Write-ColorOutput "`nTo test your installation, run:" "Cyan"
Write-ColorOutput "metagpt ""Hello, MetaGPT!""" "White"

Write-ColorOutput "`nHappy coding with MetaGPT!" "Green"