export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/opt/flutter/bin"
export PATH=$PATH:/opt/android-studio/bin

plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
eval "$(oh-my-posh --init --shell zsh --config $HOME/.oh-my-posh/themes/darkblood.omp.json)"
neofetch

alias wiki="nvim ~/vimwiki/index.md"
alias labor="nvim ~/vimwiki/labor/Labor.md"
alias goals="nvim ~/vimwiki/leisure/Goals.md"
alias leisure="nvim ~/vimwiki/leisure/Leisure.md"
alias diary="nvim ~/vimwiki/diary/diary.md -c 'VimwikiDiaryGenerateLinks'"
alias today="nvim -c 'VimwikiMakeDiaryNote'"
alias notes="tmux new-session -s notes -n diary \"nvim -c 'VimwikiMakeDiaryNote'\" \; new-window -n work \"nvim ~/vimwiki/labor/Labor.md\" \; new-window -n goals \"nvim ~/vimwiki/leisure/Goals.md\" \; new-window -n gym \"nvim ~/vimwiki/leisure/Gym.md\""
