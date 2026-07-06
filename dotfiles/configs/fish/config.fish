if status is-interactive
    # Set the modern, clean prompt look
    source /usr/share/fish/functions/updater.fish 2>/dev/null

    # Enable crisp aliases with icons
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -l --icons --group-directories-first"
    alias cat="bat"

    # Display the system branding when opening a tab
    fastfetch -c ~/.config/fastfetch/minimal.jsonc
end

set -gx EDITOR nvim

if status is-login
    if test (tty) = /dev/tty1
        exec niri
    end
end
