#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root (use sudo)." 
   exit 1
fi

for deb in *.deb; do
    if [[ -f "$deb" ]]; then
        echo "Instalando $deb..."
        dpkg -i "$deb"
        apt-get install -f -y
    fi
done

if ! command -v python3 &> /dev/null; then
    echo "Python3 não encontrado. Instalando..."
    apt update && apt install -y python3 python3-pip
fi

if [[ -f "requirements.txt" ]]; then
    echo "Instalando pacotes do requirements.txt..."
    pip install --upgrade pip
    pip install -r requirements.txt
else
    echo "Arquivo requirements.txt não encontrado."
fi