#Requires -RunAsAdministrator
# TODO:auto run using chezmoi
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
powercfg -s e9a42b02-d5df-448d-aa00-03f14749eb61
# Windows PowerShell does not use UTF-8 encoding by default,
# so it is necessary to use entirely English characters to avoid errors.

# Disable Windows Defender, as the downloaded KMS tool might be detected as a virus
Set-MpPreference -DisableRealtimeMonitoring $true
Add-MpPreference -ExclusionPath 'D:\Downloads\scoop_cache'
Add-MpPreference -ExclusionPath "$env:USERPROFILE\scoop"

# Modify the registry, which includes actions like disabling UAC, which should be done before installing software
$regFiles = @(
    "https://raw.githubusercontent.com/ChuckieChen945/dotfiles/refs/heads/main/my_reg.reg",
    "https://raw.githubusercontent.com/ChuckieChen945/dotfiles/refs/heads/main/my_reg_edge_extensions.reg"
)
foreach ($uri in $regFiles) {
    $tempFile = Join-Path $env:Temp (Split-Path $uri -Leaf)
    # Download the registry file
    Invoke-WebRequest -Uri $uri -OutFile $tempFile
    # Import the registry file
    reg import $tempFile
    Remove-Item $tempFile
}
Stop-Process -Name explorer -Force; Start-Process explorer

$specialFolders = @(
    "$env:USERPROFILE\Downloads",
    "$env:USERPROFILE\Desktop"
)
# Create a Shell.Application object
$shell = New-Object -ComObject Shell.Application
# Move to the Recycle Bin
foreach ($folderPath in $specialFolders) {
    if (Test-Path $folderPath) {
        # Get the folder Shell object
        $folder = $shell.Namespace((Get-Item $folderPath).Parent.FullName).ParseName((Get-Item $folderPath).Name)
        $shell.NameSpace(10).MoveHere($folder)
    }
}

# TODO: Automatically update the hosts in the dotfile via GitHub user action https://github.com/Ruddernation-Designs/Adobe-URL-Block-List 
# TODO: Right-click to create a new text file directly without other options

# Install Scoop with administrator privileges
Invoke-Expression "& {$(Invoke-RestMethod 'https://get.scoop.sh')} -RunAsAdmin"

$BackupPaths = @(
    # "V2RayN configuration"
    "$env:USERPROFILE\scoop\persist\v2rayn\guiConfigs\",
    # "GitHub keys"
    "$env:USERPROFILE\.ssh\",
    # "Anki data"
    "$env:USERPROFILE\scoop\persist\anki\data\",
    # "Scoop Buckets"
    "$env:USERPROFILE\scoop\buckets\",
    # "VSCode extensions"
    "$env:USERPROFILE\scoop\persist\vscode\data\extensions\"
)
# Restore
foreach ($path in $BackupPaths) {
    $tempPath = Join-Path "D:\Downloads\reinstall_backup" (Split-Path $path -Leaf)
    Copy-Item -Path $tempPath -Destination (Split-Path $path -Parent) -Recurse -Force
}

Enable-WindowsOptionalFeature -FeatureName "VirtualMachinePlatform" -All -Online -NoRestart
Enable-WindowsOptionalFeature -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -Online -NoRestart

scoop import "https://raw.githubusercontent.com/ChuckieChen945/dotfiles/refs/heads/main/scoop_file.json"

chezmoi init --apply --force ChuckieChen945

# reload profile file
& $PROFILE
$paths = @(
    "$env:USERPROFILE\.local\share\chezmoi",
    "$env:USERPROFILE\scoop\apps",
    "$env:USERPROFILE\scoop\persist",
    "$env:USERPROFILE\scoop\persist\anki\data"
    "D:\zzz_test",
    "D:\Chuckie\OneDrive\Desktop",
    "D:\Downloads\",
    "D:\Downloads\scoop_cache"
)
$o = new-object -com shell.application
foreach ($path in $paths) {
    z add $path | Out-Null
    # FIXME: This operation cannot be performed
    # $o.Namespace($path).Self.InvokeVerb("pintohome")
}

$SymbolicLink = "$env:USERPROFILE\scoop\apps\anki\current\data\163\collection.media"
$TargetPath = "$env:USERPROFILE\scoop\apps\anki\current\data\qq\collection.media"
# Create a symbolic link
New-Item -ItemType SymbolicLink -Path $SymbolicLink -Target $TargetPath -ErrorAction SilentlyContinue

# TODO: Move hosts

# TODO: Keep the browser running in the background for quick startup
# * [ ] Automatically manage the list of websites compatible with the IE browser, manage the list of trusted sites, open websites with Edge browser using IE compatibility mode, see the various steps in the "Settings Guide" on the China Patent Electronic Application website and the settings of various online banks
# * [ ] Manage the list of websites compatible with IE in the new Edge browser
# TODO: Open the browser with a shortcut key
# TODO: Set the address bar to zhihu.com


# Enable hibernation
powercfg -h on

# TODO: Sophia
# * [ ] Regularly automatically download the latest version of win10 images, common software installation packages, universal driver assistants, etc., and store them in a specified directory on the hard disk for backup
#       https://github.com/bin456789/reinstall
#       https://github.com/pbatard/Fido
# * [ ] Hardware health management (especially hard disk health management)
# https://github.com/awesome-windows11/windows11

# https://github.com/VikasSukhija/Downloads

# https://github.com/Disassembler0/Win10-Initial-Setup-Script

# https://github.com/psake/psake

# https://github.com/nightroman/Invoke-Build

# https://github.com/fleschutz/PowerShell

# https://github.com/MicksITBlogs/PowerShell

# https://github.com/pester/Pester

# https://static.kancloud.cn/chandler/microsoft/2270285

# TODO: Study Sophia's
# SetUserShellFolderLocation function
# UninstallUWPApps
# dnsmasq-china-list
# https://github.com/ikas-mc/ContextMenuForWindows11


# Automatically jump to the Home virtual desktop after booting

# https://github.com/valinet/ExplorerPatcher/

# Remap keyboard keys
# https://github.com/randyrants/sharpkeys

# https://github.com/0x6d69636b/windows_hardening

# https://gist.github.com/alirobe/7f3b34ad89a159e6daa1

# * [ ] One-click creation of a boot disk and copying of common files
# * [ ] Learn Power apps and Power Automate

# * [ ] Automatic push of release notes for software like Photoshop, vscode

# * [ ] Push of popular TV series
# * [ ] Industry information such as programming language rankings and software market share, regular automatic push of data

# * [ ] Automatic push from news media like AppSo, Chai Pian Jun, etc.

# * [ ] Release dates and box office data of popular movies
# * [ ] Information push from major film festivals

# * [ ] Automatic email push of magazines like The New Yorker, The Economist, Southern Weekend, and push to Kindle

# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false
powercfg -s 381b4222-f694-41f0-9685-ff5bb260df2e

Write-Host "All done. "
Write-Host "The following items need to be done manually:"
Write-Host "  * [] Set up a picture password"
