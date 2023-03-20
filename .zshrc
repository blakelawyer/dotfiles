neofetch

plugins=(git archlinux zsh-syntax-highlighting)

alias vpn='sudo sh -c "echo nameserver [IP] >> /etc/resolv.conf"'
alias monitorfix='rm -R ~/.local/share/kscreen && optimus-manager --switch nvidia'
alias wiki="nvim ~/vimwiki/index.md"
alias labor="nvim ~/vimwiki/labor/Labor.md" 
alias goals="nvim ~/vimwiki/leisure/Goals.md" 
alias leisure="nvim ~/vimwiki/leisure/Leisure.md" 
alias diary="nvim ~/vimwiki/diary/diary.md -c 'VimwikiDiaryGenerateLinks'"
alias today="nvim -c 'VimwikiMakeDiaryNote'"
alias work="tmux new-session -s work -n notes \"nvim -c 'VimwikiMakeDiaryNote'\" \; new-window -n to-do \"nvim ~/vimwiki/labor/Labor.md\""

# `p10k configure`
