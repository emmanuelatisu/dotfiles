# ~/.bashrc - interactive bash setup, shared across machines.
# Managed by mise. Anything machine-specific belongs in ~/.bashrc.d/.

# Only configure interactive shells. Without this, a remote command such as
# `ssh host somecmd` would run the zoxide init below and corrupt its output.
case $- in
  *i*) ;;
  *) return ;;
esac

# System-wide config. Fedora and RHEL name it /etc/bashrc and expect ~/.bashrc
# to pull it in; Debian, Arch and MSYS use /etc/bash.bashrc and bash usually
# loads it itself. Sourcing whichever exists is safe: both are idempotent.
for f in /etc/bash.bashrc /etc/bashrc; do
  if [ -r "$f" ]; then
    . "$f"
    break
  fi
done
unset f

# Put the user bin dirs first, skipping ones that do not exist and never
# duplicating an entry in nested shells.
for d in "$HOME/.local/bin" "$HOME/bin"; do
  case ":$PATH:" in
    *":$d:"*) ;;
    *) [ -d "$d" ] && PATH="$d:$PATH" ;;
  esac
done
unset d
export PATH

# Keep history useful across multiple terminals without imposing custom size
# limits. A leading space keeps a command out of history when needed.
HISTCONTROL=ignoreboth
shopt -s histappend

# Common GNU-style colors and directory-listing shortcuts. `dircolors` is
# optional, so shells without it keep working normally.
if command -v dircolors >/dev/null 2>&1; then
  if [ -r "$HOME/.dircolors" ]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Drop-in directory for per-machine settings: a hand-built tool's bin dir, a
# work proxy, anything that should not be shared through a public repo.
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    [ -f "$rc" ] && . "$rc"
  done
  unset rc
fi

# zoxide takes over `cd`. Guarded, so a machine without it still gets a shell.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd cd bash)"
fi

# mise is optional so the same file remains usable on machines that do not
# install it. `$HOME/.local/bin` was added to PATH above before this runs.
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
