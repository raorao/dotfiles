# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# support for chruby
if [ -d /usr/local/opt/chruby ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

# Path for RVM
test -d $HOME/.rvm/bin && PATH=$PATH:$HOME/.rvm/bin

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
#  \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to purple
c_git_clean='\[\e[0;35m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT_COMMAND='PS1="${c_path}\W${c_reset}$(git_prompt) :> "'

export PS1='\n\[\033[0;31m\]\W\[\033[0m\]$(git_prompt)\[\033[0m\]:> '

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(Git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# loads git completion script.
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Colors ls should use for folders, files, symlinks etc, see `man ls` and
# search for LSCOLORS
export LSCOLORS=HxGxFxdxCxFxFxaccxaeex
# Force ls to use colors (G) and use humanized file sizes (h)
alias ls='ls -Gh'

# Useful aliases
alias e=subl
alias be="bundle exec"
alias te="open -a TextEdit"
alias jscs="jscs -c ~/.jscsrc"
alias g="git"
alias gi="git"
alias myip="ipconfig getifaddr en0"
alias sane="stty sane"
