#!/bin/bash
# 
flatpak update --appstream -y
#
flatpak install -y system flathub com.vscodium.codium org.gnome.Calculator org.gnome.TextEditor org.gnome.baobab org.gnome.Evince
#
systemctl disable first-boot-flatpaks.service