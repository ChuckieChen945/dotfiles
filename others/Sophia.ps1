<#
	.SYNOPSIS
	Default preset file for "Sophia Script for Windows 11 (PowerShell 7)"

	Version: v6.1.3
	Date: 26.07.2022

	Copyright (c) 2014—2022 farag
	Copyright (c) 2019—2022 farag & Inestic

	Thanks to all https://forum.ru-board.com members involved

	.DESCRIPTION
	Place the "#" char before function if you don't want to run it
	Remove the "#" char before function if you want to run it
	Every tweak in the preset file has its' corresponding function to restore the default settings

	.EXAMPLE Run the whole script
	.\Sophia.ps1

	.EXAMPLE Run the script by specifying the module functions as an argument
	.\Sophia.ps1 -Functions "DiagTrackService -Disable", "DiagnosticDataLevel -Minimal", UninstallUWPApps

	.EXAMPLE Download and expand the latest Sophia Script version archive (without running) according which Windows and PowerShell versions it is run on
	irm script.sophi.app -useb | iex

	.NOTES
	Supported Windows 11 versions
	Versions: 21H2/22H2
	Builds: 22000.739+, 22509+
	Editions: Home/Pro/Enterprise

	.NOTES
	Set execution policy to be able to run scripts only in the current PowerShell session:
		Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

	.NOTES
	To use the TAB completion for functions and their arguments dot source the Function.ps1 script first:
		. .\Function.ps1 (with a dot at the beginning)
	Read more in the Functions.ps1 file

	.LINK GitHub link
	https://github.com/farag2/Sophia-Script-for-Windows

	.LINK Telegram channel & group
	https://t.me/sophianews
	https://t.me/sophia_chat

	.NOTES
	https://forum.ru-board.com/topic.cgi?forum=62&topic=30617#15
	https://habr.com/company/skillfactory/blog/553800/
	https://forums.mydigitallife.net/threads/powershell-windows-10-sophia-script.81675/
	https://www.reddit.com/r/PowerShell/comments/go2n5v/powershell_script_setup_windows_10/

	.LINK Authors
	https://github.com/farag2
	https://github.com/Inestic
#>

#Requires -RunAsAdministrator
#Requires -Version 7.2

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string[]]
	$Functions
)

Clear-Host

$Host.UI.RawUI.WindowTitle = "Sophia Script for Windows 11 v6.1.3 (PowerShell 7) | Made with $([char]::ConvertFromUtf32(0x1F497)) of Windows | $([char]0x00A9) farag & Inestic, 2014$([char]0x2013)2022"

# 执行这个文件前先以.号导入Sophia项目中的Function.ps1文件以导入所需模块
# 此处就不再导入了

# Remove-Module -Name Sophia -Force -ErrorAction Ignore
# Import-Module -Name $PSScriptRoot\Manifest\Sophia.psd1 -PassThru -Force

# Import module for modifying registry.pol files (Administrative Templates) of local GPOs
# Used for UpdateLGPEPolicies function
# https://www.powershellgallery.com/packages/PolicyFileEditor
# Remove-Module -Name PolicyFileEditor -Force -ErrorAction Ignore
# Import-Module -Name $PSScriptRoot\bin\PolicyFileEditor\PolicyFileEditor.psd1 -PassThru -Force

# Import-LocalizedData -BindingVariable Global:Localization -FileName Sophia -BaseDirectory $PSScriptRoot\Localizations

<#
	.SYNOPSIS
	Run the script by specifying functions as an argument
	Запустить скрипт, указав в качестве аргумента функции

	.EXAMPLE
	.\Sophia.ps1 -Functions "DiagTrackService -Disable", "DiagnosticDataLevel -Minimal", UninstallUWPApps

	.NOTES
	Use commas to separate funtions
	Разделяйте функции запятыми
#>
if ($Functions) {
	Invoke-Command -ScriptBlock { Checkings }

	foreach ($Function in $Functions) {
		Invoke-Expression -Command $Function
	}

	# The "RefreshEnvironment" and "Errors" functions will be executed at the end
	Invoke-Command -ScriptBlock { RefreshEnvironment; Errors }

	exit
}
#region Protection
<#
	The mandatory checkings. If you want to disable a warning message about whether the preset file was customized, remove the "-Warning" argument
	Please, do not comment out this function
