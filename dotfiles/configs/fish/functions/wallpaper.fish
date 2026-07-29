function wallpaper
    set -l path (noctalia-shell ipc call wallpaper get)
    kitty +kitten icat --align left --scale-up "$path"
    basename "$path"
end
