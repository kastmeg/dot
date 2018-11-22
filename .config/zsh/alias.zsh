# ~/.zsh/alias.zsh

alias kerr="journalctl -k -b -p 3"
alias wifi_list="nmcli device wifi rescan; nmcli -p -f all device wifi list"

alias tree="tree -C -L 3"
alias tc="tc -color -pretty"
alias ip="ip -color -pretty"
alias routes="ip route show"
alias route4="ip route show protocol 4"
alias route6="ip route show protocol 6"
alias neigh="ip neigh show"
alias ss_tcp="ss -t -a"  # dumps all TCP sockets
alias ss_udp="ss -u -a"  # dumps all UDP sockets
alias ss_raw="ss -w -a"  # dumps all RAW sockets
alias ss_unix="ss -x -a" # dumps all UNIX sockets

alias ssh="TERM=xterm-256color ssh"
alias scp="TERM=xterm-256color scp"

# Default overrides
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias figlet='figlet -w 300 -f univers'

alias genpw="base64 <(cat /dev/urandom | head -c 16) | tr -d '=' | tr -d '/'"
alias genpw32="base64 <(cat /dev/urandom | head -c 32)"

alias clip="xclip -i -sel clipboard"

alias ls="exa --git --color-scale -mghrs size"
alias lst="exa --group-directories-first --git --tree --color-scale -mghrs size"
alias lsg="exa --group-directories-first --long --sort name -G"

alias le="exa -lrhgHBimU --git --group-directories-first"

# Utilities
alias hx='hexdump -Cv'
alias duh='du -ah --max-depth=1'
alias dstamp="echo -n $(date +%m-%d-%y_%H.%M.%S) | pbcopy"
alias plotline="gnuplot -p -e 'plot \"/dev/stdin\"'"
alias grepnum="grep -Po '\d+(\.\d+)?'"
alias lsummer='awk "BEING{s=0}{s+=$1}END{print s}"'
alias ymlchk="python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' 2>/dev/null < $1"
alias rapetun='for pid in $(ps aux | grep Tunnelblick | awk '{print $2}' | grep -v grep); do kill $pid; done'
alias print256colors='for i in $(seq 0 255); do echo -ne "\e[38;5;${i}m[$(printf "%8d" "\\e[38;5;${i}m"; if [[ $(($i % 8)) -eq 0 ]]; then echo; fi; done'

# Git
alias ga='git add'
alias gitpush='git push origin master'
alias gitpull='git pull'
alias gd='git diff --color --no-ext-diff'
alias gdstat='git diff --color --stat'
alias gs='git status -sb'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gitbranches="git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
alias gcpush='git commit -a -m && git push origin'
alias gundo='git reset --soft HEAD~1'
alias gupdatesubm='pull --recurse-submodules && git submodule update --recursive --remote'

# Taskwarrior
alias ta='task add'
alias tw='task list project:webhuset'
alias twa='task add project:webhuset'
alias td='task done'
alias tm='task modify'

function sortlen() {
  awk '{ print length, $0 }' | sort -n -s -r | cut -d" " -f2-
}

function markd() {
  pandoc $1 | lynx -stdin
}
