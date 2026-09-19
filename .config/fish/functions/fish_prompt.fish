function fish_prompt
    if test -n "$IN_NIX_SHELL"
        set_color brgreen
        echo -n "[nix-dev] "
    end

    set_color normal
    echo -n "❯ "
end
