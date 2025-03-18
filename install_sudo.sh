#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install git -y
sudo apt install python3-pip -y

# Instala o virtualenv, caso não esteja instalado
sudo apt install python3-venv -y
#sudo apt install virtualenv

sudo apt install nano -y

sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

sudo apt install iptables-persistent -y
