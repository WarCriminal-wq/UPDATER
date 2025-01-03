# UPDATER-end-of-sem-project-

<img width="452" alt="Screenshot 2024-12-26 at 12 48 01 AM" src="https://github.com/user-attachments/assets/c010b0ec-b783-4d2d-9d64-1105b9ebef38" />


 Updater is a command-line tool designed to manage and maintain your system's packages and configurations efficiently. It provides a user-friendly interface to perform various system tasks, including updating and upgrading packages, viewing system and network information, and managing package installations.

## Features

- **Update Brew**: Quickly update Homebrew package manager.
- **Upgrade Packages**: Upgrade all installed packages to their latest versions.
- **System Info**: Display detailed system information using `fastfetch`.
- **Network Info**: Access various network-related tools:
  - Real-time speed monitoring with `bmon`.
  - View network packets using `termshark`.
  - Test internet connection with `ping`.
  - Perform a speed test using `speedtest`.
  - View network interfaces with `ifconfig`.
- **Configure Brew**: Manage Homebrew taps, including adding and removing taps.
- **Install/Uninstall Packages**: Easily install or uninstall packages using Homebrew.
- **Command Summary**: Get a summary of commands using `tldr`.
- **System Performance**: Monitor system performance with `btop`.
- **Verify Dependencies**: Check if all required dependencies are installed.

## Dependencies

Ensure the following dependencies are installed on your system for Updater to function correctly:

- `brew` - Homebrew package manager
- `fastfetch` - System information tool
- `bmon` - Bandwidth monitor
- `termshark` - Terminal UI for tshark
- `speedtest` - Internet speed test tool
- `dialog` - Display dialog boxes from shell scripts
- `tldr` - Simplified and community-driven man pages
- `btop` - Resource monitor

## Installation

To install Updater, clone the repository and run the installation script:

```bash
curl -sSL https://raw.githubusercontent.com/WarCriminal-wq/UPDATER/main/install-V2.sh | bash

```
Usage
Run the updater script to start the program:
```
updater
```

