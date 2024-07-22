export ZSH="$HOME/.oh-my-zsh"

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"
neofetch

alias notes="nvim -c 'Neorg journal today' -c 'tabnew ~/neorg/notes/goals.norg' -c 'tabnew ~/neorg/notes/labor/index.norg'"

export PATH=/usr/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/share/pkgconfig
export QT_QPA_PLATFORM='xcb'

# alias today="~/dotfiles/scripts/daily_note.sh"
alias today="~/dotfiles/scripts/daily_note.sh | xargs nvim"

