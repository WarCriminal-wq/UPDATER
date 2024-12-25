#!/bin/bash
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
            brew install dialog termshark bmon speedtest-cli btop
            ;;
        "debian")
            sudo apt update
            sudo apt install -y dialog termshark bmon btop
            curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
            sudo apt-get install speedtest
            ;;
        "fedora")
            sudo dnf install -y dialog termshark bmon btop
            pip3 install speedtest-cli  
            ;;
    esac

    echo "Downloading and installing the script..."
    curl -L $script_url -o updater
    chmod +x updater
    mv updater $target_dir

    echo "Installation complete. The script has been moved to $target_dir."
}

clear
security_check
banner  
echo "installing UPDATER utility..."
# Detect the operating system and distribution
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS."
    install_script "macos" "https://github.com/WarCriminal-wq/updater-macos" "$HOME/.local/bin"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
elif [[ -f /etc/debian_version ]]; then
    echo "Detected Debian-based system."
    install_script "debian" "https://github.com/WarCriminal-wq/updater-debian" "/bin"
elif [[ -f /etc/fedora-release ]]; then
    echo "Detected Fedora-based system."
    install_script "fedora" "https://github.com/WarCriminal-wq/updater-fedora" "/bin"
else
    echo "Unsupported operating system."
    exit 1
fi