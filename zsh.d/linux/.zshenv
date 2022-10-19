# CUDA
if [[ -d /usr/local/cuda ]]; then
  export CUDA_HOME="/usr/local/cuda"
  export CUDA_PATH="${CUDA_HOME}"
  export PATH="${CUDA_HOME}/bin:${PATH}"
  export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"
  export CUDA_DEVICE_ORDER="PCI_BUS_ID"
fi

# Homebrew on Linux
if [[ -e /home/linuxbrew/.linuxbrew ]]; then
  prefix="/home/linuxbrew/.linuxbrew"
  export PATH="${prefix}/opt/python@3.9/libexec/bin:${prefix}/bin:${PATH}"
  export MANPATH="${prefix}/share/man:${MANPATH}"
  export INFOPATH="${prefix}/share/info:${INFOPATH}"
fi
# if [[ -e /home/linuxbrew/usr ]]; then
#   prefix="/home/linuxbrew/usr"
#   path=(${prefix}/{bin,sbin}(N-/) ${path})
#   manpath=(${prefix}/share/man(N-/) ${manpath})
#   infopath=(${prefix}/share/info(N-/) ${infopath})
#   fpath=(${prefix}/share/zsh/{functions,site-functions}(N-/) ${fpath})
# fi

# XDG Base Directory Specification (Ubuntu specific)
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_DIRS="${HOMEBREW_PREFIX}/share:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR=/run/user/$(id -u)  # https://serverfault.com/a/887298

# Skip the not really helping Ubuntu global compinit
# see /etc/zsh/zshrc
skip_global_compinit=1

# gxp3
path=(${HOME}/gxp3(N-/) ${path})
