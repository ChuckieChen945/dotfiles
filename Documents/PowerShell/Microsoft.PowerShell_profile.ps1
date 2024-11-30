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

# init zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
$paths = @(
    "C:\Users\Chuckie\.local\share\chezmoi",
    "C:\Users\Chuckie\scoop\apps",
    "C:\Users\Chuckie\scoop\persist",
    "D:\zzz_test",
    "D:\Chuckie\OneDrive\Desktop",
    "D:\Downloads\",
    "D:\Downloads\scoop_cache"
)
foreach ($path in $paths) {
    z add $path
}
