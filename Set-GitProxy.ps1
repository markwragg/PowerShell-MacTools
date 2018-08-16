function Set-GitProxy {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        #One or more Proxy settings, with server and port separated via a ':'.
        [Parameter(Mandatory, Position = 0)]
        [string[]]
        $Proxy
    )
    begin {
        If ((@($Proxy).count -gt 1) -and (-not (Get-Command 'Test-Connection' -ErrorAction SilentlyContinue))) { 
            Write-Warning 'Set-GitProxy could not run automatically. Use Set-GitProxy to set one of these manually:'
            $Proxy
            Break
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
                        
            If ((@($Proxy).count -eq 1) -or (Test-Connection $Server -TCPPort $Port -TimeoutSeconds 1 -Quiet)) {
                Try {
                    If ($PSCmdlet.ShouldProcess($ProxyEntry)) {
                        git config --global http.proxy $ProxyEntry
                        git config --global https.proxy $ProxyEntry
                        Write-Host "Git proxy has been set to $ProxyEntry" -ForegroundColor Green
                    }
                    Break ProxyCheck
                }
                Catch {
                    Throw $_
                }
            }
        }        
    }
}