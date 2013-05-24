Readme - backupDhcpLogs
====================

Description
---------------------

A PowerShell module that provides an easy way to backup and manage DHCP logs and configuration.
This module requires [PowerShell v3](http://www.microsoft.com/en-gb/download/details.aspx?id=34595) from Microsoft.

### Features

- Backs DHCP logs from previous days.
- Ability to backup the DHCP server configuration.

### To Do

- Add full backup of all logs.

Setting Up
---------------------

### [Enabling scripts in PowerShell](http://technet.microsoft.com/en-us/library/hh849812.aspx)

By default, PowerShell will not let you run unsigned modules and scripts and will only work in interactive mode. In order to run this module from a local drive, you will need to alter this behaviour. To do this, run PowerShell as an Administrator, then run the following command:

> Set-ExecutionPolicy RemoteSigned

Copy the module files (BackupDhcpLogs.psm1, BackupDhcpLogs.psd1) into the following directory:

> C:\Users\USERNAME\Documents\WindowsPowerShell\Modules\BackupDhcpLogs\

Usage
---------------------

### Example 1

> C:\PS>Backup-DhcpLogs -Destination "C:\Destination\Folder"

Backs up the DHCP logs to 'C:\Destination\Folder'

### Example 2

> C:\PS>Backup-DhcpLogs -Destination "C:\Destination\Folder" -RetentionDays 180

Backs up the DHCP logs to 'C:\Destination\Folder' and will delete old logs of the form 'DhcpSrvLog*' or
'DhcpV6SrvLog*' when they are older than 180 days.

Contact
---------------------

For help, feedback, suggestions or bugfixes please check out [http://tookitaway.co.uk/](http://tookitaway.co.uk/) or contact david.green@tookitaway.co.uk.
