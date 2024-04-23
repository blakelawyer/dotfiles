export ZSH="$HOME/.oh-my-zsh"

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"
neofetch

alias notes="nvim -c 'Neorg journal today' -c 'tabnew ~/neorg/notes/goals.norg' -c 'tabnew ~/neorg/notes/labor/index.norg'"
