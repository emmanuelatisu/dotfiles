# profile.ps1 - PowerShell 7 setup shared across Windows machines. Managed by mise.
# pwsh loads this "all hosts" profile before Microsoft.PowerShell_profile.ps1,
# which stays machine-local (installers such as coreutils write into it).

# mise puts its tools on PATH and switches versions per directory. It is
# optional so the same file remains usable on machines that do not have it.
if (Get-Command mise -ErrorAction SilentlyContinue) {
    (& mise activate pwsh) | Out-String | Invoke-Expression
}
