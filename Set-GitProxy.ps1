function Set-GitProxy {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        #One or more Proxy settings, with server and port separated via a ':'.
        [Parameter(ValueFromPipeline,Mandatory,Position=0)]
        [string[]]
        $Proxy
    )
    begin {
        if (-not (Get-Command 'Test-Connection' -ErrorAction SilentlyContinue)) { 
            Write-Warning 'Set-GitProxy could not run as it requires the Test-Connection cmdlet.'
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
            
            If (Test-Connection $Server -TCPPort $Port -TimeoutSeconds 1 -Quiet) {
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