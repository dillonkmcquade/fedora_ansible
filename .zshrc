#Dillon's zsh config


path+=('/home/dillon/.local/bin')
path+=('/usr/local/bin')
path+=('/home/dillon/ideaIC-2020.1/idea-IC-201.6668.121/bin')
path+=('/home/dillon/monero/build/Linux/release-v0.17/release/bin')
export PATH

#History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

#enable colors
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

#auto tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) #include hidden files

#Home directory cleanup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
export _JAVA_OPTIONS=-Djava.utils.prefs.userRoot="$XDG_CONFIG_HOME/java"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export LIBVA_DRIVER_NAME=i965

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#default programs
export BROWSER='brave-browser'
export EDITOR='nvim'
export TERMINAL='gnome-terminal'
#
# Aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim $XDG_CONFIG_HOME/nvim/init.vim"
alias muttrc="nvim $XDG_CONFIG_HOME/neomutt/neomuttrc"
alias sdf="sudo dnf -y update"
alias vim="nvim"
alias bitwarden="~/AppImages/Bitwarden-1.30.0-x86_64.AppImage & disown"
alias c="clear"

#Use fzf to quickly cd into directory
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#File icons for lf
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.mov=🎥:\
*.mpg=🎥:\
*.wmv=🎥:\
*.m4b=🎥:\
*.flv=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#provides 'fzf' command to search for files
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
source /home/dillon/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#syntax highlighting for ZSH
source /home/dillon/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
