#!/bin/bash

# Raspberry Pi hostname settings
set_hostname() {
    local NEW_HOSTNAME=$1
    echo "Setting hostname to $NEW_HOSTNAME..."
    
    # update Hostname file
    echo $NEW_HOSTNAME | sudo tee /etc/hostname
    
    # update Hosts file
    sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$NEW_HOSTNAME/" /etc/hosts
    
    # change the Hostname directly
    sudo hostnamectl set-hostname $NEW_HOSTNAME
    
    echo "Hostname set to $NEW_HOSTNAME"
}

# mDNS and  Avahi setup
install_avahi() {
    echo "Installing Avahi..."
    sudo apt-get update
    sudo apt-get install -y avahi-daemon
    
    # start and activate  Avahi 
    sudo systemctl start avahi-daemon
    sudo systemctl enable avahi-daemon
    
    echo "Avahi installed and started"
}

# SSH configuration
setup_ssh_config() {
    local HOSTNAME=$1
    local USER=$2
    
    echo "Setting up SSH config for $HOSTNAME..."
    
    # add enter to SSH configuration file 
    SSH_CONFIG="$HOME/.ssh/config"
    
    # creadte .ssh folder
    if [ ! -d "$HOME/.ssh" ]; then
        mkdir "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
    fi
    
    # creating SSH configuration file
    if [ ! -f "$SSH_CONFIG" ]; then
        touch "$SSH_CONFIG"
        chmod 600 "$SSH_CONFIG"
    fi
    
    # ading enter to SSH configuratiom file
    grep -qxF "Host $HOSTNAME" "$SSH_CONFIG" || {
        echo "Host $HOSTNAME" >> "$SSH_CONFIG"
        echo "    HostName $HOSTNAME.local" >> "$SSH_CONFIG"
        echo "    User $USER" >> "$SSH_CONFIG"
    }
    
    echo "SSH config set for $HOSTNAME"
}

# settings for Raspberry Pi 
configure_raspberry_pi() {
    local NEW_HOSTNAME=$1
    local USER=$2
    
    set_hostname $NEW_HOSTNAME
    install_avahi
    setup_ssh_config $NEW_HOSTNAME $USER
}

# main function
main() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <hostname> <user>"
        exit 1
    fi
    
    local HOSTNAME=$1
    local USER=$2
    
    configure_raspberry_pi $HOSTNAME $USER
}

# Scripti çalıştırma
main "$@"


# chmod +x setup_raspberry_pi.sh
# ./setup_raspberry_pi.sh raspberrypi1 pi
