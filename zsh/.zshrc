# Automatically start tmux if it isn't attached
# [[ $TERM != "screen" ]] && [[ $TERM != "screen-256color" ]] && tmux && exit

# ZSH=$HOME/.oh-my-zsh
# ZSH_THEME=coarsesand
# N_VERSION=0.8.16

# plugins=(django git github mercurial node pip powder rake rbenv vundle)
if [[ `uname` == 'Darwin' ]]; then plugins+=brew; else plugins+=debian; fi

# source $ZSH/oh-my-zsh.sh

export EDITOR="subl -w"

# ls colors
if [ "`uname`" = 'Darwin' ]
then export LSCOLORS=exBxcxCxbxgxGxdxdxGeEx
# else export LS_COLORS='di=34;40:ln=1;;40:so=32;40:pi=1;;40:ex=31;40:bd=36;40:cd=1;;40:su=33;40:sg=33;40:tw=1;;44:ow=1;;40:'
# ^ don't seem to be correct
fi

# =========
# Functions
# =========

# Get the SLOC count of given files. Ignores blank, #-, and //-commented lines.
sloc() {
  sed -e '/^\s*[#\(\/\/\)].*/d' -e '/^\s*$/d' $@ | wc -l
}

mkcd() {
  mkdir $1
  cd $1
}

source $HOME/.zsh/colors.sh

# =======
# Aliases
# =======

# Which vim should I use?
if [[ "`uname`" != 'Darwin' ]]
then alias vim="vim"
else alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

alias addrepo="sudo add-apt-repository" # add-apt-repository is just too verbose
alias serve="python -m SimpleHTTPServer 8060" # Serve current directory, thanks Python
alias be="bundle exec"

# Somehow, and I don't know how, this keeps tmux from screwing up terminal vim's
# colours
alias tmux="TERM=screen-256color-bce tmux"

# Zsh does odd things sometimes, stop correcting me!
for cmd in "cp mv mkdir tmux rbenv ncmpcpp subl powder bundle vundle pip"; do
  alias $cmd="nocorrect $cmd"
done

alias weather="weatherman"
alias hastier="cat $1 | haste | pbcopy"
alias mman="middleman"

# Node
# alias node="n use ${N_VERSION}"
# alias npm="n npm ${N_VERSION}"

echo "Did you update your system today?"