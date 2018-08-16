function Remove-GitProxy {
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    If ($PSCmdlet.ShouldProcess()) {
        Try {
            git config --global --unset http.proxy
            git config --global --unset https.proxy
            Write-Host 'Git proxy has been unset.' -ForegroundColor Green
        }
        Catch {
            Throw $_
        }
    }   
}