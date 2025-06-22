# Custom PS1 with colored Git branch
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p'
}

export PS1="\[\033[0;32m\]\u@\h:\[\033[0;34m\]\w \[\033[0;31m\](\$(parse_git_branch))\[\033[00m\]\$ "
