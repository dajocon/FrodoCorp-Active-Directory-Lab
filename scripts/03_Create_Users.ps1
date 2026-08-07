Import-Module ActiveDirectory

$CsvPath = "C:\Labs\Data\users.csv"
$Domain = "corp.example.test"
$RootOU = "OU=FrodoCorp,DC=corp,DC=example,DC=test"

$DepartmentConfig = @{
    "Finance" = @{
        OU    = "OU=Finance,OU=Users,$RootOU"
        Group = "GG_Finance_Users"
    }

    "Human Resources" = @{
        OU    = "OU=Human Resources,OU=Users,$RootOU"
        Group = "GG_HR_Users"
    }

    "Information Technology" = @{
        OU    = "OU=Information Technology,OU=Users,$RootOU"
        Group = "GG_IT_Users"
    }

    "Operations" = @{
        OU    = "OU=Operations,OU=Users,$RootOU"
        Group = "GG_Operations_Users"
    }

    "Sales" = @{
        OU    = "OU=Sales,OU=Users,$RootOU"
        Group = "GG_Sales_Users"
    }
}

$TemporaryPassword = Read-Host `
    "Enter a temporary password for the new users" `
    -AsSecureString

$Users = Import-Csv $CsvPath

foreach ($User in $Users) {

    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Department = $User.Department
    $Username = $User.Username

    if (-not $DepartmentConfig.ContainsKey($Department)) {
        Write-Warning "Unknown department for $Username: $Department"
        continue
    }

    $OU = $DepartmentConfig[$Department].OU
    $Group = $DepartmentConfig[$Department].Group

    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$Username'" `
        -ErrorAction SilentlyContinue

    if (-not $ExistingUser) {

        New-ADUser `
            -Name "$FirstName $LastName" `
            -GivenName $FirstName `
            -Surname $LastName `
            -DisplayName "$FirstName $LastName" `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$Domain" `
            -Department $Department `
            -Path $OU `
            -AccountPassword $TemporaryPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Write-Host "Created user: $Username"
    }
    else {
        Write-Host "$Username already exists"
    }

    $IsMember = Get-ADGroupMember -Identity $Group |
        Where-Object SamAccountName -eq $Username

    if (-not $IsMember) {
        Add-ADGroupMember `
            -Identity $Group `
            -Members $Username

        Write-Host "Added $Username to $Group"
    }
    else {
        Write-Host "$Username is already a member of $Group"
    }
}