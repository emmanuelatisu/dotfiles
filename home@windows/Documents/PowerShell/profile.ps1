# profile.ps1 - PowerShell 7 setup shared across Windows machines. Managed by mise.
# pwsh loads this "all hosts" profile before Microsoft.PowerShell_profile.ps1,
# which stays machine-local (installers such as coreutils write into it).

# mise puts its tools on PATH and switches versions per directory. It is
# optional so the same file remains usable on machines that do not have it.
if (Get-Command mise -ErrorAction SilentlyContinue) {
    (& mise activate pwsh) | Out-String | Invoke-Expression

    # Programs that do not start from pwsh (GUI apps, cmd, Git Bash) read PATH
    # from the registry. Add the mise shims to the user PATH once, so that they
    # also find mise tools. Windows reads the machine PATH first, so `dotnet`
    # there still resolves to the Visual Studio copy in C:\Program Files\dotnet.
    # Read and write the raw value to keep %VAR% entries and REG_EXPAND_SZ.
    $miseShims = Join-Path $env:LOCALAPPDATA 'mise\shims'
    $userPath = (Get-Item HKCU:\Environment).GetValue('Path', '', 'DoNotExpandEnvironmentNames')
    if (($userPath -split ';') -notcontains $miseShims) {
        Set-ItemProperty HKCU:\Environment -Name Path -Type ExpandString -Value "$miseShims;$userPath"
    }
}
