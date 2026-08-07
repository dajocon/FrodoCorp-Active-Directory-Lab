# DC01 Domain Deployment

## Objective

The goal of this phase was to turn DC01 into the first domain controller
for corp.example.test.

DC01 now provides Active Directory Domain Services and DNS.

## Server Preparation

Before installing Active Directory, I:

1. Installed Windows Server 2025.
2. Installed Windows updates.
3. Installed VirtualBox Guest Additions.
4. Confirmed the hostname was DC01.
5. Assigned the static IP address 10.10.10.10.
6. Set the gateway to 10.10.10.1.
7. Tested network and internet connectivity.
8. Created a clean VirtualBox snapshot.

I completed the basic server setup first so I would not need to change
the hostname or IP address after promotion.

## Installing Active Directory

I installed the AD DS role with:

```powershell
Install-WindowsFeature `
    -Name AD-Domain-Services `
    -IncludeManagementTools
```

This installed the Active Directory files and management tools, but it
did not create the domain.

I then promoted DC01 and created:

| Setting | Value |
|---|---|
| Domain | corp.example.test |
| NetBIOS name | CORP |
| First domain controller | DC01 |
| DNS | Installed |

After the promotion and restart, I signed in as CORP\Administrator.

## DNS Configuration

The domain promotion also installed DNS and created the records needed
by Active Directory.

I configured DC01 to use its own address as its DNS server:

10.10.10.10

This allows DC01 to resolve the private records for corp.example.test.

Public DNS requests can still be sent to external DNS forwarders.

I also created a reverse lookup zone for the 10.10.10.0/24 network.

## Validation

I verified the domain with:

Get-ADDomain
Get-ADForest
Get-ADDomainController -Filter *

I also confirmed that SYSVOL and NETLOGON were available:

Get-SmbShare -Name SYSVOL,NETLOGON

I checked the Active Directory DNS records and ran DCDiag to test the
domain controller.

## Troubleshooting

The first DCDiag runs showed older SystemLog and DFS Replication events
from the period when DC01 was being promoted.

I checked the current DNS, DFSR, SYSVOL, and NETLOGON configuration
instead of clearing the logs just to get a passing result.

The later health checks passed after the older events fell outside the
DCDiag reporting windows.

## Result

DC01 is now working as the first domain controller and DNS server for
corp.example.test.

With the domain infrastructure working, I moved on to creating OUs,
security groups, and employee accounts.