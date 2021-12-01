
#############
# beginning #
#############

# this is intended to be sourced by the real .bashrc using `source ~/dotfiles/bashrc.sh` or something equivalent
echo "sourced: ${BASH_SOURCE[0]}"

## change the dotfiles path to whatever is correct and put it and the line below in ~/.bashrc
# export DOTFILES_PATH="$HOME/dotfiles"
# [ -s "$DOTFILES_PATH/bashrc.sh"  ] && \. "$DOTFILES_PATH/bashrc.sh"

export EDITOR=code
export VISUAL="$EDITOR"

# Silence the following macos warning when starting bash:
# # The default interactive shell is now zsh.
# # To update your account to use zsh, please run `chsh -s /bin/zsh`.
# # For more details, please visit https://support.apple.com/kb/HT208050.
export BASH_SILENCE_DEPRECATION_WARNING=1

function parse_git_branch() {
git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# PS1 = Prompt String 1
export PS1="\[\033[032m\]\t \[\033[35m\]\u@\h \[\033[33m\]\w \[\033[36m\]\$(parse_git_branch)\[\033[0m\]\n$ "
# elaboration:
# \[\033[32m\]          # make it green
# \t                    # timestamp of render (NOT of execution)
# \[\033[35m\]          # make it purple
# \u@\h                 # username@hostname
# \[\033[33m\]          # make it yellow
# \w                    # \W = current dir, \w = current path
# \[\033[36m\]          # make it cyan
# \$(parse_git_branch)  # get the git branch name, in parens
# \[\033[0m\]           # make it white again
# \n                    # optional newline
# >                     # optional ket sign: if you copy a command into a md doc, it gets quote highlighting
# $                     # optional dollar sign: won't accidentally send things into a file
# See numerous stack overflow posts and articles for more info

# symlink-configs() {
#   echo "symlinking configs"
#   ln -s "$DOTFILES_PATH/.gitignore_global" ~/.gitignore_global
#   ln -s "$DOTFILES_PATH/.tmux.conf" ~/.tmux.conf
# }

# edit configs
alias reload="source ~/.bash_profile"
alias code-.bash="code ~/.bashrc"
alias code-bash="code ${DOTFILES_PATH}/bashrc.sh"
alias code-bashprof="code ~/.bash_profile"
alias code-dot="code ${DOTFILES_PATH}"
alias code-.git="code ~/.gitconfig"
alias code-git="code ${DOTFILES_PATH}/.gitconfig"
alias code-gitignore="code ${DOTFILES_PATH}/.gitignore_global"
alias code-nim="code ~/.config/nim/config.nims"
alias code-npm="code ~/.nvm/.npmrc"
alias code-prof="code ~/.profile"
alias code-ssh="code ~/.ssh/config"
alias code-tmux="code ~/.tmux.conf"

########
# brew #
########

# https://formulae.brew.sh/
# You may need to get off any vpn for brew to install properly. If this is an issue, the error will be SHA256 mismatches.
alias brew-up="brew update && brew upgrade && brew cleanup && brew doctor"

function brew-install-everything() { # things to install
  echo "brew installing everything"
  brew install bash # https://formulae.brew.sh/formula/bash#default
  # in macos, the default bash is /bin/bash the homebrew bash is /usr/local/bin/bash
  # to swap to the brew bash, you need to go: System Preferences > Users & Groups > Unlock > Right click your user > Advanced Options > Login shell
  brew install bash-completion2 # https://formulae.brew.sh/formula/bash-completion@2#default
  # bash v4+ uses bash-completion@2. If installing this doesn't work, make sure you are using the bash installed by brew (see above)
  # brew install docker # https://docs.docker.com/docker-for-mac/install/
  brew install fzf # https://github.com/junegunn/fzf
  brew install jq # https://formulae.brew.sh/formula/jq
  brew install ripgrep # https://github.com/BurntSushi/ripgrep
  brew install tree # https://formulae.brew.sh/formula/tree#default
}

function enable-brew-bash-completion() {
  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
}

######
# cd #
######

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ~="cd ~"
alias cd-="cd -"
alias cd..="cd .."
alias cddt="cd ~/Desktop"
alias cddl="cd ~/Downloads"
alias cddoc="cd ~/Documents"
alias cdss="cd ~/Pictures/screenshots"
alias cddot="cd $DOTFILES_PATH"
alias mkdir="mkdir -pv"
alias mkd="mkdir -pv"
function mkcd() {
	mkdir -pv $1 && cd $1;
}

# cd bookmarks http://karolis.koncevicius.lt/posts/fast_navigation_in_the_command_line/
# export CDPATH=".:~/.marks/"
export CDPATH=.:~/.marks/
function mark {
  ln -sv "$(pwd)" ~/.marks/"$1"
}
alias add-mark-to-this-dir="mark"
alias marks="ls ~/.marks"
alias cd="cd -P"
complete -d cd # make tab completion with cd only suggest directories

##########
# docker #
##########

# https://docs.docker.com/engine/reference/commandline/ps/
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dpsafo="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}'"
alias dpsfo="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Size}}\t{{.Command}}\t{{.Status}}\t{{.Ports}}'"

#######
# git #
#######

alias g="git"
alias gitalias="alias | grep git"
alias git-alias="alias | grep git"
# Note that git aliases can be put in the git config instead.
# This would allow namespacing, eg `g [alias]` but also requires typing a whole extra character every time!
# To get bash completion add the aliases to the bash completion file

# git add
alias ga="git add"
alias gaa="git add --all"
alias gai="git add -i"
alias gap="git add --patch"
alias ga-test="git add **test**"
alias gau="git reset" # "git add undo" - unstages all staged files

# git branch
alias gb="git branch" # local branches
alias gbr="git branch -r" # remote branches
alias gba="git branch -a" # all branches, including remote
alias gbv="git branch -vv" # wordier
alias gbs="git branch --sort=-committerdate" # sort by commit date
alias gbsr="git branch --sort=-committerdate -r"
alias gbsa="git branch --sort=-committerdate -a"
alias gbD="git branch -D" # delete a branch
alias gbDr="git push remote -d" # delete a REMOTE branch, be careful!
alias gbf="git branch -f" # <branch to move> <target commit> # move a branch to a specific commit

# git checkout
alias gco="git checkout"
alias gco-="git checkout -" # last branch
alias gcob="git checkout -b" # new branch
alias gco.="git checkout ." # revert modified files
function git-checkout-previous-commit() {
  local prev
  prev=$(git rev-parse HEAD~1)
  git checkout "$prev"
}
alias gcop="git-checkout-previous-commit"
function git-checkout-child-commit() {
  local forward
  forward=$(git-children-of HEAD | tail -1)
  git checkout "$forward"
}
alias gcoc="git-checkout-child-commit"
alias gcod="git checkout develop"
alias gcom="git checkout master"
alias gcon="git checkout main"
function git-checkout-branch-by-search-string() {
  local maybe_branch_name
  maybe_branch_name=$(git branch --sort=-committerdate | grep $1 | head -n 1)
  if [ -n "$maybe_branch_name" ]; then
    git checkout "${maybe_branch_name:2}"
  else
    echo "Could not find branch matching $1"
  fi
}
alias gcof="git-checkout-branch-by-search-string"
function git-checkout-remote-branch-by-search-string() {
  local maybe_branch_name
  maybe_branch_name=$(git branch --sort=-committerdate -r | grep $1 | head -n 1 | cut -d/ -f 2-20)
  if [ -n "$maybe_branch_name" ]; then
    git checkout "${maybe_branch_name#/}"
  else
    echo "Could not find remote branch matching $1"
  fi
}
alias gcofr="git-checkout-remote-branch-by-search-string"
# these next are gratuitous
alias gcodp="git checkout develop && git pull --rebase"
alias gcomp="git checkout master && git pull --rebase"
alias gconp="git checkout main && git pull --rebase"
alias gcodp-="git checkout develop && git pull --rebase && git checkout -"
alias gcomp-="git checkout master && git pull --rebase && git checkout -"
alias gconp-="git checkout main && git pull --rebase && git checkout -"
alias gcodpr="git checkout develop && git pull --rebase && git checkout - && git rebase -i develop"
alias gcompr="git checkout master && git pull --rebase && git checkout - && git rebase -i master"
alias gconpr="git checkout main && git pull --rebase && git checkout - && git rebase -i main"

# git cherry-pick
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

# git commit
alias gc="git commit"
function git-commit-with-message() {
  git commit -m "$*"
}
function git-add-all-then-git-commit-with-message() {
  git add .
  git commit -m "$*"
}
alias gcm="git-commit-with-message"
alias gacm="git-add-all-then-git-commit-with-message"
function git-commit-fixup() {
  git commit --fixup ":/$*"
}
alias gcf="git-commit-fixup"
function git-add-all-then-git-commit-fixup() {
  git add .
  git commit --fixup ":/$*"
}
alias gacf="git-add-all-then-git-commit-fixup"
alias gcan="git commit --amend --no-edit"
alias gacan="git add . && git commit --amend --no-edit"
alias gcu="git reset --soft HEAD^" # "git commit undo" - undo the last commit, but the files remain intact
alias gcdate="git commit --amend --reset-author --no-edit" # reset to the last commit's date to now. Note that you can change the commit date while rebasing using 'edit'
# see also: git commit --amend --date="$(date)" where $(date) can be replaced by something from https://mirrors.edge.kernel.org/pub/software/scm/git/docs/git-commit.html#_date_formats

# git clean
alias gclen="git clean -dn"
alias gclenf="git clean -df"

# git config
alias gconfl="git config --list --show-origin"
alias gconfe="git config -e"
alias gconfge="git config --global -e" # similar effect as code-git
alias set-user-name="git config user.name " # follow with "Your Name"
alias set-user-email="git config user.email " # follow with "you@email.com"

# git diff
alias gd="git diff"
alias gds="git diff --stat"
alias gda="git diff --staged"
alias gdw="git diff --color-words"
alias gdwh="git diff --color-words HEAD^"

# git fetch
alias gf="git fetch"

# git log
alias gl="git log"
alias glo="git log -n 10"
alias gloo="git log -n 20"
alias glooo="git log"
function git-log-oneline-chunked() {
  local chunks
  local chunk
  local size
  chunks="${1:-2}"
  size="${2:-4}"
  chunk=0
  while [ "$chunk" -lt "$chunks" ]
  do
    echo $(( $chunk*$size))"-"$(( $chunk*$size+$size ))":"
    git log --oneline -n "$size" --skip=$(( $chunk*$size ))
    chunk=$(( $chunk+1 ))
  done
}
alias glon="git log --oneline -n 10 | nl -w2 -s' '"
alias glonn="git log --oneline -n 20 | nl -w2 -s' '"
alias glonnn="git log --oneline | nl -w2 -s' '"
function git-log-oneline-children() {
  local child
  local count
  local check
  count="${1:-10}"
  child="HEAD"
  while [ "$count" -gt 0 ]
  do
    if [ ${#child} -gt 0 ]
    then
      git log -n 1 "$child"
      child=$(git-children-of $child | tail -1)
    fi
    count=$(( $count-1 ))
  done
}
alias gloc="git-log-oneline-children"
alias gll="git log --pretty=fuller --date=iso -3 HEAD"
alias glll="git log --pretty=fuller --date=iso -6 HEAD"
alias glos="git log --stat -n 5"
alias gloss="git log --stat"
function glod(){
    if [ $# -eq 0 ]; then
        git show --stat -r "HEAD"
    elif [ $1 -ge 0 ]; then
        git show --stat -r "HEAD~$1"
        # for i in `seq 0 $1`; do
        #     git show --name-status -r "HEAD~$i"
        # done
    else
        echo "Please enter the commit number to show (most recent commit is 0)."
    fi
}
alias glodd="glod 1"
alias glop="git log --graph"
alias glp="git log -p" # glp 3ccb5fc # see all the changes in that commit
# the below are from https://tekin.co.uk/2020/11/patterns-for-searching-git-revision-histories
# note that "GNU ls" is `gls`; we are hiding it with this alias
alias gls="git log -S" # pickaxe: gls "code search",
# ^finds all commits where the first arg is present in the code change itself (added or removed).
# ^second arg can be a filename to limit search to that file
alias glsp="git log -p -S" # see patches
alias glsr="git log --reverse -S" # see first commit of a snippet
alias glspr="git log -p --reverse -S" # see first commit of a snippet
alias glg="git log --grep" # commit msg search: glg "commit msg"
alias glG="git log -G" # like git log -S, but takes a REGEX!

# git pull
alias gp="git pull"
alias gpr="git pull --rebase"

# git push
alias gpu="git push"
alias gpuu="git push --set-upstream origin HEAD"
alias gpuf="git push --force-with-lease"
alias gpufu="git push --force-with-lease --set-upstream origin HEAD"

# git rebase
# alias gras="git rebase -i --autosquash" # autosquash is on in the config
alias gri="git rebase -i"
function grip(){ # git rebase interactive previous - rebase on the commit before the given one, good for squashing into a particular commit found with git log
  git rebase "$1^"
}
alias grid="git rebase -i develop"
alias grim="git rebase -i master"
alias grin="git rebase -i main"
function grih(){ # "git rebase interactive HEAD" - squash X commits from head
  if [ $# -eq 0 ]
  then
    git rebase -i "HEAD~2"
  elif [ $1 -gt 1 ]
  then
    git rebase -i "HEAD~$1"
  else
    echo "Please enter a number of commits to rebase greater than 1 (2 is default if no args)."
  fi
}
alias grihh="grih 3"
alias gria="git rebase --abort"
alias gric="git rebase --continue"
alias git-rebase-to-squash-into-first-commit="git rebase -i --root master"

# git remote
alias grepro="git remote prune origin" # remove remote branches that have been closed/merged
alias git-add-origin="git remote add origin" # follow with git @ HOST :
alias git-remove-origin="git remote remove origin" # when you set the wrong origin

# git rev-parse
alias git-hash="git rev-parse --short HEAD"
function git-children-of() {
  for arg in "$@"; do
    for commit in $(git rev-parse $arg^0); do
      for child in $(git log --format='%H %P' --all | grep -F " $commit" | cut -f1 -d' '); do
        echo $child
      done
    done
  done
}

# git show
alias gsw="git show"
alias gsws="git show --stat" # probably superior to `glod`
alias gswo="git show --stat --oneline"

# git stash
alias gsh="git stash"
alias gshm="git stash push -m"
alias gshl="git stash list --oneline"
alias gshp="git stash pop"
alias gsha="git stash apply"
alias gshaf="git checkout stash -- ."
function git-stash-apply-stash-number(){
    git stash apply "stash@{$1}"
}
alias gshas="git-stash-apply-stash-number"
alias gshaf="git checkout stash -- ."
alias gshd="git stash drop" # eg: gshd stash@{2}
function git-stash-drop-stash-number(){
    git stash drop "stash@{$1}"
}
alias gshds="git-stash-drop-stash-number"
# use this if you accidentally drop a stash (reminder):
# alias find-stash="git log --graph --oneline --decorate --all $( git fsck --no-reflog | awk '/dangling commit/ {print $3}' )"

# git status
alias gss="git status"
alias gs="git status -sbu"

# git tag
alias gt="git tag"
alias gtl="git tag --list"
alias gtd="git tag -d" # delete a tag
alias gtf="git tag -f" # make or move tag
alias gtp="git tag -f prebase" # create a 'prebase' tag prior to rebasing/merging
alias gtpu="git tag -d prebase" # remove the prebase tag

# git whatchanged
alias gwc="git whatchanged"
alias gwco="git whatchanged --oneline"

########
# java #
########

# run spring boot with maven
alias mvn-boot="mvn spring-boot:run"
alias mvn-run="mvn spring-boot:run"
alias mvn-r="mvn spring-boot:run"
alias mvn-cleanrun="mvn clean && mvn spring-boot:run"
alias mvn-cv="mvn clean verify"
alias mvn-ci="mvn clean install"
alias mvn-clear-cache="rm -rf ~/.m2/repository"

########
# kill #
########

alias killt="kill --TERM" # this is default signal for kill. let's process exist gracefully. maybe
alias kill9="kill -9" # kill with prejudice
alias killk="kill --KILL" # same as kill9

######
# ls #
######

export LSCOLORS=ExFxCxDxBxegedabagacad # with thanks to Leon Huang, see also: https://www.norbauer.com/rails-consulting/notes/ls-colors-and-terminal-app.html#:~:text=The%20values%20in%20LSCOLORS%20are,color%20and%20a%20background%20color.
# to get colors in linux use '--color=auto'
# to get colors in macos use '-G'
alias ls="ls -vG"
alias l.="ls -dG .*"
alias la="ls -AG"
alias ll="ls -alG"
alias lsd="ls -d ./*" # list just directories
function lsf() {
  ls -G **/*$1*
}

########
# misc #
########

# alias c="for n in {1..50}; do echo; done; clear"
alias c="reset"
alias sound="afplay /System/Library/Sounds/Submarine.aiff"
alias blowsound="afplay /System/Library/Sounds/Blow.aiff"
alias bb="blowsound && blowsound"
alias make-exec="chmod 755 " # follow with filename to make it executable
alias sudo="sudo " # allow aliases to be sudo'ed
alias echo-path="alias path='echo -e ${PATH//:/\\n}'"
alias map="xargs -n1" # map 'function', see https://github.com/mathiasbynens/dotfiles/blob/main/.aliases
alias show-env-vars="printenv"

function fs() { # file size: get size of file or directory
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}
# List top ten largest files/directories in current directory, credit: https://github.com/cixtor/dotfiles/blob/master/.aliases
alias ducks='du -cks * | sort -rn | head -11'

# find the most frequently used commands in bash history
alias frequent-commands="history | awk '{print $2}' | sort | uniq -c | sort -rn | head"

# bind up and down arrows to search history for leading part of command
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

#######
# nim #
#######

alias nim-up="choosenim update self && choosenim update stable && choosenim update devel"

# upgrade everything. SLOW!
alias all-up="nim-up && brew-up"

########
# node #
########

export NVM_DIR="$HOME/.nvm"
nvmi() {
    # loading nvm in every terminal introduced noticeable delay
    # I was impatient, so now there's a function that loads nvm, called `nvmi`
    # multiple calls will noop
    if [ -n "$(which node)" ]; then
        return
    fi
    echo "initializing nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
}
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm # This was slow! Moved to nvmi fxn
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias nvm-def-12="nvm alias default 12" # make nvm default to node version ^12.0.0
alias rmnm="rm -rf node_modules"
alias rmnmi="rm -rf node_modules && npm i"
alias rmnmib="rm -rf node_modules && npm i ; bb"
alias rmnmci="rm -rf node_modules && npm ci"
alias rmnmcib="rm -rf node_modules && npm ci ; bb"
alias rmlock="rm package-lock.json"
alias rmlnmib="rm package-lock.json ; rm -rf node_modules && npm i ; bb"
alias npm-dev="npm start"
alias npm-test="npm test"
alias npm-test-app="npm test App.test.tsx"
alias npm-ta="npm test App.test.tsx"
alias npm-cov="npm run coverage"
alias npm-tc="npm run test-coverage"
alias npm-up="npm install -g npm" # if not using nvm
alias sudo-npm-up="sudo npm install -g npm"

function npm-run-lint-validate-license-coverage-build() {
  echo "lint"
  npm run lint
  echo "validate"
  npm run validate
  echo "license"
  npm run licensecheck
  echo "build"
  npm run build
  echo "coverage"
  npm run coverage
}
alias npm-prepush="npm-run-lint-validate-license-coverage-build"

######
# ps #
######

alias psa="ps aux"
alias psau="ps aux | grep $USER"

#########
# react #
#########

alias testOnce="npx react-scripts test --watchAll=false --all && echo test succeeded" # this is present as a reminder

######
# rg #
######

# ripgrep / grep
alias ripgrep="rg" # https://github.com/BurntSushi/ripgrep
# alias rg="grep" # uncomment this if you don't have rg
alias grep="rg" # comment this if you don't have rg, or don't want to replace grep with rg
alias rgv="rg -v" # inverted grep

#######
# ssh #
#######

alias make-ssh-key="ssh-keygen -t rsa -C " #email address to follow
# when prompted enter the name of the file (BEWARE OVERWRITES!)
# when prompted enter the passphrase, just press enter twice for none (recommended)
alias attach-new-key="ssh-add " # path to private key to follow
# paste the contents of the .pub file into wherever you need to communicate securely (eg github)

########
# tmux #
########

# https://formulae.brew.sh/formula/tmux#default
alias tmuc="tmux -CC"
alias tmuca="tmux -CC attach"
alias start-tmux="/usr/local/bin/tmux -CC new -A -s main" # used in iterm2 (https://formulae.brew.sh/cask/iterm2#default) profile, see https://gitlab.com/gnachman/iterm2/-/wikis/tmux-Integration-Best-Practices

##############
# youtube-dl #
##############

# https://github.com/ytdl-org/youtube-dl
alias ytmp3="youtube-dl --restrict-filenames --extract-audio --audio-format mp3" # follow this with the url
# here is an example with output template:
# > ytmp3 -o 'SecretMelodyX3.$(ext)s' https://www.youtube.com/watch?v=I-8px_1fIqg
# Note the single quotes around the output template and that the extension is ".$(ext)s" those are all important!
# If you do not do it that way, the audio may fail to extract.

#############
# reminders #
#############

alias make-executable="chmod +x" #filenamehere#
alias find-process-using-port="lsof -i " #:port# # example: lsof -i :9080 # (note colon) finds the process using port 9080, so you can kill it # https://en.wikipedia.org/wiki/Lsof#:~:text=lsof%20is%20a%20command%20meaning,the%20processes%20that%20opened%20them.

# macos reminders
alias show-dot-files-in-finder="defaults write com.apple.finder AppleShowAllFiles YES" # the quick keybinding is Cmd-Shift-.
alias show-path-bar-in-finder="defaults write com.apple.finder ShowPathbar -bool true"
alias disable-file-extension-change-warning="defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false"



##########
# ending #
##########

# load bash completion - for some reason this works best called at the bottom
enable-brew-bash-completion


