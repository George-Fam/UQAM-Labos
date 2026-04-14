#!/usr/bin/env bash

#######################################################
# 1. SYSTEM & SHELL PREP
#######################################################
if [ -f /usr/bin/fastfetch ]; then
    fastfetch
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#######################################################
# 2. EXPORTS
#######################################################
# Export toolbox for other scripts
export LINUXTOOLBOXDIR="$HOME/linuxtoolbox"

# Default Editor
export EDITOR=nvim
export VISUAL=nvim

# Set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# History Configuation
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T" # add timestamp to history
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Colors
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=01;96:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated

# Less Colors for manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# --- Exports personels ---
# Paths
# export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"
# export PATH="/usr/local/texlive/2026/bin/x86_64-linux:$PATH"
# export MANPATH="/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH"
#export INFOPATH="/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH"

# Java
# export JAVA_HOME=/usr/lib/jvm/java-26-openjdk

# Bitwarden SSH Agent
#export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

# Gaming
#export PROTON_USE_NTSYNC=1

# Linuxbrew
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

#######################################################
# 3. SHELL OPTIONS & BINDINGS
#######################################################
shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'

# Interactive Shell Options & Bindings
if [[ $- == *i* ]]; then
    # Allow ctrl-S for forward history navigation (with ctrl-R)
    stty -ixon

    # Bind Ctrl+f to insert 'zi' followed by a newline (for zoxide)
    bind '"\C-f":"zi\n"'

    # Disable terminal bell
    bind "set bell-style visible"

    # Ignore case on auto-completion
    bind "set completion-ignore-case on"

    # Show auto-completion list automatically, without double tab
    bind "set show-all-if-ambiguous On"
fi

#######################################################
# 4. ALIASES
#######################################################
# Alias's for SSH
# alias SERVERNAME='ssh YOURWEBSITE.com -l USERNAME -p PORTNUMBERHERE'

# To temporarily bypass an alias, we precede the command with a \
    # EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Editors
alias spico='sudo pico'
alias snano='sudo nano'
alias vim='nvim'
alias edit='nvim'
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Ripgrep (Ne pas utiliser pour INF1070)
#if command -v rg &> /dev/null; then
#    alias grep='rg'
#fi

# General utilities
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ebrc='edit ~/.bashrc'
alias hlp='xdg-open ~/.bashrc-docs.html'
alias da='date "+%Y-%m-%d %A %T %Z"'
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cl='clear'
#alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

# Navigation
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Filesystem Actions
alias rmd='/bin/rm  --recursive --force --verbose'
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Listing
if command -v grc &>/dev/null; then
    _LS_BASE='LC_COLLATE=C grc ls --color=always --group-directories-first'
else
    _LS_BASE='LC_COLLATE=C ls --color=always --group-directories-first'
fi
alias la="$_LS_BASE -Alh"           # show hidden files
alias ls="$_LS_BASE -Fh"           # add colors and file type extensions
alias lx="$_LS_BASE -lXBh"          # sort by extension
alias lk="$_LS_BASE -lSrh"          # sort by size
alias lc="$_LS_BASE -ltcrh"         # sort by change time
alias lu="$_LS_BASE -lturh"         # sort by access time
alias lr="$_LS_BASE -lRh"           # recursive ls
alias lt="$_LS_BASE -ltrh"          # sort by date
alias lm="$_LS_BASE -alh | more"    # pipe through 'more'
alias lw="$_LS_BASE -xAh"           # wide listing format
alias ll="$_LS_BASE -Flsh"          # long listing format
alias lla="$_LS_BASE -Alh"          # List and Hidden Files
alias las="$_LS_BASE -A"            # Hidden Files
alias lls="$_LS_BASE -lh"           # List
alias labc="$_LS_BASE -lap"         # alphabetical sort
alias lf="LC_COLLATE=C ls -l | \grep -Ev '^d' | grcat /usr/share/grc/conf.ls"  # files only
alias ldir="LC_COLLATE=C ls -l | \grep -E '^d' | grcat /usr/share/grc/conf.ls" # dirs only


# Monitoring & SysInfo
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep "
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
alias checkcommand="type -t"
alias openports='netstat -nape --inet'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# SHA1
alias sha1='openssl sha1'

# Devops & Tools
alias kssh="kitty +kitten ssh"
alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '

#######################################################
# 5. FUNCTIONS
#######################################################
# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
                *.tar.bz2) tar xvjf $archive ;;
                *.tar.gz) tar xvzf $archive ;;
                *.bz2) bunzip2 $archive ;;
                *.rar) rar x $archive ;;
                *.gz) gunzip $archive ;;
                *.tar) tar xvf $archive ;;
                *.tbz2) tar xvjf $archive ;;
                *.tgz) tar xvzf $archive ;;
                *.zip) unzip $archive ;;
                *.Z) uncompress $archive ;;
                *.7z) 7z x $archive ;;
                *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Searches for text in all files in the current folder
