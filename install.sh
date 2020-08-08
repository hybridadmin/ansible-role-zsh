#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-rhel-centos-or-fedora
title "Install Ansible"
sudo python3 get-pip.py
export PATH=$PATH:~/.local/bin
sudo pip3 install ansible

sudo apt-get update
sudo apt-get install python-apt zsh git wget -y

title "Install ansible-role-zsh"
sudo ansible-galaxy install hybridadmin.fancy_console --force

title "Download playbook to /tmp/zsh.yml"
curl https://raw.githubusercontent.com/hybridadmin/ansible-role-fancy-console/master/playbook.yml > /tmp/zsh.yml

title "Provision playbook for current user: $(whoami)"
sudo ansible-playbook -i "localhost," -c local /tmp/zsh.yml --extra-vars="zsh_user=$(whoami)"
