#!/bin/bash

updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qua 2>/dev/null | wc -l)

if [[ -z "$updates_arch" ]]; then
  updates_arch=0
fi

if [[ -z "$updates_aur" ]]; then
  updates_aur=0
fi

if (( updates_arch > 0 )); then
  sudo pacman -Syu
fi

if (( updates_aur > 0 )); then
  yay -Syu --removemake --answerclean a --answerdiff n
fi

if (( total_updates > 0 )); then
  notify-send "Actualizaciones completas" "Se actualizaron $updates_arch paquetes de Arch y $updates_aur de AUR."
else
  notify-send "Todo actualizado" "No hay paquetes pendientes de Arch ni de AUR."
fi

