# Business Requirements

## Organization

FrodoCorp is a fictional small business with five departments:

1. Finance
2. Human Resources
3. Information Technology
4. Operations
5. Sales

## Project Goal

I am building a small Windows domain to practice tasks used in help
desk and junior systems administration roles.

The lab will include Active Directory, DNS, Group Policy, PowerShell,
file shares, user accounts, computer accounts, and access control.

## Requirements

The lab needs to support the following:

1. Employees can sign in to domain-joined computers with domain accounts.
2. Each department has its own organizational unit.
3. Security groups control access to shared folders.
4. Group Policy manages workstation settings.
5. PowerShell handles common onboarding and offboarding tasks.
6. Windows LAPS manages local administrator passwords.
7. A second domain controller provides DNS and authentication redundancy.
8. Administrators use separate accounts for normal and privileged work.
9. The project includes testing and troubleshooting notes.
10. The documentation shows what worked, what failed, and how I fixed it.

## Success Criteria

I will consider the lab complete when:

1. Windows clients can join the FrodoCorp domain.
2. Users can sign in with domain accounts.
3. Department users receive the correct mapped drives.
4. Authorized users can access their department folders.
5. Unauthorized users receive an access denied message.
6. Group Policies apply to the correct users and computers.
7. PowerShell scripts create and disable accounts.
8. DC02 can authenticate a new user while DC01 is offline.
9. Only approved administrators can retrieve LAPS passwords.
10. I can diagnose and fix common DNS, Group Policy, and permission problems.