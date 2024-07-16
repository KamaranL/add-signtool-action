<##
#   add-signtool-action
#>

Write-Output "::group::powershell $($PSCommandPath)"

try {
    $Arch = ($env:RUNNER_ARCH).ToLower()
    $SearchBase = "${env:ProgramFiles(x86)}\Windows Kits\10\bin"

    "Searching `"$SearchBase`" for signtool ($Arch)..."
    $Tool = Get-ChildItem $SearchBase -Recurse -Force -ErrorAction SilentlyContinue |
        Where-Object {$_.Name -eq 'signtool.exe' -and $_.Directory -like "*\$Arch"} |
        Sort-Object -Descending |
        Select-Object -First 1

    if (!($Tool)) {throw [System.IO.FileNotFoundException]::new('File not found.', 'signtool.exe')}

    'Adding signtool to PATH'
    $Tool.Directory.FullName | Out-File $env:GITHUB_PATH -Append
    "signtool-$Arch=$($Tool.FullName)" | Out-File $env:GITHUB_OUTPUT -Append
    $env:PATH = "$($Tool.Directory.FullName);$env:PATH"

    signtool.exe /h
} catch {
    Write-Output "::error::$($_.Exception)"
    Write-Output '::endgroup::'

    exit 1
}

Write-Output '::endgroup::'

exit 0
