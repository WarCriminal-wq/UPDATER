#!/bin/bash

log_file="updater_install_log.txt"

security_check(){
if [ "$EUID" -ne 0 ]; then
  echo "This script requires root privileges. Please run it with sudo or as root."
  exit 1
fi
}

banner(){
  echo "██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗██████╗ "
  echo "██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗"
  echo "██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  ██████╔╝"
  echo "██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  ██╔══██╗"
  echo "╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗██║  ██║"
  echo " ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
  echo " INSTALLER                                     By Jonny L "
}

# Function to install dependencies and move the script
install_script() {
    local os_type=$1
    local script_url=$2
    local target_dir=$3

    echo "Installing dependencies for $os_type..."
    case $os_type in
        "macos")
            brew install dialog termshark bmon speedtest-cli btop >> "$log_file" 2>&1 || { echo "Failed to install dependencies. Check $log_file for details."; exit 1; }
            mkdir $HOME/.local/bin
            ;;
        "debian")
            sudo apt update >> "$log_file" 2>&1 || { echo "Failed to update apt. Check $log_file for details."; exit 1; }
            sudo apt install -y dialog termshark bmon btop >> "$log_file" 2>&1 || { echo "Failed to install dependencies. Check $log_file for details."; exit 1; }
            curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash >> "$log_file" 2>&1 || { echo "Failed to add Speedtest repository. Check $log_file for details."; exit 1; }
            sudo apt-get install speedtest >> "$log_file" 2>&1 || { echo "Failed to install Speedtest. Check $log_file for details."; exit 1; }
            ;;
        "fedora")
            sudo dnf install -y dialog termshark bmon btop >> "$log_file" 2>&1 || { echo "Failed to install dependencies. Check $log_file for details."; exit 1; }
            pip3 install speedtest-cli >> "$log_file" 2>&1 || { echo "Failed to install Speedtest. Check $log_file for details."; exit 1; }
            ;;
    esac

    echo "Downloading and installing the script..."
    curl -L $script_url -o updater >> "$log_file" 2>&1 || { echo "Failed to download the script. Check $log_file for details."; exit 1; }
    chmod +x updater >> "$log_file" 2>&1 || { echo "Failed to set execute permissions. Check $log_file for details."; exit 1; }
    mv updater $target_dir >> "$log_file" 2>&1 || { echo "Failed to move the script. Check $log_file for details."; exit 1; }

    echo "Installation complete. The script has been moved to $target_dir."
}

clear
banner  
echo "installing UPDATER utility..."
# Detect the operating system and distribution
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS."
    install_script "macos" "https://github.com/WarCriminal-wq/updater-macos" "$HOME/.local/bin" 2>&1 | tee -a "$log_file"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
elif [[ -f /etc/debian_version ]]; then
    echo "Detected Debian-based system."
    security_check
    install_script "debian" "https://github.com/WarCriminal-wq/updater-debian" "/bin" 2>&1 | tee -a "$log_file"
elif [[ -f /etc/fedora-release ]]; then
    echo "Detected Fedora-based system."
    security_check
    install_script "fedora" "https://github.com/WarCriminal-wq/updater-fedora" "/bin" 2>&1 | tee -a "$log_file"
else
    echo "Unsupported operating system."
    exit 1
fi

echo "Installation completed successfully."
