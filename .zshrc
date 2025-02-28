export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/blawyer/.local/bin

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"
echo ""
neofetch

export PATH=/usr/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig
export QT_QPA_PLATFORM='xcb'

alias zshrc="nvim ~/dotfiles/.zshrc"
alias dotfiles="cd ~/dotfiles"
alias scripts="cd ~/dotfiles/scripts"
alias archive="cd ~/notes/archive"
alias notes='nvim -p ~/notes/notes.md'
