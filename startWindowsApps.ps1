# PowerShell script to start a set of Windows apps
# Author: Chris Lamke

#Check whether an app is running and, if not, start it.
Function startProcessIfNotRunning($processName, $processPath, $processArgs)
{
  Write-Host "Checking to see if" $processName "is running"

  # Determine whether process is running. If not, start it.
  $process = Get-Process $processName -ErrorAction SilentlyContinue
  if ($process) {
    Write-Host $processName "is already running"
  }
  else {
    Write-Host "Starting" $processName
    if ($processArgs) {
      Start-Process -FilePath $processPath -ArgumentList $processArgs
    }
    else {
      Start-Process -FilePath $processPath
    }

  }
}

#Start an intance of a process without checking whether it's running.
Function startProcess($processName, $processPath, $processArgs)
{
  Write-Host "Starting" $processName
  if ($processArgs) {
    Start-Process -FilePath $processPath -ArgumentList $processArgs
  }
  else {
    Start-Process -FilePath $processPath
  }
}

#Read arguments from a text file and create a string from them.
Function getProcessArgs($filePath)
{
  $fileContents = ""
  foreach($line in (Get-Content $filePath)){
    $fileContents += $line + " "
  }
  $fileContents = $fileContents.Trim()
  return $fileContents
}


# *** Start of script main() routine ***

#Set script window title
$Host.UI.RawUI.WindowTitle = "Starting portable apps"

#Start apps
Write-Host "Starting Apps"
startProcess "C:\WINDOWS\explorer.exe" "C:\Users\chris\OneDrive\crl"
startProcessIfNotRunning "firefox" "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
startProcessIfNotRunning "chrome" "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
startProcessIfNotRunning "Ditto" "H:\crl\tools\DittoPortable_64bit_3_21_223_0\Ditto\Ditto.exe"
startProcessIfNotRunning "Greenshot" "H:\crl\tools\Greenshot-NO-INSTALLER-1.2.10.6-RELEASE\Greenshot.exe"
#startProcessIfNotRunning "outlook" "C:\Program Files (x86)\Microsoft Office\Office16\outlook.exe"
#startProcessIfNotRunning "KeePass" "H:\crl\toolApps\KeePass-2.35\KeePass.exe"

#Wait a bit for apps to finish starting and user to read run status before exiting and closing script window
Start-Sleep -Seconds 2

$processArgs = getProcessArgs("C:\Users\chris\OneDrive\crl\dev\data\startup-pages.txt")
Write-Host "processArgs is " $processArgs
startProcess "firefox" "C:\Program Files\Mozilla Firefox\firefox.exe" $processArgs
