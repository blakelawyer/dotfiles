export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/blawyer/.local/bin:$HOME/bin

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"

export PATH=/usr/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig
export QT_QPA_PLATFORM='xcb'

alias zshrc="nvim ~/dotfiles/.zshrc"
alias dotfiles="cd ~/dotfiles"
alias scripts="cd ~/dotfiles/scripts"
alias archive="cd ~/notes/archive"
alias notes='nvim -p ~/notes/notes.md'
alias journal='nvim ~/journal/journal.md -c "ZenMode"'

# pyenv configuration
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