#>
Checkings -Warning

<#
	Enable script logging. Log will be recorded into the script folder
	To stop logging just close console or type "Stop-Transcript"
#>
# Logging

# Create a restore point
# CreateRestorePoint
#endregion Protection

#region Privacy & Telemetry
<#
	Disable the "Connected User Experiences and Telemetry" service (DiagTrack), and block the connection for the Unified Telemetry Client Outbound Traffic
	Disabling the "Connected User Experiences and Telemetry" service (DiagTrack) can cause you not being able to get Xbox achievements anymore
#>
DiagTrackService -Disable

# Enable the "Connected User Experiences and Telemetry" service (DiagTrack), and allow the connection for the Unified Telemetry Client Outbound Traffic (default value)
# DiagTrackService -Enable

# Set the diagnostic data collection to minimum
DiagnosticDataLevel -Minimal

# Set the diagnostic data collection to default (default value)
# DiagnosticDataLevel -Default

# Turn off the Windows Error Reporting
ErrorReporting -Disable

# Turn on the Windows Error Reporting (default value)
# ErrorReporting -Enable

# Change the feedback frequency to "Never"
FeedbackFrequency -Never

# Change the feedback frequency to "Automatically" (default value)
# FeedbackFrequency -Automatically

# Turn off the diagnostics tracking scheduled tasks
ScheduledTasks -Disable

# Turn on the diagnostics tracking scheduled tasks (default value)
# ScheduledTasks -Enable

# Do not use sign-in info to automatically finish setting up device after an update
# SigninInfo -Disable

# Use sign-in info to automatically finish setting up device after an update (default value)
# SigninInfo -Enable

# Do not let websites provide locally relevant content by accessing language list
# LanguageListAccess -Disable

# Let websites provide locally relevant content by accessing language list (default value)
# LanguageListAccess -Enable

# Do not let apps show me personalized ads by using my advertising ID
AdvertisingID -Disable

# Let apps show me personalized ads by using my advertising ID (default value)
# AdvertisingID -Enable

# Hide the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested
# WindowsWelcomeExperience -Hide

# Show the Windows welcome experiences after updates and occasionally when I sign in to highlight what's new and suggested (default value)
# WindowsWelcomeExperience -Show

# Get tips and suggestions when I use Windows (default value)
# WindowsTips -Enable

# Do not get tips and suggestions when I use Windows
# WindowsTips -Disable

# Hide from me suggested content in the Settings app
# SettingsSuggestedContent -Hide

# Show me suggested content in the Settings app (default value)
# SettingsSuggestedContent -Show

# Turn off automatic installing suggested apps
AppsSilentInstalling -Disable

# Turn on automatic installing suggested apps (default value)
# AppsSilentInstalling -Enable

# Disable suggestions on how I can set up my device
# WhatsNewInWindows -Disable

# Let Microsoft offer you tailored expereinces based on the diagnostic data setting you have chosen (default value)
# WhatsNewInWindows -Enable

# Don't let Microsoft use your diagnostic data for personalized tips, ads, and recommendations
# TailoredExperiences -Disable

# Let Microsoft use your diagnostic data for personalized tips, ads, and recommendations (default value)
# TailoredExperiences -Enable

# Disable Bing search in the Start Menu
BingSearch -Disable

# Enable Bing search in the Start Menu (default value)
# BingSearch -Enable
#endregion Privacy & Telemetry

#region UI & Personalization
# Show the "This PC" icon on Desktop
# ThisPC -Show

# Hide the "This PC" icon on Desktop (default value)
# ThisPC -Hide

# Do not use item check boxes
CheckBoxes -Disable

# Use check item check boxes (default value)
# CheckBoxes -Enable

# Show hidden files, folders, and drives
HiddenItems -Enable

# Do not show hidden files, folders, and drives (default value)
# HiddenItems -Disable

# Show the file name extensions
FileExtensions -Show

# Hide the file name extensions (default value)
# FileExtensions -Hide

# Show folder merge conflicts
MergeConflicts -Show

# Hide folder merge conflicts (default value)
# MergeConflicts -Hide

# Open File Explorer to "This PC"
OpenFileExplorerTo -ThisPC

# Open File Explorer to Quick access (default value)
# OpenFileExplorerTo -QuickAccess

