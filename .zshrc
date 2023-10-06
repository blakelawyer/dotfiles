export ZSH="$HOME/.oh-my-zsh"
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
neofetch
eval "$(oh-my-posh --init --shell zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/darkblood.omp.json')"

alias wiki="nvim ~/vimwiki/index.md"
alias labor="nvim ~/vimwiki/labor/Labor.md"
alias goals="nvim ~/vimwiki/leisure/Goals.md"
alias leisure="nvim ~/vimwiki/leisure/Leisure.md"
alias diary="nvim ~/vimwiki/diary/diary.md -c 'VimwikiDiaryGenerateLinks'"
alias today="nvim -c 'VimwikiMakeDiaryNote'"
alias notes="tmux new-session -s notes -n diary \"nvim -c 'VimwikiMakeDiaryNote'\" \; new-window -n work \"nvim ~/vimwiki/labor/Labor.md\" \; new-window -n goals \"nvim ~/vimwiki/leisure/Goals.md\""
