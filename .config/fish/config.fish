set -U fish_greeting # disable fish greeting
set -g fish_prompt_pwd_dir_length 1
set -p fish_function_path ~/.config/fish/functions

# 来禁用 Ctrl+S 被终端拦截为“暂停输出（XOFF）”的功能。
if status --is-interactive
    stty -ixon
end
#添加nvim为打开文本的editor选项
set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -gx PATH /usr/local/bin $PATH
set -gx PATH /usr/bin $PATH

abbr l "eza -1a"
abbr ll "eza -1al"
abbr ls "eza"
abbr gs "git status"
abbr gc "git commit"
abbr gaa "git add ."
abbr gd "git diff"
abbr gpl "git pull"
abbr gps "git push"
abbr gl "git log --oneline -10"
abbr gL "git log"

abbr rm "rm -irv"

# set PATH so it includes user's private bin if it exists
if test -d "$HOME/bin"
    set PATH "$HOME/bin" $PATH
end

# set PATH so it includes user's private bin if it exists
if test -d "$HOME/.local/bin"
    set PATH "$HOME/.local/bin" $PATH
end

# add J-Link to PATH if it exists
if test -d "$HOME/Downloads/opt/JLink_Linux_V786_x86_64"
    set PATH "$HOME/Downloads/opt/JLink_Linux_V786_x86_64" $PATH
end
# set -Ux PATH $PATH ~/Downloads/opt/JLink_Linux_V786_x86_64/

# starship init fish | source
zoxide init fish | source
function zi
    cd (zoxide query -i | string collect)
end
# 代理
#set -x http_proxy http://127.0.0.1:7890
#set -x https_proxy http://127.0.0.1:7890
#set -x NO_PROXY 127.0.0.1,localhost

# 差异比较程序
set -x DIFFPROG vimdiff

#key-bind -> 路径回退
function inverse_cd
    cd ..
    commandline -f repaint
end
bind \co inverse_cd

#覆盖+安静模式
# 解压当前文件夹
function unzip_here
    set -l zip_files *.zip

    if test (count $zip_files) -eq 0
        echo "没有找到zip文件"
        return 1
    end

    for file in $zip_files
        if not test -f $file
            echo "跳过: $file 不是文件"
            continue
        end

        echo "正在解压到当前目录: $file"
        unzip -o $file  # -o 覆盖已有文件
    end
end
function proxy_paru
    env \
        http_proxy=http://127.0.0.1:7897 \
        https_proxy=http://127.0.0.1:7897 \
        all_proxy=socks5h://127.0.0.1:7897 \
        paru $argv
end

set -x MAKEFLAGS "-j"(nproc)

set -x WEBKIT_DISABLE_DMABUF_RENDERER 1

function lf
    set tmp (mktemp)

    command lf -last-dir-path=$tmp $argv

    if test -f $tmp
        set dir (cat $tmp)
        if test -d $dir
            cd $dir
        end
    end

    rm -f $tmp
end