# Disable the File Explorer compact mode (default value)
# FileExplorerCompactMode -Disable

# Enable the File Explorer compact mode
# FileExplorerCompactMode -Enable

# Do not show sync provider notification within File Explorer
# OneDriveFileExplorerAd -Hide

# Show sync provider notification within File Explorer (default value)
# OneDriveFileExplorerAd -Show

# When I snap a window, do not show what I can snap next to it
# SnapAssist -Disable

# When I snap a window, show what I can snap next to it (default value)
# SnapAssist -Enable

# Show snap layouts when I hover over a windows's maximaze button (default value)
# SnapAssistFlyout -Enable

# Hide snap layouts when I hover over a windows's maximaze button
# SnapAssistFlyout -Disable

# Show the file transfer dialog box in the detailed mode
FileTransferDialog -Detailed

# Show the file transfer dialog box in the compact mode (default value)
# FileTransferDialog -Compact

# Display the recycle bin files delete confirmation dialog
# RecycleBinDeleteConfirmation -Enable

# Do not display the recycle bin files delete confirmation dialog (default value)
# RecycleBinDeleteConfirmation -Disable

# Hide recently used files in Quick access
QuickAccessRecentFiles -Hide

# Show recently used files in Quick access (default value)
# QuickAccessRecentFiles -Show

# Hide frequently used folders in Quick access
QuickAccessFrequentFolders -Hide

# Show frequently used folders in Quick access (default value)
# QuickAccessFrequentFolders -Show

# Set the taskbar alignment to the center (default value)
# TaskbarAlignment -Center

# Set the taskbar alignment to the left
TaskbarAlignment -Left

# Hide the search button from the taskbar
TaskbarSearch -Hide

# Show the search icon on the taskbar
# TaskbarSearch -Show

# Hide the Task view button from the taskbar
TaskViewButton -Hide

# Show the Task view button on the taskbar (default value)
# TaskViewButton -Show

# Hide the widgets icon on the taskbar
TaskbarWidgets -Hide

# Show the widgets icon on the taskbar (default value)
# TaskbarWidgets -Show

# Hide the Chat icon (Microsoft Teams) on the taskbar
TaskbarChat -Hide

# Show the Chat icon (Microsoft Teams) on the taskbar (default value)
# TaskbarChat -Show

# Unpin the "Microsoft Edge", "Microsoft Store" shortcuts from the taskbar
UnpinTaskbarShortcuts -Shortcuts Store

# View the Control Panel icons by large icons
ControlPanelView -LargeIcons

# View the Control Panel icons by small icons
# ControlPanelView -SmallIcons

# View the Control Panel icons by category (default value)
# ControlPanelView -Category

# Set the default Windows mode to dark
WindowsColorMode -Dark

# Set the default Windows mode to light (default value)
# WindowsColorMode -Light

# Set the default app mode to dark
AppColorMode -Dark

# Set the default app mode to light (default value)
# AppColorMode -Light

# Hide first sign-in animation after the upgrade
# FirstLogonAnimation -Disable

# Show first sign-in animation after the upgrade (default value)
# FirstLogonAnimation -Enable

# Set the quality factor of the JPEG desktop wallpapers to maximum
# JPEGWallpapersQuality -Max

# Set the quality factor of the JPEG desktop wallpapers to default
# JPEGWallpapersQuality -Default

<#
	Start Task Manager in the expanded mode
	Function works only on 22000 build due to Windows 11 22H2 has a new Task Manager with the new UI
#>
TaskManagerWindow -Expanded

<#
	Start Task Manager in the compact mode (default value)
	Function works only on 22000 build due to Windows 11 22H2 has a new Task Manager with the new UI
#>
# TaskManagerWindow -Compact

# Notify me when a restart is required to finish updating
# RestartNotification -Show

# Do not notify me when a restart is required to finish updating (default value)
# RestartNotification -Hide

# Do not add the "- Shortcut" suffix to the file name of created shortcuts
ShortcutsSuffix -Disable

# Add the "- Shortcut" suffix to the file name of created shortcuts (default value)
# ShortcutsSuffix -Enable

# Use the Print screen button to open screen snipping
# PrtScnSnippingTool -Enable

# Do not use the Print screen button to open screen snipping (default value)
# PrtScnSnippingTool -Disable

