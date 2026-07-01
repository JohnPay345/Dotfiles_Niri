#!/bin/bash

percent=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Если подключена зарядка — всегда показываем иконку с молнией
if [ "$status" = "Charging" ]; then
  echo "   $percent%"
  exit 0
fi

# Выбираем иконку в зависимости от процента заряда
if [ "$percent" -gt 90 ]; then
  icon="󰂂"
elif [ "$percent" -gt 80 ]; then
  icon="󰂁"
elif [ "$percent" -gt 70 ]; then
  icon="󰂀"
elif [ "$percent" -gt 60 ]; then
  icon="󰁿"
elif [ "$percent" -gt 50 ]; then
  icon="󰁾"
elif [ "$percent" -gt 40 ]; then
  icon="󰁽"
elif [ "$percent" -gt 30 ]; then
  icon="󰁼"
elif [ "$percent" -gt 20 ]; then
  icon="󰁻"
elif [ "$percent" -gt 10 ]; then
  icon="󰁺"
else
  icon="󰂃" # Критический уровень заряда
fi

# Выводим иконку вместе с процентом (или удалите $percent%, если нужна только иконка)
echo "$icon $percent%"
