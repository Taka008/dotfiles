# profiling (remove comment out below to profile)
# zmodload zsh/zprof && zprof

# LANG
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

#
# PATH
#
# zsh の機能で、path（array型シェル変数）は PATH（環境変数）と自動的に連動する
# -U: 重複したパスを登録しない
# HOME 以下の path は後で設定するので除外
# (N-/): パスが存在しなければ追加しない
typeset -U path
path=(
  {/usr{/local,},}/{bin,sbin}(N-/)
  ${path:#${HOME}/*}(N-/)
)

#
# PATH FOR MAN (MANUAL)
#
typeset -U manpath
manpath=(
  /usr{/local,}/share/man(N-/)
  ${manpath:#${HOME}/*}(N-/)
)

#
# FPATH
#
typeset -U fpath
fpath=(
  /usr{/local,}/share/zsh/{site-functions,vendor-completions}(N-/)
  ${fpath:#${HOME}/*}(N-/)
)

# PATH (SUDO)
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

if [[ $(id -u) -eq 0 ]]; then  # root user
  path=(${sudo_path} ${path})
fi

SELF="${(%):-%N}"
DOTPATH="$(dirname "${SELF:A:h}")"


# 環境によって HOMEBREW_PREFIX が異なるため候補の中から探索
for prefix in "${HOME}/.linuxbrew" "/usr/local" "/opt/homebrew"; do
  if [[ -x "${prefix}/bin/brew" ]]; then
    export HOMEBREW_PREFIX="${prefix:A}"  # canonicalize
    export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
    export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
    break
  fi
done

# prefix for pip global install
export PYTHONUSERBASE="$HOME/.local"

ZBASEDIR="${DOTPATH%/}/zsh.d"
case "${OSTYPE}" in
linux*|cygwin*)
  ZSHHOME="${ZBASEDIR}/linux"
  ;;
freebsd*|darwin*)
  ZSHHOME="${ZBASEDIR}/macos"
  ;;
esac

## lv setting
export LV="-c -l"

## less setting (https://qiita.com/delphinus/items/b04752bb5b64e6cc4ea9)
export LESS="-i -M -R -F -X -x4"
# LESS="$LESS -X -F"

export LESSCHARSET='utf-8'
if [[ -e /usr/local/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
fi

if [[ -e $HOME/usr/bin/src-hilite-lesspipe.sh ]]; then
  export LESSOPEN="| $HOME/usr/bin/src-hilite-lesspipe.sh %s"
fi

# PAGER
export PAGER="less"

# EDITOR
export EDITOR=emacsclient

# PYTEST
export PYTEST_ADDOPTS='-v -s --ff'

# zmv
autoload -Uz zmv

# load environment specific configurations
source "${ZSHHOME}/.zshenv"


# load Homebrew-related variables
if [[ -n ${HOMEBREW_PREFIX} ]]; then
  path=(${HOMEBREW_PREFIX}/{bin,sbin}(N-/) ${path})
  manpath=(${HOMEBREW_PREFIX}/share/man(N-/) ${manpath})
  infopath=(${HOMEBREW_PREFIX}/share/info(N-/) ${infopath})
  fpath=(${HOMEBREW_PREFIX}/share/zsh/{functions,site-functions}(N-/) ${fpath})
fi

#
# kurolab
#
if [[ -d /mnt/poppy/home ]]; then
  source "${ZBASEDIR}/kurolab/.zshenv"
fi

#
# general paths under $HOME
#
path=(
  ${HOME}{/.local,/local,/usr}/bin(N-/)
  ${path}
)
manpath=(
  ${HOME}{/.local,/local,/usr}/share/man(N-/)
  ${manpath}
)
fpath=(
  ${HOME}{/.local,/local,/usr}/share/zsh/{functions,site-functions}(N-/)
  ${fpath}
)

# my scripts
path=(${HOME}/scripts(N-/) ${path})
