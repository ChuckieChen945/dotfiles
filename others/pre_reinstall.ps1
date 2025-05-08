# 自用脚本。用于重装系统前的准备工作

#Requires -RunAsAdministrator

# 关闭 Windows Defender, 因为下载的kms工具可能会被判为毒
Set-MpPreference -DisableRealtimeMonitoring $true

# 下载所有软件
$response = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ChuckieChen945/dotfiles/refs/heads/main/scoop_file.json"
foreach ($app in $response.apps) {
    foreach ($depends in (scoop depends "$($app.Source)/$($app.Name)")) {
        scoop download "$($depends.Source)/$($depends.Name)"
    }
}

# 重要!
scoop download anderlli0053_DEV-tools/v2rayn-with-core-selfcontained

$DownloadFolder = "D:\Downloads"
$BackupPaths = @(
    # "GitHub密钥"
    "$env:USERPROFILE\.ssh\"
)

foreach ($path in $BackupPaths) {
    Copy-Item -Path $path -Destination "$DownloadFolder\reinstall_backup\" -Recurse -Force
    Write-Host "Copied files: $path to $DownloadFolder\reinstall_backup\"
}

# Remove-Item -Path "D:\scoop\apps" -Recurse -Force
# Remove-Item -Path "D:\scoop\shims" -Recurse -Force

Write-Host '请确认所有软件下载完成后手动删除 "D:\scoop\apps" 和 "D:\scoop\shims"'
