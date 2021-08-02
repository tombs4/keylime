param (
    [Parameter(Mandatory=$true,Position=0)]
    [string[]]
    $servers,
    # the ports that will be tested
    [Parameter(mandatory=$true,position=1)]
    [string[]]
    $portlist
)



foreach ($endpoint in $servers) {
    foreach ($port in $portlist) {
        Test-NetConnection -ComputerName $endpoint -Port $port | 
            Select-Object @{
                    Label="Timestamp"
                    Expression={get-date -format yyyy-MM-ddTHH:mm:ss}
                },
                ComputerName,
                @{
                    Label="RemoteAddress"
                    Expression={($_.RemoteAddress.IPAddressToString)}
                },
                RemotePort,
                InterfaceAlias,
                TcpTestSucceeded
    }
}