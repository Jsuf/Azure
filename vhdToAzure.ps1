#Agefir el compte amb el que accedirem a la subscripció d'azure
Add-AzureAccount 

#Seleccionem la subscripció de DEV
Select-AzureSubscription -SubscriptionId "ffb4a8f8-1bf6-4272-bd08-85d1bc7993dd"


write-host "**************************************"
write-host "****Emplena el camps corresponents****"
write-host "**************************************"

#VARIABLES
$LocalVHD = Read-Host 'Introdueix el path del VHD On-Premise (acabat amb la extensió del fitxer .VHD)'
$AzureVHDname = Read-Host 'Introdueix el nom que tindrà el VHD a Azure (sense extensió)'
$AzureVHD = "https://storage4cdev.blob.core.windows.net/vhds/"+$azurevhdname+".vhd"

#$LocalVHD = "D:\w2012r2-custom2.vhd"

#Confirmació
write-host ""
write-host "********************************"
write-host "****Són correctes les dades?****"
write-host "********************************"
write-host ""
write-host "VHD local:"$LocalVHD
write-host "VHD Cloud:"$AzureVHDname
write-host ""
Write-host "Si estàs segur apreta enter, en cas contrari Ctrl+C"
write-host ""
pause

#Iniciem la migració cap al cloud
Add-AzureVhd -LocalFilePath $LocalVHD -Destination $AzureVHD

pause
Write-host "Si estàs segur apreta enter, en cas contrari Ctrl+C"


# Registrar el disc com a OS disk en cas de ser necessari

write-host ""
write-host "****************************************"
$OSVHD =    Read-Host '====> El disc conté un Sistema Operatiu? (S/N)'


if ($OSVHD -eq "S"){
    Add-AzureDisk -DiskName $AzureVHDname -MediaLocation $AzureVHD -Label $AzureVHDname -OS Windows
    write-host "S'ha pujat correctament el OS DISK, ja pots procedir crear una nova VM des de https://portal.azure.com"
}else{
    write-host "S'ha pujat correctament el DATA DISK, ja pots procedir a adjuntar-lo a alguna VM"
}
