# enable Terminal-Icons module
# https://github.com/devblackops/Terminal-Icons
Import-Module -Name Terminal-Icons

# enable prediction
Set-PSReadLineOption -PredictionSource History

# enable starship
Invoke-Expression (&starship init powershell)

# gsudo has a PowerShell module that adds `gsudo !!` to elevate the last command.
# Use the module by running: 'Import-Module gsudoModule'.
# Add it to your $PROFILE to make it permanent.
Import-Module gsudoModule

# enable scoop completion in current shell, use absolute path because PowerShell Core not respect $env:PSModulePath
# Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
# 需要安装scoop-completion
# scoop install scoop-completion -bucket extras
Import-Module scoop-completion