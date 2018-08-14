function enable-gitconfig {
    Get-ChildItem $home/.gitconfig.disabled -Hidden | Rename-Item -NewName .gitconfig -Force
}