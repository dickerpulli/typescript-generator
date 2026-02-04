
# Releases latest build to Maven Central Repository
# Prerequisites:
# - gpg with signing key without passphrase
# - OSSRH_USERNAME
# - OSSRH_PASSWORD

if (-not $env:OSSRH_USERNAME -or -not $env:OSSRH_PASSWORD) {
    Write-Error "Please set OSSRH_USERNAME and OSSRH_PASSWORD environment variables"
    exit 1
}

$ErrorActionPreference = "Stop"

# download
$zipFile = ./build/download-appveyor-artifacts.ps1

# upload
$repoUri = "https://central.sonatype.com/api/v1/publisher/upload"
$credential = New-Object -TypeName System.Net.NetworkCredential -ArgumentList $env:OSSRH_USERNAME, $env:OSSRH_PASSWORD
$headers = @{"Authorization" = "Bearer " + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($credential.UserName + ":" + $credential.Password))}
Write-Host -ForegroundColor DarkCyan "Uploading $zipFile to $repoUri..."
Invoke-WebRequest -Form @{ bundle = Get-Item $zipFile } -Method Post "$repoUri" -Headers $headers -UseBasicParsing | Out-Null

Write-Host -ForegroundColor Cyan "Build successfully uploaded. Go to https://central.sonatype.com and promote the release."
