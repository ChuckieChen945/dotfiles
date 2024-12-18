# 自用脚本。用于重装系统前的准备工作

#Requires -RunAsAdministrator

# 关闭 Windows Defender, 因为下载的kms工具可能会被判为毒
Set-MpPreference -DisableRealtimeMonitoring $true

# 下载所有软件
$response = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ChuckieChen945/dotfiles/refs/heads/main/scoop_file.json"
foreach ($app in $response.apps) {
    foreach($depends in (scoop depends "$($app.Source)/$($app.Name)")) {
        scoop download "$($depends.Source)/$($depends.Name)"
    }
}

$DownloadFolder = "D:\Downloads"
$BackupPaths = @(
    # "V2RayN配置"
    "$env:USERPROFILE\scoop\persist\v2rayn\guiConfigs\",
    # "GitHub密钥"
    "$env:USERPROFILE\.ssh\",
    # "Anki数据"
    "$env:USERPROFILE\scoop\persist\anki\data\",
    # "Scoop Buckets"
    "$env:USERPROFILE\scoop\buckets\",
    # "VSCode插件"
    "$env:USERPROFILE\scoop\persist\vscode\data\extensions\"
)

# foreach ($path in $BackupPaths) {
#     Copy-Item -Path $path -Destination "$DownloadFolder\reinstall_backup\" -Recurse -Force
# }

Write-Host "All done."
