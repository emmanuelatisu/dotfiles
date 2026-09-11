# ~/.profile - portable login-shell setup.
#
# POSIX-compatible for Linux, BSD/macOS, and Git Bash/MSYS. PowerShell does
# not read this file. Interactive Bash setup belongs in ~/.bashrc.

# Login Bash shells should get the same interactive setup as terminal shells.
if [ -n "${BASH_VERSION-}" ] && [ -r "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# Make user-installed commands available in login shells. Avoid duplicate PATH
# entries when ~/.bashrc has already added these directories.
for d in "$HOME/.local/bin" "$HOME/bin"; do
  case ":${PATH-}:" in
    *":$d:"*) ;;
    *) [ -d "$d" ] && PATH="$d:$PATH" ;;
  esac
done
unset d
export PATH
