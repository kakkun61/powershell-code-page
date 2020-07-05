# powershell-code-page

[![GitHub Actions: install](https://github.com/kakkun61/powershell-code-page/workflows/install/badge.svg)](https://github.com/kakkun61/powershell-code-page/actions?query=workflow%3Ainstall) [![GitHub Actions: lint](https://github.com/kakkun61/powershell-code-page/workflows/lint/badge.svg)](https://github.com/kakkun61/powershell-code-page/actions?query=workflow%3Alint) [![PowerShell Gallery](https://img.shields.io/powershellgallery/p/code-page.svg)](https://www.powershellgallery.com/packages/code-page/) [![Join the chat at https://gitter.im/powershell-code-page/community](https://badges.gitter.im/powershell-code-page/community.svg)](https://gitter.im/powershell-code-page/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

*NO NEED TO REMEMBER 65001*

## Install

Download and load powershell-code-page to PowerShell.

```
> Install-Module code-page
> Import-Module code-page
```

Confirm its info.

```
> Get-Module code-page

ModuleType Version    PreRelease Name                                ExportedCommands
---------- -------    ---------- ----                                ----------------
Script     1.0                   code-page                           {Set-CodePage, Show-CodePages}
```

Show help. Add the `-Full` option for more details.

```
> Get-Help Set-CodePage

NAME
    Set-CodePage

SYNOPSIS
    Set code page with its name.


SYNTAX
    Set-CodePage [-Search] <String> [[-Target] <String>] [[-Way] <String>] [-DryRun] [<CommonParameters>]


DESCRIPTION


RELATED LINKS

REMARKS
    To see the examples, type: "Get-Help Set-CodePage -Examples"
    For more information, type: "Get-Help Set-CodePage -Detailed"
    For technical information, type: "Get-Help Set-CodePage -Full"
```

## Code Pages

The list of Code pages is based on [Code Page Identifiers - Win32 apps | Microsoft Docs](https://docs.microsoft.com/en-us/windows/win32/intl/code-page-identifiers).
