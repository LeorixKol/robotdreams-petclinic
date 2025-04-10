#!/bin/bash

# Масив базових пакетів
BASE_PACKAGES=("apache2" "mariadb-server" "ufw" "docker.io")

# Заміна назв для сумісності між дистрибутивами
function map_package_names() {
    case "$DISTRO" in
        centos|fedora)
            BASE_PACKAGES=("httpd" "mariadb-server" "firewalld" "docker")
            ;;
    esac
}

# Визначення дистрибутива
function detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$(echo "$ID" | tr '[:upper:]' '[:lower:]')
    else
        echo "Неможливо визначити дистрибутив."
        exit 1
    fi
}

# Функція для встановлення пакетів
function install_packages() {
    local packages=("$@")
    case "$DISTRO" in
        ubuntu|debian)
            sudo apt-get update
            for pkg in "${packages[@]}"; do
                if dpkg -s "$pkg" &>/dev/null; then
                    echo "$pkg вже встановлено. Оновлюємо..."
                    sudo apt-get install --only-upgrade -y "$pkg"
                else
                    sudo apt-get install -y "$pkg"
                fi
            done
            ;;
        centos)
            sudo yum makecache
            for pkg in "${packages[@]}"; do
                if rpm -q "$pkg" &>/dev/null; then
                    echo "$pkg вже встановлено. Оновлюємо..."
                    sudo yum update -y "$pkg"
                else
                    sudo yum install -y "$pkg"
                fi
            done
            ;;
        fedora)
            sudo dnf makecache
            for pkg in "${packages[@]}"; do
                if rpm -q "$pkg" &>/dev/null; then
                    echo "$pkg вже встановлено. Оновлюємо..."
                    sudo dnf upgrade -y "$pkg"
                else
                    sudo dnf install -y "$pkg"
                fi
            done
            ;;
        *)
            echo "Дистрибутив $DISTRO не підтримується."
            exit 1
            ;;
    esac
}

### Основна частина скрипта ###

detect_distro
echo "Виявлено дистрибутив: $DISTRO"

map_package_names

# Додати аргументи користувача до масиву пакетів
ALL_PACKAGES=("${BASE_PACKAGES[@]}" "$@")

# Встановлення пакетів
install_packages "${ALL_PACKAGES[@]}"

echo "Установка завершена для $DISTRO."
