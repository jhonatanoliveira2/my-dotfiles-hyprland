#!/usr/bin/env bash

cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}' | cut -d. -f1)
ram=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')

echo "{\"text\":\" $cpu%   $ram%\",\"tooltip\":\"CPU: $cpu% | RAM: $ram%\"}"
