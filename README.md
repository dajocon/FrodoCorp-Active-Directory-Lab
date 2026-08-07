## Current Status

The first domain controller is running and the basic Active Directory
structure is in place.

DC01 currently provides Active Directory Domain Services and DNS for
corp.example.test.

I have also created the organizational unit structure, department
security groups, and the first set of test user accounts.

## Environment

| System | Role | IP Address | Status |
|---|---|---:|---|
| DC01 | Domain controller and DNS server | 10.10.10.10 | Running |
| DC02 | Additional domain controller and DNS server | 10.10.10.11 | Planned |
| FS01 | Department file server | 10.10.10.20 | Planned |
| CL01 | Employee workstation | 10.10.10.101 | Planned |
| CL02 | Troubleshooting workstation | 10.10.10.102 | Planned |


| Setting | Value |
|---|---|
| DNS domain | corp.example.test |
| NetBIOS name | CORP |
| Forest | corp.example.test |
| First domain controller | DC01 |



### Completed

1. Created the GitHub repository and project structure.
2. Installed Oracle VirtualBox.
3. Created the FrodoCorp-NAT virtual network.
4. Installed Windows Server 2025 on DC01.
5. Installed Windows updates and VirtualBox Guest Additions.
6. Configured DC01 with the static address 10.10.10.10.
7. Tested gateway, internet, and DNS connectivity.
8. Created a clean pre-Active Directory snapshot.
9. Installed Active Directory Domain Services.
10. Created the corp.example.test forest and domain.
11. Installed and configured DNS on DC01.
12. Created a reverse DNS lookup zone.
13. Verified SYSVOL, NETLOGON, DNS records, and domain services.
14. Investigated DCDiag warnings from the initial domain setup.
15. Created the FrodoCorp organizational unit structure.
16. Created department security groups.
17. Created test employee accounts with PowerShell.
18. Added each employee to the correct department security group.

### Next

The next phase is CL01, the first employee workstation.

I will install Windows on CL01, configure it to use DC01 for DNS, join
it to corp.example.test, and test a real domain login with one of the
employee accounts.
