#!/bin/bash
sudo apt update
sudo apt install -y nginx
echo "Вимикаємо машину..."
sudo shutdown -h now