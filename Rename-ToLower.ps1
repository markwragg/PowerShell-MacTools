function Rename-ToLower {
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # Path to rename
        [Parameter(ValueFromPipeline)]
        [String[]]
        $Path
    )
    Process {
        ForEach ($PathItem in $Path) {
            $File = Get-Item $PathItem
            $Ticks = (Get-Date).Ticks

            If ($File.name -cne $File.name.ToLower() -and $PSCmdlet.ShouldProcess($PathItem)) {
                #We have to two step rename or we get an error
                Rename-Item $File.FullName -NewName "$($File.name.ToLower()).$Ticks" -PassThru | Rename-Item -NewName $File.name.ToLower()
            }
            Else {
                Write-Warning "$File is already lowercase."
            }
        }
    }
}