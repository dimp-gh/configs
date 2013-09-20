# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mytheme"
#"pmcgee" is good
#"gentoo" is also nice

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git colorize debian archlinux command-not-found git-extras \
    git-remote-branch gnu-utils history pip python scala sbt systemd terminator)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias scan=nmap -sP
alias got=git
alias gut=git
alias g=git
alias scala="scala -J-jamvm"

# for colorful crosh
export TERM=xterm-256color

# rewriting postfix 'bitch' from each cmd into prefix 'sudo'
# f.e. `poweroff bitch` -> `sudo poweroff`
#      'dd if=/dev/zero of=/dev/sda bitch' -> 'sudo dd if=/dev/zero of=/dev/sda'
rewrite-bitch-sudo() {
    if [[ $BUFFER =~ ".* bitch" ]]; then
	NO_BITCH=`echo "$BUFFER" | sed 's/ bitch//'`
	BUFFER="sudo $NO_BITCH"
    fi
    zle .$WIDGET "$@";
}
zle -N accept-line rewrite-bitch-sudo
