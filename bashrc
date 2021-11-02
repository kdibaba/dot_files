[[ -f /etc/bash/bashrc ]] && . /etc/bash/bashrc

if [[ $- != *i* ]]; then
    return
fi

# complete sudo commands
complete -cf sudo

# vim bindings for shell
set -o vi
shopt -s cdspell


# Path
PATH="/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin"
test -d "/opt/bin" &&
PATH="$PATH:/opt/bin"
test -d "$HOME/bin" &&
PATH="$HOME/bin:$PATH"
export PATH


# Editor and Pager
EDITOR="vim"
export EDITOR
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[1;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[1;'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
PAGER="less -FirSwX"

MANPAGER="$PAGER"
export PAGER MANPAGER


# Prompt and window title of X terminals

# Default prompt
if [[ ${EUID} == 0 ]]; then
    PS1='\[\e[01;31m\]\$\[\e[0m\] '
else
    PS1='\[\e[0m\]\$ '
fi

# If sshed include hostname
if [[ "$SSH_CLIENT" ]]; then
    PS1="\[\e[0;31m\]\h$PS1"

    case ${TERM} in
        xterm*|rxvt*)
            PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}|${PWD/#$HOME/~}\007"'
            ;;
        screen*)
            PROMPT_COMMAND='echo -ne "\033_;${HOSTNAME}|${PWD/#$HOME/~}\033\\"'
            ;;
    esac
else
    case ${TERM} in
        xterm*|rxvt*)
            PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
            ;;
        screen*)
            PROMPT_COMMAND='echo -ne "\033_;${PWD/#$HOME/~}\033\\"'
            ;;
    esac
fi

# Fancy git prompt if installed
if [[ -f $HOME/.bash-git-prompt/gitprompt.sh ]]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
  fi

# Aliases
alias ls='ls -F --color=auto'    #colors
alias l='ls -F --color=auto'    #colors
alias ll='ls -lsah --color=auto'  #long list
alias la='ls -AF --color=auto'  #show hidden
alias lx='ls -lXB --color=auto'  #sort by sextension
alias lk='ls -lSr --color=auto'  #sort by size biggest last
alias lc='ls -ltcr --color=auto' #sort by and show chagne times
alias lu='ls -ltur --color=auto' #sort by and show access time
alias lt='ls -ltr --color=auto'  #sort by date
alias lm='ls -al |more'          #pipe through more
alias lr='ls -lR'                #recursive
alias tree='tree -Csuh'          #alternative to recursive ls
alias df='df -kTh'
alias path='echo -e ${PATH//:/\\n}'
alias grep='grep --color=auto'
alias cleangit='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# Silly sudo
alias mount='sudo mount'
alias mount='sudo mdadm'
alias umount='sudo umount'
alias emerge='sudo emerge'
alias eix='sudo eix -F'
alias eix-sync='sudo eix-sync'
alias eix-update='sudo eix-update'
alias rc-update='sudo rc-update'
alias revdep-rebuild='sudo revdep-rebuild'
alias salt='sudo salt'
alias salt-key='sudo salt-key'
alias salt-cloud='sudo salt-cloud'
alias salt-run='sudo salt-run'
alias salt-call='sudo salt-call'
alias hald='sudo hald --daemon=yes --verbose=yes'

# Program defaults
alias preview='feh -g 700x700 -d'
alias mkisofs-qick='mkisofs -R -l -J'
alias bundleupdate='vim -c BundleUpdate -c qa'

# To keep typos alive
alias snv="svn"
alias cim="vim"
alias bim="vim"
alias svim="vim"
alias vom="vim"
alias suod="sudo"
alias sduo="sudo"
alias vm="mv"
alias got='git'

# Django shortcuts
alias runserver="./manage.py runserver"
alias runsslserver="./manage.py runsslserver 0.0.0.0:1115"

# Get some bash completion
# Use eselect bashcomp to manage symlinks
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

function venv() {
    # Use cwd for virtualenv name
    venv_name=${PWD##*/}

    # If this virtualenv is not active
    if [[ "$VIRTUAL_ENV" != "$PWD/.pyenv/$venv_name" ]]; then

        echo 'deactivating virtualenv'
        # Deactivate current virtualenv
        [[ $VIRTUAL_ENV ]] && deactivate

        # Create new virtualenv if needed
        [[ ! -f .pyenv/$venv_name/bin/activate ]] && rm -rf .pyenv && virtualenv .pyenv/$venv_name

        # Activate virtualenv
        source .pyenv/$venv_name/bin/activate

    fi
    # Install requirements.txt if available
    [[ -f requirements.txt ]] && $(which pip) install -r requirements.txt

    # Install dev_requirements.txt if available
    [[ -f dev_requirements.txt ]] && $(which pip) install -r dev_requirements.txt

    # Install monetization requirements if available
    if [[ -f monetization/requirements/apps.txt ]]; then
        $(which pip) install -r monetization/requirements/apps.txt
    fi
}

function ve() {
    # Use cwd for virtualenv name
    venv_name=${PWD##*/}
    venv_name+="_venv"

    # If this virtualenv is not active
    if [[ "$VIRTUAL_ENV" != "$PWD/../$venv_name" ]]; then

        echo 'deactivating virtualenv'
        # Deactivate current virtualenv
        [[ $VIRTUAL_ENV ]] && deactivate

        # Create new virtualenv if needed
        [[ ! -f ../$venv_name/bin/activate ]] && python3.8 -m venv ../$venv_name

        # Activate virtualenv
        source ../$venv_name/bin/activate

    fi
    # Install requirements.txt if available
    [[ -f requirements.txt ]] && $(which pip) install -r requirements.txt

}

function rmpyc() {
    find . -name "*.pyc" -exec rm -rf {} \;
}