# Let me use a different input method for each app window
AppsLanguageSwitch -Enable

# Do not use a different input method for each app window (default value)
# AppsLanguageSwitch -Disable

# When I grab a windows's title bar and shake it, minimize all other windows
AeroShaking -Enable

# When I grab a windows's title bar and shake it, don't minimize all other windows (default value)
# AeroShaking -Disable
#endregion UI & Personalization

#region OneDrive
# Uninstall OneDrive. The OneDrive user folder won't be removed
# OneDrive -Uninstall

# Install OneDrive 64-bit (default value)
# OneDrive -Install
#endregion OneDrive

#region System
#region StorageSense
# Turn on Storage Sense
# StorageSense -Enable

# Turn off Storage Sense (default value)
# StorageSense -Disable

# Run Storage Sense every month
# StorageSenseFrequency -Month

# Run Storage Sense during low free disk space (default value)
# StorageSenseFrequency -Default

# Turn on automatic cleaning up temporary system and app files
# StorageSenseTempFiles -Enable

# Turn off automatic cleaning up temporary system and app files
# StorageSenseTempFiles -Disable
#endregion StorageSense

# Disable hibernation. Do not recommend turning it off on laptops
# Hibernation -Disable

# Enable hibernate (default value)
# Hibernation -Enable

# Change the %TEMP% environment variable path to %SystemDrive%\Temp
# TempFolder -SystemDrive

# Change %TEMP% environment variable path to %LOCALAPPDATA%\Temp (default value)
# TempFolder -Default

# Disable the Windows 260 characters path limit
Win32LongPathLimit -Disable

# Enable the Windows 260 character path limit (default value)
# Win32LongPathLimit -Enable

# Display the Stop error information on the BSoD
BSoDStopError -Enable

# Do not display the Stop error information on the BSoD (default value)
# BSoDStopError -Disable

# Choose when to be notified about changes to your computer: never notify
# AdminApprovalMode -Never

# Choose when to be notified about changes to your computer: notify me only when apps try to make changes to my computer (default value)
# AdminApprovalMode -Default

# Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled
# MappedDrivesAppElevatedAccess -Enable

# Turn off access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled (default value)
# MappedDrivesAppElevatedAccess -Disable

# Turn off Delivery Optimization
DeliveryOptimization -Disable

# Turn on Delivery Optimization (default value)
# DeliveryOptimization -Enable

# Always wait for the network at computer startup and logon for workgroup networks
# WaitNetworkStartup -Enable

# Never wait for the network at computer startup and logon for workgroup networks (default value)
# WaitNetworkStartup -Disable

# Do not let Windows manage my default printer
# WindowsManageDefaultPrinter -Disable

# Let Windows manage my default printer (default value)
# WindowsManageDefaultPrinter -Enable

<#
	Disable the Windows features using the pop-up dialog box
	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not disable the "Media Features" feature
#>
# WindowsFeatures -Disable

# Enable the Windows features using the pop-up dialog box
# WindowsFeatures -Enable

<#
	Uninstall optional features using the pop-up dialog box
	If you want to leave "Multimedia settings" element in the advanced settings of Power Options do not uninstall the "Media Features" feature
#>
# WindowsCapabilities -Uninstall

# Install optional features using the pop-up dialog box
# WindowsCapabilities -Install

# Receive updates for other Microsoft products
UpdateMicrosoftProducts -Enable

# Do not receive updates for other Microsoft products (default value)
# UpdateMicrosoftProducts -Disable

<#
	Set power plan on "High performance"
	It isn't recommended to turn on the "High performance" power plan on laptops
#>
# PowerPlan -High

# Set power plan on "Balanced" (default value)
# PowerPlan -Balanced

# Use the latest installed .NET runtime for all apps
LatestInstalled.NET -Enable

# Do not use the latest installed .NET runtime for all apps (default value)
# LatestInstalled.NET -Disable

# Do not allow the computer to turn off the network adapters to save power
NetworkAdaptersSavePower -Disable

# Allow the computer to turn off the network adapters to save power (default value)
# NetworkAdaptersSavePower -Enable

<#
	Disable the Internet Protocol Version 6 (TCP/IPv6) component for all network connections
	Before invoking the function, a check will be run whether your ISP supports the IPv6 protocol using https://ipv6-test.com
