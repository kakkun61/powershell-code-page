# powershell-code-page

*NO NEED TO REMEMBER 65001*

[![GitHub Actions: install](https://github.com/kakkun61/powershell-code-page/workflows/install/badge.svg)](https://github.com/kakkun61/powershell-code-page/actions?query=workflow%3Ainstall) [![GitHub Actions: lint](https://github.com/kakkun61/powershell-code-page/workflows/lint/badge.svg)](https://github.com/kakkun61/powershell-code-page/actions?query=workflow%3Alint) [![PowerShell Gallery](https://img.shields.io/powershellgallery/p/code-page.svg)](https://www.powershellgallery.com/packages/code-page/) [![Join the chat at https://gitter.im/powershell-code-page/community](https://badges.gitter.im/powershell-code-page/community.svg)](https://gitter.im/powershell-code-page/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Usage

```
> Set-CodePage japanese
  0:   932    shift_jis                  ANSI/OEM Japanese; Japanese (Shift-JIS)
  1: 10001    x-mac-japanese             Japanese (Mac)
  2: 20290    IBM290                     IBM EBCDIC Japanese Katakana Extended
  3: 20932    EUC-JP                     Japanese (JIS 0208-1990 and 0212-1990)
  4: 50220    iso-2022-jp                ISO 2022 Japanese with no halfwidth Katakana; Japanese (JIS)
  5: 50221    csISO2022JP                ISO 2022 Japanese with halfwidth Katakana; Japanese (JIS-Allow 1 byte Kana)
  6: 50222    iso-2022-jp                ISO 2022 Japanese JIS X 0201-1989; Japanese (JIS-Allow 1 byte Kana - SO/SI)
  7: 50930                               EBCDIC Japanese (Katakana) Extended
  8: 50931                               EBCDIC US-Canada and Japanese
  9: 50939                               EBCDIC Japanese (Latin) Extended and Japanese
 10: 51932    euc-jp                     EUC Japanese
Enter the number which you select [0-10]: 0
chcp 932
```

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

The list of code pages is based on [Code Page Identifiers - Win32 apps | Microsoft Docs](https://docs.microsoft.com/en-us/windows/win32/intl/code-page-identifiers).
