# enable Terminal-Icons module
# https://github.com/devblackops/Terminal-Icons
Import-Module -Name Terminal-Icons

# enable prediction
Set-PSReadLineOption -PredictionSource History

# enable starship
Invoke-Expression (&starship init powershell)