#>
# IPv6Component -Disable

<#
	Enable the Internet Protocol Version 6 (TCP/IPv6) component for all network connections (default value)
	Before invoking the function, a check will be run whether your ISP supports the IPv6 protocol using https://ipv6-test.com
#>
# IPv6Component -Enable

# Override for default input method: English
# InputMethod -English

# Override for default input method: use language list (default value)
# InputMethod -Default

<#
	Move user folders location to the root of any drive using the interactive menu
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %USERPROFILE% folder by default
#>
# SetUserShellFolderLocation -Root

<#
	Select folders for user folders location manually using a folder browser dialog
	User files or folders won't me moved to a new location. Move them manually
	They're located in the %USERPROFILE% folder by default
#>
# SetUserShellFolderLocation -Custom

<#
	Change user folders location to the default values
	User files or folders won't me moved to the new location. Move them manually
	They're located in the %USERPROFILE% folder by default
#>
# SetUserShellFolderLocation -Default

<#
	Save screenshots by pressing Win+PrtScr on the Desktop
	The function will be applied only if the preset is configured to remove the OneDrive application, or the app was already uninstalled
	Otherwise the backup functionality for the "Desktop" and "Pictures" folders in OneDrive breaks
#>
# WinPrtScrFolder -Desktop

# Save screenshots by pressing Win+PrtScr in the Pictures folder (default value)
# WinPrtScrFolder -Default

<#
	Run troubleshooter automatically, then notify me
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data", and the error reporting feature will be turned on
#>
# RecommendedTroubleshooting -Automatically

<#
	Ask me before running troubleshooter (default value)
	In order this feature to work the OS level of diagnostic data gathering will be set to "Optional diagnostic data"
#>
# RecommendedTroubleshooting -Default

# Launch folder windows in a separate process
# FoldersLaunchSeparateProcess -Enable

# Do not launch folder windows in a separate process (default value)
# FoldersLaunchSeparateProcess -Disable

# Disable and delete reserved storage after the next update installation
# ReservedStorage -Disable

# Enable reserved storage (default value)
# ReservedStorage -Enable

# Disable help lookup via F1
# F1HelpPage -Disable

# Enable help lookup via F1 (default value)
# F1HelpPage -Enable

# Enable Num Lock at startup
NumLock -Enable

# Disable Num Lock at startup (default value)
# NumLock -Disable

# Disable Caps Lock
# CapsLock -Disable

# Enable Caps Lock (default value)
# CapsLock -Enable

# Turn off pressing the Shift key 5 times to turn Sticky keys
StickyShift -Disable

# Turn on pressing the Shift key 5 times to turn Sticky keys (default value)
# StickyShift -Enable

# Don't use AutoPlay for all media and devices
Autoplay -Disable

# Use AutoPlay for all media and devices (default value)
# Autoplay -Enable

# Disable thumbnail cache removal
# ThumbnailCacheRemoval -Disable

# Enable thumbnail cache removal (default value)
# ThumbnailCacheRemoval -Enable

# Automatically saving my restartable apps and restart them when I sign back in
SaveRestartableApps -Enable

# Turn off automatically saving my restartable apps and restart them when I sign back in (default value)
# SaveRestartableApps -Disable

# Enable "Network Discovery" and "File and Printers Sharing" for workgroup networks
# NetworkDiscovery -Enable

# Disable "Network Discovery" and "File and Printers Sharing" for workgroup networks (default value)
# NetworkDiscovery -Disable

# Automatically adjust active hours for me based on daily usage
ActiveHours -Automatically

# Manually adjust active hours for me based on daily usage (default value)
# ActiveHours -Manually

# Restart as soon as possible to finish updating
# RestartDeviceAfterUpdate -Enable

# Don't restart as soon as possible to finish updating (default value)
# RestartDeviceAfterUpdate -Disable

<#
	Register app, calculate hash, and associate with an extension with the "How do you want to open this" pop-up hidden

	Set-Association -ProgramPath "C:\SumatraPDF.exe" -Extension .pdf -Icon "shell32.dll,100"
	Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"
#>
# Set-Association -ProgramPath "%ProgramFiles%\Notepad++\notepad++.exe" -Extension .txt -Icon "%ProgramFiles%\Notepad++\notepad++.exe,0"

