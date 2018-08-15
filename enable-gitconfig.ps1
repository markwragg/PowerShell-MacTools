function enable-gitconfig {
    if (Test-Path $home/.gitconfig.disabled){
        Get-ChildItem $home/.gitconfig.disabled -Hidden | Rename-Item -NewName .gitconfig -Force
    }
}