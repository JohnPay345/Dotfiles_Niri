#!/bin/bash

# Варианты действий
shutdown=""
reboot=""
lock=""
logout=""

# Показываем меню и получаем выбор
chosen=$(echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi -dmenu -i -theme ~/.config/rofi/themes/power-menu.rasi -p "Питание")

case "$chosen" in
"$lock")
  hyprlock # Или ваша утилита блокировки (swaylock/hyprlock)
  ;;
"$logout")
  niri msg action quit --skip-confirmation
  ;;
"$reboot")
  systemctl reboot
  ;;
"$shutdown")
  systemctl poweroff
  ;;
esac
