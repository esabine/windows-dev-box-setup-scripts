# Description: Boxstarter Script
# Author: Microsoft
# Common settings for azure devops

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";
#executeScript "Browsers.ps1";

#executeScript "HyperV.ps1";
#RefreshEnv
#executeScript "WSL.ps1";
#RefreshEnv
#executeScript "Docker.ps1";

choco install -y powershell-core
choco install -y azure-cli
Install-Module -Force Az
choco install -y microsoftazurestorageexplorer
#choco install -y terraform

# Install tools in WSL instance
#write-host "Installing tools inside the WSL distro..."
#Ubuntu1804 run apt install ansible -y

# remove task bar search
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Force
# remove task bar widgets
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarDa -Value 0 -Type DWord -Force
# remove task bar chat
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name TaskbarMn -Value 0 -Type DWord -Force
# remove task view button
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowTaskViewButton -Value 0 -Type DWord -Force

# install the AD part of RSAT
Get-WindowsCapability -name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0 -Online | Add-WindowsCapability -Online 

choco install powerbi -y
choco install sql-server-management-studio -y
choco install windirstat -y
choco install paint.net -y
choco install adobereader -y
choco install github-desktop -y
choco install insomnia-rest-api-client -y
choco install microsoftazurestorageexplorer -y
choco install notepadplusplus -y
# choco install sqlnexus -y
# choco install sqldiagmanager -y
choco install winmerge -y
choco install tortoisegit -y


install-module -name dbatools

choco install sql-server-2022 --skip-virus-check --confirm --params="'ACTION:Install /ENU:True /PRODUCTCOVEREDBYSA:False /SUPPRESSPRIVACYSTATEMENTNOTICE:False /QUIET:False /QUIETSIMPLE:False /UIMODE:Normal /UpdateEnabled:True /USEMICROSOFTUPDATE:False /SUPPRESSPAIDEDITIONNOTICE:False /UpdateSource:MU /FEATURES:SQLENGINE,FULLTEXT,POLYBASECORE,AS,IS /HELP:False /INDICATEPROGRESS:False /INSTANCENAME:MSSQLSERVER /INSTANCEID:MSSQLSERVER /PBENGSVCSTARTUPTYPE:Manual /PBENGSVCACCOUNT:NT AUTHORITY\NETWORK SERVICE /PBDMSSVCACCOUNT:NT AUTHORITY\NETWORK SERVICE /PBDMSSVCSTARTUPTYPE:Manual /PBPORTRANGE:16450-16460 /SQLTELSVCACCT:NT Service\SQLTELEMETRY /SQLTELSVCSTARTUPTYPE:Manual /ASTELSVCSTARTUPTYPE:Manual /ASTELSVCACCT:NT Service\SSASTELEMETRY /ISTELSVCSTARTUPTYPE:Manual /ISTELSVCACCT:NT Service\SSISTELEMETRY160 /AGTSVCACCOUNT:NT Service\SQLSERVERAGENT /AGTSVCSTARTUPTYPE:Manual /ISSVCSTARTUPTYPE:Manual /ISSVCACCOUNT:NT Service\MsDtsServer160 /ASSVCACCOUNT:NT Service\MSSQLServerOLAPService /ASSVCSTARTUPTYPE:Manual /ASCOLLATION:Latin1_General_CI_AS /ASPROVIDERMSOLAP:1 /ASSYSADMINACCOUNTS:REDMOND\ersabine /ASSERVERMODE:TABULAR /SQLSVCSTARTUPTYPE:Manual /FILESTREAMLEVEL:0 /SQLMAXDOP:8 /ENABLERANU:False /SQLCOLLATION:SQL_Latin1_General_CP1_CI_AS /SQLSVCACCOUNT:NT Service\MSSQLSERVER /SQLSVCINSTANTFILEINIT:True /SQLTEMPDBFILECOUNT:8 /SQLTEMPDBFILESIZE:8 /SQLTEMPDBFILEGROWTH:64 /SQLTEMPDBLOGFILESIZE:8 /SQLTEMPDBLOGFILEGROWTH:64 /ADDCURRENTUSERASSQLADMIN:False /TCPENABLED:0 /NPENABLED:0 /BROWSERSVCSTARTUPTYPE:Disabled /FTSVCACCOUNT:NT Service\MSSQLFDLauncher /SQLMAXMEMORY:2147483647 /SQLMINMEMORY:0'"
# choco install sql-server-2022-cumulative-update -y


<#
choco install rsat --version 2.1809.0.20210815 -y
choco install powerbi --version 2.117.984.0 -y
choco install sql-server-management-studio --version 19.1.56 -y
choco install windirstat --version 1.1.2.20161210 -y
choco install paint.net --version 5.0.6 -y
choco install adobereader --version 2023.3.20201.1 -y
choco install github-desktop --version 3.2.3 -y
choco install insomnia-rest-api-client --version 2023.2.2 -y
choco install microsoftazurestorageexplorer --version 1.29.2 -y
choco install notepadplusplus --version 8.5.3 -y
choco install powershell-core --version 7.3.4 -y
choco install sqlnexus --version 6.0.0.8 -y
choco install sqldiagmanager --version 10.5.1.202 -y
choco install winmerge --version 2.16.30 -y



choco install powerbi
choco install sql-server-management-studio
#sqlsentryolanexplorer  need to update
rsat
windirstat
paint.net
map code folder
acrobatreader
# cpuz not avail
giphub desktop
# global protect not avail from chocolatey
# kusto explorer not avail from chocolatey
# msft expenses tool not avail from chocolatey
insomnia
azure storage explorer
notepadplusplus
powershell7
# visio not avail from chocolatey
# sqlquerystress not avail from chocolatey
sqlnexus
winmerge
windirstat



#>

# enable telnet
dism /online /Enable-Feature /FeatureName:TelnetClient

# create the "code" folder in onedrive if it doesn't exist
New-Item -ItemType Directory -Path $env:OneDrive -Name code -ErrorAction Ignore -Force 
$codeFolder = Get-Item -Path $env:OneDrive\code
# create a junction at "c:\code" to the OneDrive "code" folder
New-Item -ItemType Junction -Path c:\code -Value $codeFolder.FullName 

# add some additional code folders
md -force c:\code\posh
md -force c:\installs\done
md -force c:\temp



#finish up chocolatey
choco install -y 

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
