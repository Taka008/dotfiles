# PATH

## ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
unsetopt GLOBAL_RCS

## GNU/Linux 版コマンドを使えるように
path=(
  ${HOMEBREW_PREFIX}/opt/{coreutils,ed,findutils,gnu-sed,gnu-tar,grep,make,gawk,gnu-which}/libexec/gnubin(N-/)
  ${path}
)
manpath=(
  ${HOMEBREW_PREFIX}/opt/{coreutils,ed,findutils,gnu-sed,gnu-tar,grep,make,gawk,gnu-which}/libexec/gnuman(N-/)
  ${manpath}
)

path=(
  /opt/X11/bin(N-/)  # X11
  /Library/Apple/usr/bin(N-/)
  /usr/local/opt/python@3.10/libexec/bin(N-/)
  ${path}
)

## TexLive
if [[ -e /Library/TeX ]]; then
  export PATH=/Library/TeX/texbin:${PATH}
  export INFOPATH=/Library/TeX/Documentation/texmf-dist-doc/info:${INFOPATH}
  export MANPATH=/Library/TeX/Documentation/texmf-dist-doc/man:${MANPATH}
fi
