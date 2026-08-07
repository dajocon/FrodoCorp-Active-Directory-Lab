$DomainDN = "DC=corp,DC=example,DC=test"

function Ensure-OU {
    param (
        [string]$Name,
        [string]$Path
    )

    $ExistingOU = Get-ADOrganizationalUnit `
        -LDAPFilter "(ou=$Name)" `
        -SearchBase $Path `
        -SearchScope OneLevel `
        -ErrorAction SilentlyContinue

    if ($ExistingOU) {
        Write-Host "$Name already exists"
    }
    else {
        New-ADOrganizationalUnit `
            -Name $Name `
            -Path $Path `
            -ProtectedFromAccidentalDeletion $true

        Write-Host "Created $Name"
    }
}

Ensure-OU -Name "FrodoCorp" -Path $DomainDN

$RootOU = "OU=FrodoCorp,$DomainDN"

$TopLevelOUs = @(
    "Users",
    "Computers",
    "Servers",
    "Groups",
    "Disabled Accounts"
)

foreach ($OU in $TopLevelOUs) {
    Ensure-OU -Name $OU -Path $RootOU
}

$Departments = @(
    "Finance",
    "Human Resources",
    "Information Technology",
    "Operations",
    "Sales"
)

$UsersOU = "OU=Users,$RootOU"

foreach ($Department in $Departments) {
    Ensure-OU -Name $Department -Path $UsersOU
}