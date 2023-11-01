#!/bin/zsh

# My :goto Websites
urls=(
  "https://www.google.com" 
  "https://github.com/colson0x1" 
  "https://stackoverflow.com"
  "https://youtube.com"
  "https://open.spotify.com"
  "https://instagram.com"
  "https://messenger.com"
  "https://gmail.com"
  "https://hackernews.com"
  "https://linkedin.com"
  "https://techcrunch.com"
)

selected_url=$(printf "%s\n" "${urls[@]}" | fzf)

if [ -n "$selected_url" ]; then
    open "$selected_url"  # macOs - 'open' & linux - 'xdg-open'
fi
