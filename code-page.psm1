Set-StrictMode -Version Latest

Set-Variable -Name all -Option Constant -Value "All"
Set-Variable -Name identifier -Option Constant -Value "Identifier"
Set-Variable -Name name -Option Constant -Value "Name"
Set-Variable -Name information -Option Constant -Value "Information"
Set-Variable -Name def -Option Constant -Value "Default"
Set-Variable -Name exact -Option Constant -Value "Exact"
Set-Variable -Name fuzzy -Option Constant -Value "Fuzzy"

function Find-CodePageIdentifierExact {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    foreach ($cp in $CodePages) {
        if ($cp.Identifier -ceq $Search) {
            $cp
            return
        }
    }

    $null
    return
}

function Find-CodePageIdentifierFuzzy {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    $candidates = @()
    foreach ($cp in $CodePages) {
        if ($cp.Identifier -like "*$Search*") {
            $candidates += $cp
        }
    }

    $candidates
    return
}

function Find-CodePageNameExact {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    foreach ($cp in $CodePages) {
        if ($cp.'.NET Name' -ceq $Search) {
            $cp
            return
        }
    }

    $null
    return
}

function Find-CodePageNameFuzzy {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    $candidates = @()
    foreach ($cp in $CodePages) {
        if ($cp.'.NET Name' -like "*$Search*") {
            $candidates += $cp
        }
    }

    $candidates
    return
}

function Find-CodePageInfomationExact {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    foreach ($cp in $CodePages) {
        if ($cp.'Additional information' -ceq $Search) {
            $cp
            return
        }
    }

    $null
    return
}

function Find-CodePageInfomationFuzzy {
    param (
        [Parameter(Mandatory)][String]$Search,
        [Parameter(Mandatory)][Object[]]$CodePages
    )

    $candidates = @()
    foreach ($cp in $CodePages) {
        if ($cp.'Additional information' -like "*$Search*") {
            $candidates += $cp
        }
    }

    $candidates
    return
}


function Add-Spaces {
    param (
        [Parameter(Mandatory)][AllowEmptyString()][AllowNull()][String]$Message,
        [Parameter(Mandatory)][Int]$Width,
        [Parameter(Mandatory)][ValidateSet("Left", "Right")][String]$Side
    )

    $l = if ($null -eq $Message) { 0 } else { $Message.Length }
    $n = $Width - $l
    switch ($Side) {
        "Left" { "$(' ' * $n)$Message" }
        "Right" { "$Message$(' ' * $n)" }
    }
}

function Invoke-Chcp {
    param (
        [Parameter(Mandatory)][PSCustomObject]$CodePage,
        [Bool]$DryRun = $false
    )

    if ($DryRun) {
        Write-Host "chcp $($CodePage.Identifier)"
        return
    }
    chcp $CodePage.Identifier
}

# Export

# .SYNOPSIS
#   Set code page with its name.
function Set-CodePage() {
    [CmdletBinding()]
    param (
        [String]$Search = '*',
        [ValidateSet("All", "Identifier", "Name", "Information")][String]$Target = $all,
        [ValidateSet("Default", "Exact", "Fuzzy")][String]$Way = $def,
        [Switch]$DryRun = $false
    )

    $ErrorActionPreference = 'Stop'

    $codePages = Import-Csv "$($MyInvocation.MyCommand.Module.ModuleBase)\code-page.csv"

    $targets =
        switch ($Target) {
            $all { @($identifier, $name, $information) }
            Default { @($Target)}
        }

    $candidates = @()
    foreach ($t in $targets) {
        switch ($t) {
            $identifier {
                switch ($Way) {
                    $fuzzy {
                        $cps = Find-CodePageIdentifierFuzzy $Search $codePages
                        $candidates += $cps
                    }
                    Default {
                        $cp = Find-CodePageIdentifierExact $Search $codePages
                        if ($null -ne $cp) {
                            Invoke-Chcp -CodePage $cp -DryRun $DryRun
                            return
                        }
                    }
                }
            }
            $name {
                switch ($Way) {
                    $exact {
                        $cp = Find-CodePageNameExact $Search $codePages
                        if ($null -ne $cp) {
                            Invoke-Chcp -CodePage $cp -DryRun $DryRun
                            return
                        }
                    }
                    Default {
                        $cps = Find-CodePageNameFuzzy $Search $codePages
                        $candidates += $cps
                    }
                }
            }
            $information {
                switch ($Way) {
                    $exact {
                        $cp = Find-CodePageInfomationExact $Search $codePages
                        if ($null -ne $cp) {
                            Invoke-Chcp -CodePage $cp -DryRun $DryRun
                            return
                        }
                    }
                    Default {
                        $cps = Find-CodePageInfomationFuzzy $Search $codePages
                        $candidates += $cps
                    }
                }
            }
        }
    }

    $candidates = $candidates | ForEach-Object { [PSCustomObject]@{ id = [Int]::Parse($_.Identifier); original = $_ } } | Sort-Object -Property id | Get-Unique -AsString | ForEach-Object { $_.original }

    if ($null -eq $candidates) {
        Write-Warning "no code page found"
        return
    }

    $choice = Show-Menu -MenuItems $candidates -MenuItemFormatter {
        param ($c)
            $id = $c.Identifier
            $name = $c.'.NET Name'
            $info = $c.'Additional information'
            "$(Add-Spaces -Message $id -Width 5 -Side Left)    $(Add-Spaces -Message $name -Width 23 -Side Right)    $info"
    }

    if ($null -eq $choice) {
        return
    }

    Invoke-Chcp -CodePage $choice -DryRun $DryRun
}

# .SYNOPSIS
#   Lists code pages.
function Show-CodePages() {
    [CmdletBinding()]
    param ()

    $ErrorActionPreference = 'Stop'

    Import-Csv "$($MyInvocation.MyCommand.Module.ModuleBase)\code-page.csv"
}

Export-ModuleMember `
    -Function `
        Set-CodePage, `
        Show-CodePages