ftext() {
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    \grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg() {
    if [ -d "$2" ]; then
        cp "$1" "$2" && cd "$2"
    else
        cp "$1" "$2"
    fi
}

# Move and go to the directory
mvg() {
    if [ -d "$2" ]; then
        mv "$1" "$2" && cd "$2"
    else
        mv "$1" "$2"
    fi
}

# Create and go to the directory
mkdirg() {
    mkdir -p "$1"
    cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

# Automatically do an ls after each cd, z, or zoxide
cd ()
{
    if [ -n "$1" ]; then
        builtin cd "$@" && ls
    else
        builtin cd ~ && ls
    fi
}

# Returns the last 2 fields of the working directory
pwdtail() {
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Show the current distribution
distribution () {
    local dtype="unknown"  # Default to unknown

    # Use /etc/os-release for modern distro identification
    if [ -r /etc/os-release ]; then
        source /etc/os-release
        case $ID in
            fedora|rhel|centos)
                dtype="redhat"
                ;;
            sles|opensuse*)
                dtype="suse"
                ;;
            ubuntu|debian)
                dtype="debian"
                ;;
            gentoo)
                dtype="gentoo"
                ;;
            arch|manjaro)
                dtype="arch"
                ;;
            slackware)
                dtype="slackware"
                ;;
            *)
                # Check ID_LIKE only if dtype is still unknown
                if [ -n "$ID_LIKE" ]; then
                    case $ID_LIKE in
                        *fedora*|*rhel*|*centos*)
                            dtype="redhat"
                            ;;
                        *sles*|*opensuse*)
                            dtype="suse"
                            ;;
                        *ubuntu*|*debian*)
                            dtype="debian"
                            ;;
                        *gentoo*)
                            dtype="gentoo"
                            ;;
                        *arch*)
                            dtype="arch"
                            ;;
                        *slackware*)
                            dtype="slackware"
                            ;;
                    esac
                fi

                # If ID or ID_LIKE is not recognized, keep dtype as unknown
                ;;
        esac
    fi

    echo $dtype
}


DISTRIBUTION=$(distribution)
if [ "$DISTRIBUTION" = "redhat" ] || [ "$DISTRIBUTION" = "arch" ]; then
    alias cat='bat'
else
    alias cat='batcat'
fi

# Show the current version of the operating system
ver() {
    local dtype
    dtype=$(distribution)

    case $dtype in
        "redhat")
            if [ -s /etc/redhat-release ]; then
                cat /etc/redhat-release
            else
                cat /etc/issue
            fi
            uname -a
            ;;
        "suse")
            cat /etc/SuSE-release
            ;;
        "debian")
            lsb_release -a
            ;;
        "gentoo")
            cat /etc/gentoo-release
            ;;
        "arch")
            cat /etc/os-release
            ;;
        "slackware")
            cat /etc/slackware-version
            ;;
        *)
            if [ -s /etc/issue ]; then
                cat /etc/issue
            else
                echo "Error: Unknown distribution"
                exit 1
            fi
            ;;
    esac
}

# Automatically install the needed support files for this .bashrc file
install_bashrc_support() {
    local dtype
    dtype=$(distribution)

    case $dtype in
        "redhat")
            sudo yum install tree zoxide trash-cli fzf bash-completion fastfetch grc
            ;;
        "suse")
            sudo zypper install tree zoxide trash-cli fzf bash-completion fastfetch grc
            ;;
        "debian")
            sudo apt-get install tree zoxide trash-cli fzf bash-completion grc
            # Fetch the latest fastfetch release URL for linux-amd64 deb file
            FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)

            # Download the latest fastfetch deb file
            curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb

            # Install the downloaded deb file using apt-get
            sudo apt-get install /tmp/fastfetch_latest_amd64.deb
            ;;
        "arch")
            sudo yay -S tree zoxide trash-cli fzf bash-completion fastfetch grc
            ;;
        "slackware")
            echo "No install support for Slackware"
            ;;
        *)
            echo "Unknown distribution"
            ;;
    esac
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip () {
    # Internal IP Lookup.
    if command -v ip &> /dev/null; then
        echo -n "Internal IP: "
        ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig wlan0 | grep "inet " | awk '{print $2}'
    fi

    # External IP Lookup
    echo -n "External IP: "
    curl -4 ifconfig.me
    echo ""
}

# Trim leading and trailing spaces (for scripts)
trim() {
    local var=$*
    var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
    var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
    echo -n "$var"
}

#######################################################
# 6. EXTERNAL TOOLS, PLUGINS & PROMPT
#######################################################

eval "$(ssh-agent -s)"

command -v zoxide &> /dev/null && eval "$(zoxide init bash)"
command -v fzf &> /dev/null && eval "$(fzf --bash)"
command -v oh-my-posh &> /dev/null && eval "$(oh-my-posh init bash --config 'atomic')"

