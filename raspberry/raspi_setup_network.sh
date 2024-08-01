#!/bin/bash

# Raspberry Pi hostname ayarı
set_hostname() {
    local NEW_HOSTNAME=$1
    echo "Setting hostname to $NEW_HOSTNAME..."
    
    # Hostname dosyasını güncelleme
    echo $NEW_HOSTNAME | sudo tee /etc/hostname
    
    # Hosts dosyasını güncelleme
    sudo sed -i "s/127.0.1.1.*/127.0.1.1\t$NEW_HOSTNAME/" /etc/hosts
    
    # Hostname'i anında değiştirme
    sudo hostnamectl set-hostname $NEW_HOSTNAME
    
    echo "Hostname set to $NEW_HOSTNAME"
}

# mDNS ve Avahi kurulumu
install_avahi() {
    echo "Installing Avahi..."
    sudo apt-get update
    sudo apt-get install -y avahi-daemon
    
    # Avahi hizmetini başlatma ve etkinleştirme
    sudo systemctl start avahi-daemon
    sudo systemctl enable avahi-daemon
    
    echo "Avahi installed and started"
}

# SSH konfigürasyonu
setup_ssh_config() {
    local HOSTNAME=$1
    local USER=$2
    
    echo "Setting up SSH config for $HOSTNAME..."
    
    # SSH konfigürasyon dosyasına giriş ekleme
    SSH_CONFIG="$HOME/.ssh/config"
    
    # .ssh dizinini oluşturma
    if [ ! -d "$HOME/.ssh" ]; then
        mkdir "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"
    fi
    
    # SSH konfigürasyon dosyasını oluşturma
    if [ ! -f "$SSH_CONFIG" ]; then
        touch "$SSH_CONFIG"
        chmod 600 "$SSH_CONFIG"
    fi
    
    # SSH konfigürasyon dosyasına giriş ekleme
    grep -qxF "Host $HOSTNAME" "$SSH_CONFIG" || {
        echo "Host $HOSTNAME" >> "$SSH_CONFIG"
        echo "    HostName $HOSTNAME.local" >> "$SSH_CONFIG"
        echo "    User $USER" >> "$SSH_CONFIG"
    }
    
    echo "SSH config set for $HOSTNAME"
}

# Raspberry Pi için ayarları yapma
configure_raspberry_pi() {
    local NEW_HOSTNAME=$1
    local USER=$2
    
    set_hostname $NEW_HOSTNAME
    install_avahi
    setup_ssh_config $NEW_HOSTNAME $USER
}

# Ana fonksiyon
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
