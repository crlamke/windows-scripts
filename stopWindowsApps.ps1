# PowerShell script to stop a set of Windows apps
# Author: Chris Lamke


#Check whether an app is running and, if so, stop it.
Function stopIfRunning($processName)
{
  Write-Host "Checking to see if" $processName "is running"

  # Determine whether process is running. If not, start it.
  $process = Get-Process $processName -ErrorAction SilentlyContinue
  if ($process) {
    Write-Host $processName "is running. Stopping it"
    # Try nicely
    Stop-Process -Name $processName 

    # Kill if still running after two seconds
    Start-Sleep -Seconds 2

    if (!$process.HasExited) {
      $process | Stop-Process -Force
    }
  }
  else {
    Write-Host $processName "is not running" 
  }   
}


# *** Start of script main() routine ***

#Set script window title
$Host.UI.RawUI.WindowTitle = "Stopping portable apps"

#Stop apps if they're running
Write-Host "Stopping Windows Apps`n"

stopIfRunning "Chrome"
stopIfRunning "Outlook"
stopIfRunning "Firefox"
stopIfRunning "Ditto"
stopIfRunning "Greenshot"
#stopIfRunning "KeePass"

#Wait a bit for apps to finish exiting
Start-Sleep -Seconds 2

