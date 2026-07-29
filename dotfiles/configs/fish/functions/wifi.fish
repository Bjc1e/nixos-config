function wifi --wraps='sudo nmcli radio wifi off && sudo nmcli radio wifi on' --description 'alias wifi=sudo nmcli radio wifi off && sudo nmcli radio wifi on'
    sudo nmcli radio wifi off && sudo nmcli radio wifi on $argv
end
