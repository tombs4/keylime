param (
    # the servers or IPs to by tested
    [Parameter(Mandatory=$true,Position=0)]
    [string[]]
    $servers,
    # the ports that will be tested
    [Parameter(mandatory=$true,position=1)]
    [string[]]
    $portlist
)


# iterates throught the provided list of servers
foreach ($endpoint in $servers) {
    # on each iteration of the server list, iterates through the port list
    foreach ($port in $portlist) {
        # tests each port in the sequence provided
        Test-NetConnection -ComputerName $endpoint -Port $port | 
            # adds in the timestamp property to a new custom object created by the select-object commandlet. Adds in
            # the timestamp at the time the custom object is created.
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
                InterfaceIndex,
                TcpTestSucceeded
    }
}