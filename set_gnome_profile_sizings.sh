PROFILE=${1:-Default}

gconftool-2 -s -t bool /apps/gnome-terminal/profiles/$PROFILE/use_system_font false
gconftool-2 -s -t string /apps/gnome-terminal/profiles/$PROFILE/font 'Monospace 11'
gconftool-2 -s -t int /apps/gnome-terminal/profiles/$PROFILE/default_size_columns 100
