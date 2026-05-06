if status is-interactive
    # 基础环境变量
    set -gx EDITOR nvim

    set -gx FZF_DEFAULT_COMMAND 'fd --type f'

    # LLVM / CMake
    set -gx LDFLAGS -L/opt/homebrew/opt/llvm/lib
    set -gx CPPFLAGS -I/opt/homebrew/opt/llvm/include
    set -gx CMAKE_PREFIX_PATH /opt/homebrew/opt/llvm

    # clash
    set -gx HTTP_PROXY http://127.0.0.1:7897
    set -gx HTTPS_PROXY http://127.0.0.1:7897
    set -gx ALL_PROXY socks5://127.0.0.1:7897

    # PATH
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /opt/homebrew/opt/curl/bin
    fish_add_path (brew --prefix bison)/bin
    fish_add_path (brew --prefix flex)/bin
    fish_add_path /Users/yjq/.bun/bin
    fish_add_path /Users/yjq/go/bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/Library/Python/3.9/bin
    fish_add_path $HOME/Library/Android/sdk/cmdline-tools/bin

    # ghcup
    fish_add_path $HOME/.ghcup/bin
    fish_add_path $HOME/.cabal/bin

    # eza 替代 ls
    if type -q eza
        alias l='command eza --icons -l --group-directories-first'
        alias ls='command eza --icons --group-directories-first'
        alias ll='command eza --icons -l --git --header --total-size --time-style=long-iso'
        alias la='command eza --icons -l -a --git --header --total-size --time-style=long-iso'
    end

    function lt
        set level 3

        if test (count $argv) -gt 0
            set level $argv[1]
        end

        eza --icons --tree --level=$level
    end

    alias c='clear'

    abbr -a cs codex-switch

    # git abbr
    abbr -a qkgit 'git add .; and aicommits -y; and git push'
    abbr -a pull 'git pull'
    abbr -a push 'git push'
    abbr -a add 'git add .'

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q fzf
        fzf --fish | source
    end

    # Mole shell completion
    if type -q mole
        mole completion fish 2>/dev/null | source
    end

    # yazi: 退出后 cd 到 yazi 当前目录
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

end