# Set Windows Terminal as default terminal app to host the user interface for command-line applications
DefaultTerminalApp -WindowsTerminal

# Set Windows Console Host as default terminal app to host the user interface for command-line applications (default value)
# DefaultTerminalApp -ConsoleHost

<#
	Install the latest Microsoft Visual C++ Redistributable Packages 2015–2022 x64

	https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist
#>
InstallVCRedistx64

<#
	Install the latest .NET Desktop Runtime 6 (x86/x64)

	https://docs.microsoft.com/en-us/dotnet/core/install/windows?tabs=net60
#>
InstallDotNetRuntime6

# Enable proxying only blocked sites from the unified registry of Roskomnadzor. The function will be applied only if the region in Windows is set to "Russia"
# https://antizapret.prostovpn.org
# RKNBypass -Enable

# Disable proxying only blocked sites from the unified registry of Roskomnadzor (default value)
# https://antizapret.prostovpn.org
# RKNBypass -Disable

# Enable all necessary dependencies (reboot may require) and open Microsoft Store WSA page to install Windows Subsystem for Android™ with Amazon Appstore manually
WSA -Enable

# Disable all necessary dependencies (reboot may require) and uninstall Windows Subsystem for Android™ with Amazon Appstore (default value)
# WSA -Disable
#endregion System

#region WSL
<#
	Enable Windows Subsystem for Linux (WSL), install the latest WSL Linux kernel version, and a Linux distribution using a pop-up form
	The "Receive updates for other Microsoft products" setting will enabled automatically to receive kernel updates
#>
# WSL
#endregion WSL

#region Start menu
# Unpin all Start apps
# UnpinAllStartApps

# Run the Windows PowerShell shortcut from the Start menu as Administrator
RunPowerShellShortcut -Elevated

# Run the Windows PowerShell shortcut from the Start menu as user (default value)
# RunPowerShellShortcut -NonElevated

# Show default Start layout (for 22509+ build only) (default value)
# StartLayout -Default

# Show more pins on Start (for 22509+ build only)
StartLayout -ShowMorePins

# Show more recommendations on Start (for 22509+ build only)
# StartLayout -ShowMoreRecommendations
#endregion Start menu

#region UWP apps
<#
	Uninstall UWP apps using the pop-up dialog box
	If the "For All Users" is checked apps packages will not be installed for new users
	The "ForAllUsers" argument sets a checkbox to unistall packages for all users
#>
# UninstallUWPApps

<#
	Restore the default UWP apps using the pop-up dialog box
	UWP apps can be restored only if they were uninstalled only for the current user
#>
# RestoreUWPApps

<#
	Download and install "HEVC Video Extensions from Device Manufacturer" to be able to open .heic and .heif formats
	HEVC Video Extension is already installed in Windows 11 22H2 by default
#>
HEIF -Install

<#
	Open Microsoft Store "HEVC Video Extensions from Device Manufacturer" page to install this extension manually to be able to open .heic and .heif formats
	The extension can be installed without a Microsoft account
#>
# HEIF -Manually

# Disable Cortana autostarting
CortanaAutostart -Disable

# Enable Cortana autostarting (default value)
# CortanaAutostart -Enable

# Disable Microsoft Teams autostarting
TeamsAutostart -Disable

# Enable Microsoft Teams autostarting (default value)
# TeamsAutostart -Enable

# Check for UWP apps updates
CheckUWPAppsUpdates
#endregion UWP apps

#region Gaming
<#
	Disable Xbox Game Bar
	To prevent popping up the "You'll need a new app to open this ms-gamingoverlay" warning, you need to disable the Xbox Game Bar app, even if you uninstalled it before
#>
XboxGameBar -Disable

# Enable Xbox Game Bar (default value)
# XboxGameBar -Enable

# Disable Xbox Game Bar tips
XboxGameTips -Disable

# Enable Xbox Game Bar tips (default value)
# XboxGameTips -Enable

# Choose an app and set the "High performance" graphics performance for it. Only if you have a dedicated GPU
# SetAppGraphicsPerformance

<#
	Turn on hardware-accelerated GPU scheduling. Restart needed
	Only if you have a dedicated GPU and WDDM verion is 2.7 or higher
#>
GPUScheduling -Enable

