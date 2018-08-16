function Set-Proxy {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        #One or more Proxy settings, with server and port separated via a ':'.
        [Parameter(Mandatory, Position = 0)]
        [string[]]
        $Proxy,

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
    begin {
        If (@($Proxy).count -gt 1) {
            If (-not (Get-Command 'Test-Connection' -ErrorAction SilentlyContinue)) { 
                Write-Warning "Set-Proxy could not run as it requires the Test-Connection cmdlet. -Proxy list:"
                $Proxy
                Break
            }
            Else {
                If ($PSCmdlet.ShouldProcess('Unset git proxy')) {
                    If ($System -or $All) {
                        $env:http_proxy = $null
                        $env:https_proxy = $null  
                    }
                    If ($Git -or $All) {
                        git config --global --unset http.proxy
                        git config --global --unset https.proxy
                    }
                }
            }
        }
    }
    process {
        :ProxyCheck ForEach ($ProxyEntry in $Proxy) {
                        
            If ($ProxyEntry -match ':') {
                $Server = ($ProxyEntry -Split ':')[0]
                $Port = ($ProxyEntry -Split ':')[1]
            }
            Else {
                $Server = $ProxyEntry
                $Port = 80
            }

            If ((@($Proxy).count -eq 1) -or (Test-Connection $Server -TCPPort $Port -Quiet)) {
                If ($PSCmdlet.ShouldProcess($ProxyEntry)) {
                    Try {
                        If ($System -or $All) {
                            $env:http_proxy = $ProxyEntry
                            $env:https_proxy = $ProxyEntry
                            Write-Host "System Proxy has been set to $ProxyEntry" -ForegroundColor Green
                        }
                    }
                    Catch {
                        Throw $_
                    }

                    Try {
                        If ($Git -or $All) {
                            git config --global http.proxy $ProxyEntry
                            git config --global https.proxy $ProxyEntry
                            Write-Host "Git Proxy has been set to $ProxyEntry" -ForegroundColor Green
                        }
                    }
                    Catch {
                        Throw $_
                    }
                }
                #We have set a working Proxy, so stop the loop.
                Break ProxyCheck
            }
        }
    }
}