#!/bin/bash

threshhold_green=0
threshhold_yellow=25
threshhold_red=100

updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qua 2>/dev/null | wc -l)

if [[ -z "$updates_arch" ]]; then
  updates_arch=0
fi

if [[ -z "$updates_aur" ]]; then
  updates_aur=0
fi

updates=$((updates_arch + updates_aur))

css_class="ok"

if [[ "$updates" -gt $threshhold_yellow ]]; then
  css_class="warning"
fi

if [[ "$updates" -gt $threshhold_red ]]; then
  css_class="critical"
fi

if [[ "$updates" -gt $threshhold_green ]]; then
  printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
  printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "green"}'
fi

