export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/blawyer/.local/bin

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"
neofetch

export PATH=/usr/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig
export QT_QPA_PLATFORM='xcb'

alias zshrc="nvim ~/dotfiles/.zshrc"

alias today="~/dotfiles/scripts/daily_note.sh | xargs nvim"
alias week="~/dotfiles/scripts/weekly_note.sh | xargs nvim"
alias month="~/dotfiles/scripts/monthly_note.sh | xargs nvim"
alias idea="~/dotfiles/scripts/inbox.sh"

alias dotfiles="cd ~/dotfiles"
alias scripts="cd ~/dotfiles/scripts"
alias templates="cd ~/notes/templates"
alias projects="cd ~/notes/0-projects"
alias areas="cd ~/notes/1-areas"
alias resources="cd ~/notes/2-resources"
alias archive="cd ~/notes/3-archive"
alias inbox="cd ~/notes/inbox"
alias periodic="cd ~/notes/periodic"

alias daily="cd ~/notes/periodic/0-daily"
alias weekly="cd ~/notes/periodic/1-weekly"
alias monthly="cd ~/notes/periodic/2-monthly"

alias notes='cd ~/notes && nvim -p $(~/dotfiles/scripts/daily_note.sh) $(~/dotfiles/scripts/weekly_note.sh) $(~/dotfiles/scripts/monthly_note.sh)'

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
