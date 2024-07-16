#!/usr/bin/env pwsh

Write-Output "::group::powershell $($PSCommandPath)"

$Action = $env:GITHUB_ACTION_PATH.Substring(($env:GITHUB_ACTION_PATH.IndexOf('_actions/') + 9))

Write-Output "- Checking runner OS"
if ($env:RUNNER_OS -ne 'Windows') {
    Write-Output "::error::$Action can only run on Windows runners!"
    exit 1
}

if ($env:RUNNER_ARCH -notin @('X86', 'X64', 'ARM', 'ARM64')) {
    Write-Output "::error::$Action does not support your machine's architecture."
    exit 1
}

Write-Output "::endgroup::"

exit 0
