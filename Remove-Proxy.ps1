function Remove-Proxy {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        #Switch: Use to have the Proxy apply to your .gitconfig.
        [Parameter(ParameterSetName='Option')]
        [switch]
        $Git,

        #Switch: Use to have the Proxy apply to your system envrironment variables.
        [Parameter(ParameterSetName='Option')]
        [switch]
        $System,

        #Switch: Use to have the Proxy apply to all available settings.
        [Parameter(ParameterSetName='All')]
        [switch]
        $All
    )

    If ($PSCmdlet.ShouldProcess('Unset Proxy')) {
        Try {
            If ($System -or $All) {
                $env:http_proxy = $null
                $env:https_proxy = $null  
                Write-Host 'System proxy has been unset.' -ForegroundColor Green  
            }
        }
        Catch {
            Throw $_
        }

        Try {
            If ($Git -or $All) {
                git config --global --unset http.proxy
                git config --global --unset https.proxy
                Write-Host 'Git proxy has been unset.' -ForegroundColor Green
            }
        }
        Catch {
            Throw $_
        }
    }   
}