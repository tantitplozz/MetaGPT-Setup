#!/bin/bash

# MetaGPT Installation Script for Linux/macOS

# Color codes for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}   MetaGPT Installation Script      ${NC}"
echo -e "${BLUE}=====================================${NC}"

# Check Python version
echo -e "\n${BLUE}Checking Python version...${NC}"
if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d " " -f 2)
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)
    
    if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 9 ] && [ "$PYTHON_MINOR" -lt 12 ]; then
        echo -e "${GREEN}Python version $PYTHON_VERSION is compatible.${NC}"
    else
        echo -e "${RED}Python version $PYTHON_VERSION is not compatible.${NC}"
        echo -e "${RED}MetaGPT requires Python 3.9 or later, but less than 3.12.${NC}"
        echo -e "${BLUE}Would you like to install a compatible Python version? (y/n)${NC}"
        read install_python
        
        if [[ $install_python == "y" || $install_python == "Y" ]]; then
            if command -v apt-get &>/dev/null; then
                echo -e "${BLUE}Installing Python 3.9 via apt...${NC}"
                sudo apt-get update
                sudo apt-get install -y python3.9 python3.9-venv python3.9-dev
            elif command -v brew &>/dev/null; then
                echo -e "${BLUE}Installing Python 3.9 via Homebrew...${NC}"
                brew install python@3.9
            else
                echo -e "${RED}Could not determine package manager. Please install Python 3.9 manually.${NC}"
                exit 1
            fi
        else
            echo -e "${RED}Exiting installation.${NC}"
            exit 1
        fi
    fi
else
    echo -e "${RED}Python3 not found. Please install Python 3.9 or later.${NC}"
    exit 1
fi

# Check for Node.js
echo -e "\n${BLUE}Checking Node.js installation...${NC}"
if command -v node &>/dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}Node.js $NODE_VERSION is installed.${NC}"
else
    echo -e "${RED}Node.js is not installed.${NC}"
    echo -e "${BLUE}Would you like to install Node.js? (y/n)${NC}"
    read install_node
    
    if [[ $install_node == "y" || $install_node == "Y" ]]; then
        if command -v apt-get &>/dev/null; then
            echo -e "${BLUE}Installing Node.js via apt...${NC}"
            curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command -v brew &>/dev/null; then
            echo -e "${BLUE}Installing Node.js via Homebrew...${NC}"
            brew install node
        else
            echo -e "${RED}Could not determine package manager. Please install Node.js manually.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Node.js is required for MetaGPT. Exiting installation.${NC}"
        exit 1
    fi
fi

# Check for pnpm
echo -e "\n${BLUE}Checking pnpm installation...${NC}"
if command -v pnpm &>/dev/null; then
    PNPM_VERSION=$(pnpm --version)
    echo -e "${GREEN}pnpm $PNPM_VERSION is installed.${NC}"
else
    echo -e "${RED}pnpm is not installed.${NC}"
    echo -e "${BLUE}Would you like to install pnpm? (y/n)${NC}"
    read install_pnpm
    
    if [[ $install_pnpm == "y" || $install_pnpm == "Y" ]]; then
        echo -e "${BLUE}Installing pnpm...${NC}"
        npm install -g pnpm
    else
        echo -e "${RED}pnpm is required for MetaGPT. Exiting installation.${NC}"
        exit 1
    fi
fi

# Create a virtual environment
echo -e "\n${BLUE}Creating a Python virtual environment...${NC}"
python3 -m venv metagpt-venv
source metagpt-venv/bin/activate

# Install MetaGPT
echo -e "\n${BLUE}Installing MetaGPT...${NC}"
pip install --upgrade pip
pip install --upgrade metagpt

# Initialize MetaGPT configuration
echo -e "\n${BLUE}Initializing MetaGPT configuration...${NC}"
metagpt --init-config

# Success message
echo -e "\n${GREEN}=====================================${NC}"
echo -e "${GREEN}MetaGPT has been successfully installed!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo -e "\n${BLUE}To activate the virtual environment in the future, run:${NC}"
echo -e "source metagpt-venv/bin/activate"
echo -e "\n${BLUE}To configure MetaGPT with your API keys, edit:${NC}"
echo -e "~/.metagpt/config2.yaml"
echo -e "\n${BLUE}To test your installation, run:${NC}"
echo -e "metagpt \"Hello, MetaGPT!\""
echo -e "\n${GREEN}Happy coding with MetaGPT!${NC}"