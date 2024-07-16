#!/usr/bin/env pwsh

Write-Output "::group::powershell $($PSCommandPath)"

Write-Output "- Checking runner OS"
if ($env:RUNNER_OS -ne 'Windows') {
    Write-Output "::error::$($env:GITHUB_ACTION_PATH.Substring(($env:GITHUB_ACTION_PATH.IndexOf('_actions/') + 9)))"
    exit 1
}

Write-Output "::endgroup::"

exit 0
