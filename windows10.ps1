
#########################
# Windows Update
#########################

# Install all updates (and reboot as much as needed)
Set-ExecutionPolicy RemoteSigned -Force
Install-PackageProvider nuget -Force
Install-Module PSWindowsUpdate -Force
if ( (Get-WUList | Measure-Object).Count -gt 0) {
  Get-WUInstall -Install -AcceptAll -IgnoreReboot
  exit 1003  # 1003 - reboot and run the plugin again on next boot
             # https://cloudbase-init.readthedocs.io/en/latest/tutorial.html#file-execution
}
Add-Content -Path "\installed_updates.log" -Value (Get-Date)   
# Writes timestamp to file in root directory (usually C:\) when script has finished updating

#########################
# UI / Privacy Settings
#########################

# Allow RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0

# Activity Tracking: Disable
@('EnableActivityFeed','PublishUserActivities','UploadUserActivities') |% { Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\System -Name $_ -Type DWord -Value 0 }

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Disable Telemetry (requires a reboot to take effect)
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Change Explorer home screen back to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1

# Set screen to never turn off
powercfg -change -monitor-timeout-ac 0 

# Darkmode
If (-Not (Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize)) {
	New-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes -Name Personalize | Out-Null
}
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Type DWord -Value 0
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Type DWord -Value 0



#########################
# Windows 10  App Removals
#########################

# Candy Crush
Get-AppxPackage king.com.CandyCrushSaga | Remove-AppxPackage
# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
# Xbox:
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
# Windows Phone Companion
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage
# Solitaire Collection
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage
# Groove Music
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
# Movies & TV
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
# Photos
#Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
# Mail & Calendar
#Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage


# Source: https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9
#		  https://gitlab.com/erikhje/dcsg1005/-/blob/master/compendia.md
