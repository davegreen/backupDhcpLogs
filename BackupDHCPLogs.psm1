Function Backup-DHCPLogs()
{
  <# 
    .Synopsis
    A function used for backing up DHCP logs from a DHCP server to a destination.

    .Description
    The function will back up DHCP logs from the a DHCP server to a destination folder. The function can also clean up logs older than a certain number of days.
    
    .Parameter Destination
    The Destination folder to put the logs.

    .Parameter RetentionDays
    Optional. The amount of days to to keep logs. If log files in the destination are older than this, they will be removed.

    .Parameter BackupConfig
    Optional. DHCP server configuration will also be backed up if you include this parameter.

    .Example
    Backup-DHCPLogs -Destination "C:\Destination\Folder"
    Backs up the DHCP logs to 'C:\Destination\Folder'

    .Example
    Backup-DHCPLogs -Destination "C:\Destination\Folder" -RetentionDays 180
    Backs up the DHCP logs to 'C:\Destination\Folder' and will delete old logs of the form 'DhcpSrvLog*' or 'DhcpV6SrvLog*' when they are older than 180 days.
        
    .Notes
    Name  : Backup-DHCPLogs
    Author: David Green
    Date  : 23/05/2013

    Requires PowerShell Version 3 or later.
    
    .Link
    http://www.tookitaway.co.uk
  #>

  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true,Position=1)][string]$Destination,
    [string]$RetentionDays,
    [switch]$BackupConfig
  )

  $yday = (Get-Date (Get-Date).AddDays(-1))
  $ydayiso8601 = (Get-Date $yday -format yyyy-MM-dd)
  $tdayiso8601 = (Get-Date -format yyyy-MM-dd)

  if(Test-Path -Path "C:\Windows\System32\dhcp\")
  {
    $logfiles = Get-ChildItem -File -Path "C:\Windows\System32\dhcp\" | Where-Object { $_.Extension -eq ".log" }
  }

  else
  {
    Throw (New-Object System.IO.DirectoryNotFoundException "Cannot find path C:\Windows\System32\dhcp\")
  }

  foreach($log in $logfiles)
  {
    if($log.name.Contains($yday.DayOfWeek.ToString().Substring(0, 3)))
    {
      Try
      {
        Copy-Item ($log.DirectoryName + "\$log") ("$Destination\$ydayiso8601-" + $log.Name)
        Write-Output ("Copied " + ($log.DirectoryName + "\$log") + " to $Destination\$ydayiso8601-" + $log.Name)
      }

      Catch
      {
        Throw "Error: $_"
      }
    }
  }
  
  if($BackupConfig)
  {
    Try
    {
      #Dump DHCP database
      netsh dhcp dump > ("$Destination\DhcpSrvDump-$tdayiso8601.txt")
      Write-Output "Dumped DHCP server configuration to $Destination\DhcpSrvDump-$tdayiso8601.txt"

      #It may be better to back up the DHCP database and configuration using
      #Backup-DHCPServer or
      #Export-DHCPServer
    }

    Catch
    {
      Throw "Error: $_"
    }
  }

  #Clean up logs older than the RetentionDays value.
  if($RetentionDays)
  {
    $retentiondate = (Get-Date (Get-Date).AddDays(-$RetentionDays))
    $oldfiles = Get-ChildItem -File -Path $Destination | Where-Object {($_.LastWriteTime -lt $retentiondate) -and ($_.Extension -eq ".log") -or ($_.Extension -eq ".txt")}

    foreach($file in $oldfiles)
    {
      if($file.Name.Contains("DhcpSrvLog") -or ($file.Name.Contains("DhcpV6SrvLog")))
      {
        Try
        {
          Remove-Item ($file.DirectoryName + "\$file")
          Write-Output ("Deleted $file from " + $file.DirectoryName)
        }

        Catch
        {
          Throw "Error: $_"
        }
      }
    }
  }
}
