# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-6

function NotInstalled($Cmd){
    -Not (Get-Command $Cmd -ErrorAction SilentlyContinue)
}
function NotScoopInstalled($App){
    $null -eq (Invoke-Expression "scoop export" | Where {$_.contains($App)})
}
function ExecUrl($Url){
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString($Url);
}
function Confirm($Message){
    $answer = Read-Host $Message
    while("y","n","yes","no" -notcontains $answer){	$answer = Read-Host 'Please confirm with "y(es)" or "n(o)"' }
    $answer -eq "y" -Or $answer -eq "yes"
}
function HasBucket($Bucket){
    -Not $null -eq (Invoke-Expression "scoop bucket list" | Where-Object {$_.contains($Bucket)}) 
}
function AddBucket($Bucket){
    if(-Not $(HasBucket($Bucket))){
        if(Confirm("The $Bucket bucket is not installed, install?")){
            Invoke-Expression "scoop bucket add $Bucket"
        }
    }
}
function AddApp($App,$Description = $App, $Exec){
    if("" -eq $Description){
        $Description = $App
    }
    if(NotScoopInstalled($App)) {
        if(Confirm("$Description is missing, install?")){
            Invoke-Expression "scoop install $App"

            if( $null -ne $Exec ){
                $Exec.Invoke();
            }
        }
    }
}

if(NotInstalled("scoop")) {
    ExecUrl("https://get.scoop.sh")
}

AddBucket("jetbrains");
AddBucket("extras");

AddApp "git" "" {
    Write-Output "Installed git"
} 
AddApp "pwsh" "PowerShell core"
AddApp "dotnet-sdk" "Dotnet SDK"

if(HasBucket("jetbrains")){
    AddApp "Rider"
}
if(HasBucket("extras")){
    AddApp "vscode" "Visual Studio Code"
}