# Turn off hardware-accelerated GPU scheduling (default value). Restart needed
# GPUScheduling -Disable
#endregion Gaming

#region Scheduled tasks
<#
	Create the "Windows Cleanup" scheduled task for cleaning up Windows unused files and updates
	A native interactive toast notification pops up every 30 days. The task runs every 30 days
#>
# CleanupTask -Register

# Delete the "Windows Cleanup" and "Windows Cleanup Notification" scheduled tasks for cleaning up Windows unused files and updates
# CleanupTask -Delete

<#
	Create the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
	The task will wait until the Windows Updates service finishes running. The task runs every 90 days
#>
# SoftwareDistributionTask -Register

# Delete the "SoftwareDistribution" scheduled task for cleaning up the %SystemRoot%\SoftwareDistribution\Download folder
# SoftwareDistributionTask -Delete

<#
	Create the "Temp" scheduled task for cleaning up the %TEMP% folder
	Only files older than one day will be deleted. The task runs every 60 days
#>
# TempTask -Register

# Delete the "Temp" scheduled task for cleaning up the %TEMP% folder
# TempTask -Delete
#endregion Scheduled tasks

#region Microsoft Defender & Security
# Enable Microsoft Defender Exploit Guard network protection
NetworkProtection -Enable

# Disable Microsoft Defender Exploit Guard network protection (default value)
# NetworkProtection -Disable

# Enable detection for potentially unwanted applications and block them
# PUAppsDetection -Enable

# Disable detection for potentially unwanted applications and block them (default value)
# PUAppsDetection -Disable

# Dismiss Microsoft Defender offer in the Windows Security about signing in Microsoft account
# DismissMSAccount

# Dismiss Microsoft Defender offer in the Windows Security about turning on the SmartScreen filter for Microsoft Edge
DismissSmartScreenFilter

# Enable events auditing generated when a process is created (starts)
# AuditProcess -Enable

# Disable events auditing generated when a process is created (starts) (default value)
# AuditProcess -Disable

<#
	Include command line in process creation events
	In order this feature to work events auditing (ProcessAudit -Enable) will be enabled
#>
# CommandLineProcessAudit -Enable

# Do not include command line in process creation events (default value)
# CommandLineProcessAudit -Disable

<#
	Create the "Process Creation" сustom view in the Event Viewer to log executed processes and their arguments
	In order this feature to work events auditing (AuditProcess -Enable) and command line (CommandLineProcessAudit -Enable) in process creation events will be enabled
#>
# EventViewerCustomView -Enable

# Remove the "Process Creation" custom view in the Event Viewer to log executed processes and their arguments (default value)
# EventViewerCustomView -Disable

# Enable logging for all Windows PowerShell modules
# PowerShellModulesLogging -Enable

# Disable logging for all Windows PowerShell modules (default value)
# PowerShellModulesLogging -Disable

# Enable logging for all PowerShell scripts input to the Windows PowerShell event log
# PowerShellScriptsLogging -Enable

# Disable logging for all PowerShell scripts input to the Windows PowerShell event log (default value)
# PowerShellScriptsLogging -Disable

# Microsoft Defender SmartScreen doesn't marks downloaded files from the Internet as unsafe
AppsSmartScreen -Disable

# Microsoft Defender SmartScreen marks downloaded files from the Internet as unsafe (default value)
# AppsSmartScreen -Enable

# Disable the Attachment Manager marking files that have been downloaded from the Internet as unsafe
SaveZoneInformation -Disable

# Enable the Attachment Manager marking files that have been downloaded from the Internet as unsafe (default value)
# SaveZoneInformation -Enable

<#
	Disable Windows Script Host
	Blocks WSH from executing .js and .vbs files
#>
# WindowsScriptHost -Disable

# Enable Windows Script Host (default value)
# WindowsScriptHost -Enable

# Enable Windows Sandbox
WindowsSandbox -Enable

# Disable Windows Sandbox (default value)
# WindowsSandbox -Disable

<#
	Enable DNS-over-HTTPS for IPv4
	The valid IPv4 addresses: 1.0.0.1, 1.1.1.1, 149.112.112.112, 8.8.4.4, 8.8.8.8, 9.9.9.9
#>
# DNSoverHTTPS -Enable -PrimaryDNS 1.0.0.1 -SecondaryDNS 1.1.1.1

