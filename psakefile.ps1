Task Import {
    Import-Module Pester, PSScriptAnalyzer
}

Task Test {
    Invoke-Pester
}

Task Lint {
    Invoke-ScriptAnalyzer . -Recurse -Severity Information
}

Task Publish {
    Publish-Module `
        -Name ..\code-page `
        -NuGetApiKey (Get-Content .psg.key) `
        -Exclude '.github\**', '.psg.key', 'Dockerfile'
}
