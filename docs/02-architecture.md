# Architecture

## Overview

The FrodoCorp lab runs in Oracle VirtualBox on a Windows Home computer.

I originally planned to use Hyper-V. Windows Home does not include
Hyper-V, so I switched to VirtualBox and kept the rest of the lab
design.

The virtual machines use one private NAT Network. This allows them to
communicate with each other and reach the internet through the host
computer.

## Network

| Setting | Value |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Virtual network | FrodoCorp-NAT |
| Network type | NAT Network |
| IPv4 network | 10.10.10.0/24 |
| Default gateway | 10.10.10.1 |
| Internet access | VirtualBox NAT |
| VirtualBox DHCP | Disabled |

I disabled VirtualBox DHCP because I want the lab servers to use
predictable addresses.

The lab may use Windows Server DHCP later. Until then, I will configure
the required addresses manually.

## Planned Systems

| System | Role | IP Address |
|---|---|---:|
| DC01 | Domain controller, DNS server, and Global Catalog | 10.10.10.10 |
| DC02 | Additional domain controller and DNS server | 10.10.10.11 |
| FS01 | Department file server | 10.10.10.20 |
| CL01 | Employee workstation | 10.10.10.101 |
| CL02 | Troubleshooting workstation | 10.10.10.102 |

DC01 is currently the only server that has been built.

## Domain

| Setting | Value |
|---|---|
| DNS domain | corp.example.test |
| NetBIOS name | CORP |
| Forest | corp.example.test |
| First domain controller | DC01 |

## DC01 Configuration

| Setting | Value |
|---|---|
| Operating system | Windows Server 2025 Evaluation |
| Installation type | Desktop Experience |
| Processors | 2 |
| Memory | 3 GB |
| Virtual disk | 60 GB |
| IPv4 address | 10.10.10.10 |
| Subnet mask | 255.255.255.0 |
| Default gateway | 10.10.10.1 |
| DNS client | 10.10.10.10 |

## DNS Design

DC01 hosts DNS for corp.example.test.

Active Directory uses DNS records to advertise services such as domain
controllers, LDAP, Kerberos, and the Global Catalog.

DC01 points its own network adapter to 10.10.10.10. This makes sure the
server uses the DNS service that contains the private Active Directory
records.

Public DNS requests are forwarded to external DNS resolvers.

Future domain members will use DC01 and DC02 for DNS rather than using
public DNS servers directly.

I also created a reverse lookup zone for the 10.10.10.0/24 network.

Forward DNS resolves a name to an address:

```text
dc01.corp.example.test
→ 10.10.10.10
```

Reverse DNS resolves the address back to the name:

```text
10.10.10.10
→ dc01.corp.example.test
```

## Active Directory Structure

I created a top-level FrodoCorp organizational unit so the lab objects
are separated from the default Active Directory containers.

The current structure is:

```text
FrodoCorp
├── Users
│   ├── Finance
│   ├── Human Resources
│   ├── Information Technology
│   ├── Operations
│   └── Sales
├── Computers
├── Servers
├── Groups
└── Disabled Accounts
```

The OUs give me a predictable place to organize users, computers, and
servers.

They will also give me clear locations for Group Policy and delegated
administration later in the project.

## Security Groups

I created one global security group for each department:

```text
GG_Finance_Users
GG_HR_Users
GG_IT_Users
GG_Operations_Users
GG_Sales_Users
```

The OUs and security groups have different jobs.

An OU controls where an Active Directory object is organized.

A security group represents membership and can later be used when
assigning permissions.

For example, a Finance employee can live inside the Finance OU and
also be a member of GG_Finance_Users.

## Availability

DC01 is currently the only domain controller.

If DC01 is offline, new domain authentication, internal DNS, Group
Policy processing, and domain administration will be unavailable.

Later, DC02 will provide another copy of Active Directory and DNS.

If one domain controller is unavailable, the other will still be able
to provide most domain services.

## Recovery

I created a VirtualBox snapshot before installing Active Directory.

The snapshot gives me a clean lab recovery point from before DC01
became a domain controller.

I am treating the snapshot as a lab convenience, not as a replacement
for a proper Active Directory backup.