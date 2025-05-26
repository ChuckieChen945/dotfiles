# enable Terminal-Icons module
# https://github.com/devblackops/Terminal-Icons
Import-Module -Name Terminal-Icons

# enable prediction
Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView -EditMode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+y -Function Copy -ViMode Command
Set-PSReadLineKeyHandler -Key Ctrl+p -Function Paste -ViMode Command

# enable starship
Invoke-Expression (&starship init powershell)

# gsudo has a PowerShell module that adds `gsudo !!` to elevate the last command.
# Use the module by running: 'Import-Module gsudoModule'.
# Add it to your $PROFILE to make it permanent.
Import-Module gsudoModule

# init zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# this line should be after Set-PSReadlineKeyHandler
Import-Module PSCompletions
# TODO:https://pixi.carapace.sh/#in-a-nutshell