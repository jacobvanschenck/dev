# Dev Environment Setup

This repository contains installation scripts to quickly set up your development environment. The scripts install required packages and copy configuration files to your `~/.config` directory.

## How It Works

The `run` script:

- **Searches** for executable files in the `runs` directory.
- **Command-Line Options:**

  - `--dry`: Run in dry mode (logs actions without executing them).
  - `<filter>`: An optional string to filter which scripts to run.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/yourrepo.git
   cd yourrepo
   ```
2. Run the installation:

   - To execute all scripts:

   ```bash
   ./run
   ```

   - To perform a dry run (simulate the installation):

   ```bash
    ./run --dry
   ```

- To run only specific scripts (e.g., only the alacritty script):

  ```bash

  ./run alacritty
  ```

## Customization

You can add or modify the installation scripts in the runs directory as needed. Each script should be executable and handle the installation or configuration for its specific component.
