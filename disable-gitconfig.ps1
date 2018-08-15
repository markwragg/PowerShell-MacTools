function disable-gitconfig {
    if (Test-Path $home/.gitconfig){
        Get-ChildItem $home/.gitconfig -Hidden | Rename-Item -NewName .gitconfig.disabled
    }
    
}