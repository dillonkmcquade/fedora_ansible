#Dillon's zsh config


path+=("/home/$USER/.local/bin")
path+=('/usr/local/bin')
path+=("/home/$USER/monero/build/Linux/release-v0.17/release/bin")
path+=("/home/$USER/.local/src/AppImages")
path+=("/home/$USER/.local/share/go/bin")
path+=("/home/$USER/.cargo/bin")
path+=("/home/$USER/.deno/bin")
export PATH

#History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

#enable colors
autoload -U colors && colors
PROMPT="%{$fg[blue]%}%n %{$fg[magenta]%}%~%{$fg[blue]%}${vcs_info_msg_0_} %{$reset_color%}$%b "

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
export ELECTRUM_PATH="$HOME/.local/share/electrum"
export _JAVA_OPTIONS=-Djava.utils.prefs.userRoot="$XDG_CONFIG_HOME/java"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GOPATH="$XDG_DATA_HOME/go"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export LIBVA_DRIVER_NAME=i965
export LIBVA_DRIVERS_PATH=/usr/lib64/dri
export port=3001
export DENO_INSTALL="/home/$USER/.deno"
source ~/.env_secrets

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
alias vimrc="nvim $XDG_CONFIG_HOME/nvim"
alias muttrc="nvim $XDG_CONFIG_HOME/neomutt/neomuttrc"
alias sdf="sudo dnf -y update"
alias vim="nvim"
alias c="clear"
alias loadwallet="electrum load_wallet -w $XDG_DATA_HOME/electrum/wallets/Dillons\ Wallet"
alias getbalance="electrum getbalance --offline -w $XDG_DATA_HOME/electrum/wallets/Dillons\ Wallet"
alias videos="cd $HOME/Documents/Videos"
alias ll="ls -alh"
alias vimfzf='vim $(fzf)'

#Use fzf to quickly cd into directory
#bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#Check for zsh plugins
[ ! -d "~/.config/zsh/zsh-autosuggestions" ] && git clone "https://github.com/zsh-users/zsh-autosuggestions.git" /home/$USER/.config/zsh/zsh-autosuggestions >/dev/null 2>&1
[ ! -d "~/.config/zsh/zsh-syntax-highlighting" ] && git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" /home/$USER/.config/zsh/zsh-syntax-highlighting >/dev/null 2>&1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#767676"
bindkey '^ ' autosuggest-accept

#provides 'fzf' command to search for files
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
#Auto suggestions for ZSH
source /home/"$USER"/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#syntax highlighting for ZSH
source /home/"$USER"/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pnpm
export PNPM_HOME="/home/dillon/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
