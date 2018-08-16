# PowerShell-MacTools

Various PowerShell functions that are probably only useful to me specifically on my Mac.

## Cmdlets

A full list of cmdlets in this module is provided below for reference. Use `Get-Help <cmdlet name>` with these to learn more about their usage.

Cmdlet            | Description
------------------| -------------------------------------------------------------------------------------------------------
Set-GitProxy      | Sets the Global Git HTTP and HTTPS Proxy setting to a specified server and port, or if you provide an array of server:port strings, will test each in turn and set the proxy to the first to respond (this requires PS 6.1+ on Mac).
Disable-GitConfig | Renames the .gitconfig file in your home directory to .gitconfig.disabled. Useful because I have Git proxy settings for work that do not work at home.
Enable-GitConfig  | Renames the .gitconfig file in your home directory back to .gitconfig.
Rename-ToLower    | Renames a file to the same name but all lowercase. Just to make it easier to navigate case sensitive filesystem.

