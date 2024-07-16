## Test script to isolate environment variables when running locally
Clear-Host

$Command = {
    $env:TEST_ROOT = '.\__testenv'
    $env:GITHUB_PATH = "$env:TEST_ROOT\github"
    $env:RUNNER_ARCH = 'X64'

    Remove-Item $env:TEST_ROOT -Recurse -Force -ErrorAction SilentlyContinue
    $null = New-Item $env:TEST_ROOT -ItemType Directory -Force -ErrorAction SilentlyContinue

    &.\Main.ps1
}

pwsh.exe -Command "&{$Command}"