# Disable DNS-over-HTTPS for IPv4 (default value)
# DNSoverHTTPS -Disable
#endregion Microsoft Defender & Security

#region Context menu
# Show the "Extract all" item in the Windows Installer (.msi) context menu
# MSIExtractContext -Show

# Hide the "Extract all" item from the Windows Installer (.msi) context menu (default value)
# MSIExtractContext -Hide

# Show the "Install" item in the Cabinet (.cab) filenames extensions context menu
# CABInstallContext -Show

# Hide the "Install" item from the Cabinet (.cab) filenames extensions context menu (default value)
# CABInstallContext -Hide

# Show the "Run as different user" item to the .exe filename extensions context menu
# RunAsDifferentUserContext -Show

# Hide the "Run as different user" item from the .exe filename extensions context menu (default value)
# RunAsDifferentUserContext -Hide

# Hide the "Cast to Device" item from the media files and folders context menu
CastToDeviceContext -Hide

# Show the "Cast to Device" item in the media files and folders context menu (default value)
# CastToDeviceContext -Show

# Hide the "Share" item from the context menu
# ShareContext -Hide

# Show the "Share" item in the context menu (default value)
# ShareContext -Show

# Hide the "Edit with Photos" item from the media files context menu
EditWithPhotosContext -Hide

# Show the "Edit with Photos" item in the media files context menu (default value)
# EditWithPhotosContext -Show

# Hide the "Create a new video" item in the media files context menu
CreateANewVideoContext -Hide

# Show the "Create a new video" item in the media files context menu (default value)
# CreateANewVideoContext -Show

# Hide the "Print" item from the .bat and .cmd context menu
PrintCMDContext -Hide

# Show the "Print" item in the .bat and .cmd context menu (default value)
# PrintCMDContext -Show

# Hide the "Include in Library" item from the folders and drives context menu
IncludeInLibraryContext -Hide

# Show the "Include in Library" item in the folders and drives context menu (default value)
# IncludeInLibraryContext -Show

# Hide the "Send to" item from the folders context menu
SendToContext -Hide

# Show the "Send to" item in the folders context menu (default value)
# SendToContext -Show

# Hide the "Turn on BitLocker" item from the drives context menu
BitLockerContext -Hide

# Show the "Turn on BitLocker" item in the drives context menu (default value)
# BitLockerContext -Show

# Hide the "Compressed (zipped) Folder" item from the "New" context menu
CompressedFolderNewContext -Hide

# Show the "Compressed (zipped) Folder" item to the "New" context menu (default value)
# CompressedFolderNewContext -Show

# Enable the "Open", "Print", and "Edit" context menu items for more than 15 items selected
# MultipleInvokeContext -Enable

# Disable the "Open", "Print", and "Edit" context menu items for more than 15 items selected (default value)
# MultipleInvokeContext -Disable

# Hide the "Look for an app in the Microsoft Store" item in the "Open with" dialog
UseStoreOpenWith -Hide

# Show the "Look for an app in the Microsoft Store" item in the "Open with" dialog (default value)
# UseStoreOpenWith -Show

# Hide the "Open in Windows Terminal" item in the folders context menu
# OpenWindowsTerminalContext -Hide

# Show the "Open in Windows Terminal" item in the folders context menu (default value)
# OpenWindowsTerminalContext -Show

# Show the "Open in Windows Terminal" (Admin) item in the Desktop and folders context menu
OpenWindowsTerminalAdminContext -Show

# Hide the "Open in Windows Terminal (Admin)" item from the Desktop and folders context menu (default value)
# OpenWindowsTerminalAdminContext -Hide

# Disable the Windows 10 context menu style (default value)
# Windows10ContextMenu -Disable

# Enable the Windows 10 context menu style
Windows10ContextMenu -Enable
#endregion Context menu

#region Update Policies
# Update Local Group Policy Editor (gpedit.msc) to make all manually created policy keys in the registry visible in the snap-in
UpdateLGPEPolicies
#endregion Update Policies

<#
	Simulate pressing F5 to refresh the desktop
	Refresh desktop icons, environment variables, taskbar
	Restart the Start menu
	Please, do not comment out this function
#>
RefreshEnvironment

<#
	Errors output
	Please, do not comment out this function
#>
Errors