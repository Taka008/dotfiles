# Shared programs
if [[ -d /home/linuxbrew/.local ]]; then
  prefix="/home/linuxbrew/.local"
  path=(${prefix}/{bin,sbin}(N-/) ${path})
  manpath=(${prefix}/share/man(N-/) ${manpath})
  infopath=(${prefix}/share/info(N-/) ${infopath})
  fpath=(${prefix}/share/zsh/{functions,site-functions}(N-/) ${fpath})
fi

# Prioritize nightly build of Juman++
path=(/home/linuxbrew/.local-nightly/bin(N-/) ${path})