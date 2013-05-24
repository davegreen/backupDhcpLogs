Readme - backupDHCPLogs
====================

Description
---------------------

A PowerShell module that provides an easy way to backup and manage DHCP logs and configuration.
This module requires [PowerShell v3](http://www.microsoft.com/en-gb/download/details.aspx?id=34595) from Microsoft.

### Features

- Backs DHCP logs from the previous day.
- Ability to backup the DHCP server configuration.

### To Do

- Add full backup of all logs.

Setting Up
---------------------

### [Enabling scripts in PowerShell](http://technet.microsoft.com/en-us/library/hh849812.aspx)

By default, PowerShell will not let you run unsigned modules and scripts and will only work in interactive mode. In order to run this module from a local drive, you will need to alter this behaviour. To do this, run PowerShell as an Administrator, then run the following command:

> Set-ExecutionPolicy RemoteSigned

Usage
---------------------


Contact
---------------------

For help, feedback, suggestions or bugfixes please check out [http://tookitaway.co.uk/](http://tookitaway.co.uk/) or contact david.green@tookitaway.co.uk.
