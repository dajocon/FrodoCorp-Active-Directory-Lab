# FrodoCorp-Active-Directory-Lab

## Project Summary

This project documents the design, deployment, security, automation,
testing, and troubleshooting of a simulated small-business Windows
Active Directory environment.

## Business Requirements

- Centralized authentication and identity management
- Department-based access to shared resources
- Automated user onboarding and offboarding
- Centrally managed workstation security policies
- Unique, automatically rotated local administrator passwords
- Redundant domain controllers and DNS services
- Documented troubleshooting and validation

## Environment

| System | Role | Address |
|---|---|---|
| DC01 | Active Directory Domain Services and DNS | 10.10.10.10 |
| DC02 | Additional domain controller and DNS | 10.10.10.11 |
| FS01 | Departmental file server | 10.10.10.20 |
| CL01 | Windows 11 employee workstation | 10.10.10.101 |
| CL02 | Windows 11 troubleshooting workstation | 10.10.10.102 |

## Technologies

- Windows Server 2025
- Windows 11 Enterprise
- Active Directory Domain Services
- DNS
- Group Policy
- Windows LAPS
- PowerShell
- SMB and NTFS permissions
- Hyper-V