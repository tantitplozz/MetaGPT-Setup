# MetaGPT Setup

Setup and installation guide for [MetaGPT](https://github.com/geekan/MetaGPT) - The Multi-Agent Framework

## Overview

MetaGPT is a powerful multi-agent framework that enables GPT models to work in a collaborative entity for complex tasks. It takes a one-line requirement as input and outputs user stories, competitive analysis, requirements, data structures, APIs, documents, and more.

## Installation

### Prerequisites

- Python 3.9 or later (but less than 3.12)
- Node.js
- pnpm

### Option 1: Installation via pip

```bash
pip install --upgrade metagpt
```

### Option 2: Installation from source

```bash
git clone https://github.com/geekan/MetaGPT
cd MetaGPT
pip install --upgrade -e .
```

### Option 3: Installation with Docker

```bash
# Pull the Docker image
docker pull metagpt/metagpt:latest

# Run the Docker container
docker run -it --rm metagpt/metagpt:latest
```

## Configuration

You can initialize the configuration of MetaGPT by running:

```bash
metagpt --init-config  # Creates ~/.metagpt/config2.yaml
```

Edit the `~/.metagpt/config2.yaml` file with your API credentials:

```yaml
llm:
  api_type: "openai"  # or azure / ollama / groq etc.
  model: "gpt-4-turbo"  # or gpt-3.5-turbo
  base_url: "https://api.openai.com/v1"  # or forward url / other llm url
  api_key: "YOUR_API_KEY"
```

## Basic Usage

### Command Line Interface

```bash
metagpt "Create a 2048 game"  # Creates a repo in ./workspace
```

### Library Usage

```python
from metagpt.software_company import generate_repo
from metagpt.utils.project_repo import ProjectRepo

repo: ProjectRepo = generate_repo("Create a 2048 game")
print(repo)  # Prints the repo structure with files
```

## Resources

- [Official Documentation](https://docs.deepwisdom.ai/main/en/)
- [GitHub Repository](https://github.com/geekan/MetaGPT)
- [Discord Channel](https://discord.gg/ZRHeExS6xv)

## License

This project is licensed under the MIT License.