$GroupsOU = "OU=Groups,OU=FrodoCorp,DC=corp,DC=example,DC=test"

$Groups = @(
    "GG_Finance_Users",
    "GG_HR_Users",
    "GG_IT_Users",
    "GG_Operations_Users",
    "GG_Sales_Users"
)

foreach ($Group in $Groups) {

    $ExistingGroup = Get-ADGroup `
        -Filter "Name -eq '$Group'" `
        -SearchBase $GroupsOU `
        -ErrorAction SilentlyContinue

    if ($ExistingGroup) {
        Write-Host "$Group already exists"
    }
    else {
        New-ADGroup `
            -Name $Group `
            -SamAccountName $Group `
            -GroupCategory Security `
            -GroupScope Global `
            -Path $GroupsOU

        Write-Host "Created $Group"
    }
}