# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin/scripts:~/bin:$PATH"

# Path for asdf
if [ -x "$(command -v asdf)" ]; then
  source /usr/local/opt/asdf/asdf.sh
fi

# support for chruby
if [ -d /usr/local/opt/chruby ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# stitch fix specific changes

# Since postgres isn't the default version, the binaries don't get added
# automatically to the path.
if [[ $PATH != *"/usr/local/opt/postgresql@9.4/bin:"* ]]
then
  export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
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
  git_branch=$(Git branch 2>/dev/null | sed -n '/^\*/s/^\* //p' | cut -c 1-20)
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

export BUNDLER_EDITOR=subl

# allow tabs to access each other's history
HISTCONTROL=ignoredups:erasedups
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
shopt -s histappend

# Useful aliases
alias e=subl
alias be="bundle exec"
alias te="open -a TextEdit"
alias note="open -a Simplenote"
alias jscs="jscs -c ~/.jscsrc"
alias g="git"
alias gi="git"
alias myip="ipconfig getifaddr en0"
alias sane="stty sane"
alias gitcop="git status --porcelain | sed s/\^...// | grep rb$ | xargs rubocop -a"
alias reload="source ~/.bash_profile | echo 'bash profile updated'"
alias brake="bundle exec rake"
