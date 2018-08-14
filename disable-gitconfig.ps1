function disable-gitconfig {
    Get-ChildItem $home/.gitconfig -Hidden | Rename-Item -NewName .gitconfig.disabled
}