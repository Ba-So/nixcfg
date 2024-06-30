export XDG_CONFIG_HOME=$HOME/.config;
export XDG_DATA_HOME=$HOME/.local/share;
export PKG_CONFIG_PATH=/usr/lib/pkgconfig;
export PATH="$PATH:$(find $HOME/.local/bin -type d | paste -sd ':' -)"
