
# enable kmt.winget.autocomplete module
Import-Module kmt.winget.autocomplete


# enable Terminal-Icons module
Import-Module -Name Terminal-Icons


# enable prediction
Set-PSReadLineOption -PredictionSource History


# enable starship
Invoke-Expression (&starship init powershell)