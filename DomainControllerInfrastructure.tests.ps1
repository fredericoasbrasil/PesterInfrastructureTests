# These can possibly be stripped out if a control script is used. 
$DC01 = ''
$DC02 = ''
Describe -Name 'Domain Controller Infrastructure Test' -Tags 'Infrastructure,Domain Controllers' {

    Context -Name "$DC01 Availability" {

        It -Name "$DC01 Responds to Ping" {

            $Ping = Test-NetConnection -ComputerName $DC01
            $Ping.PingSucceeded | Should -Be $true

        }

        It -Name "$DC01 Responds on Port 53" {

            $Port = Test-NetConnection -ComputerName $DC01 -Port 53
            $Port.TcpTestSucceeded | Should -Be $true

        }

        It -Name "$DC01 DNS Service is Running" {

            $DNSsvc = Get-Service -ComputerName $DC01 -DisplayName 'DNS Server'
            $DNSsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC01 ADDS Service is Running" {

            $NTDSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Domain Services'
            $NTDSsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC01 ADWS Service is Running" {

            $ADWSsvc = Get-Service -ComputerName $DC01 -DisplayName 'Active Directory Web Services'
            $ADWSsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC01 KDC Service is Running" {

            $KDCsvc = Get-Service -ComputerName $DC01 -DisplayName 'Kerberos Key Distribution Center'
            $KDCsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC01 Netlogon Service is Running" {

            $Netlogonsvc = Get-Service -ComputerName $DC01 -DisplayName 'Netlogon'
            $Netlogonsvc.Status | Should -BeExactly 'Running'

        }

    }
    Context -Name "$DC02 Availability" {

        It -Name "$DC02 Responds to Ping" {

            $Ping = Test-NetConnection -ComputerName $DC02
            $Ping.PingSucceeded | Should -Be $true

        }

        It -Name "$DC02 Responds on Port 53" {

            $Port = Test-NetConnection -ComputerName $DC02 -Port 53
            $Port.TcpTestSucceeded | Should -Be $true

        }

        It -Name "$DC02 DNS Service is Running" {

            $DNSsvc = Get-Service -ComputerName $DC02 -DisplayName 'DNS Server'
            $DNSsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC02 ADDS Service is Running" {

            $NTDSsvc = Get-Service -ComputerName $DC02 -DisplayName 'Active Directory Domain Services'
            $NTDSsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC02 ADWS Service is Running" {

            $ADWSsvc = Get-Service -ComputerName $DC02 -DisplayName 'Active Directory Web Services'
            $ADWSsvc.Status | Should -BeExactly 'Running'

        }

        It -name "$DC02 KDC Service is Running" {

            $KDCsvc = Get-Service -ComputerName $DC02 -DisplayName 'Kerberos Key Distribution Center'
            $KDCsvc.Status | Should -BeExactly 'Running'

        }

        It -Name "$DC02 Netlogon Service is Running" {

            $Netlogonsvc = Get-Service -ComputerName $DC02 -DisplayName 'Netlogon'
            $Netlogonsvc.Status | Should -BeExactly 'Running'

        }

    }
    Context -Name "Replication Status" {

        It -Name "Last Replication Result for $DC01 is 0 (Success)" {

            $RepResult = Get-ADReplicationPartnerMetaData -Target "$DC01" -PartnerType Both -Partition *
            # using $null because success is 0, and that is considered a null value
            $RepResult.LastReplicationResult | Should -BeExactly $null

        }

        It -Name "Last Replication Result for $DC02 is 0 (Success)" {

            $RepResult = Get-ADReplicationPartnerMetaData -Target "$DC02" -PartnerType Both -Partition *
            # using $null because success is 0, and that is considered a null value
            $RepResult.LastReplicationResult | Should -BeExactly $null

        }

    }
    #room for future tests if needed

}