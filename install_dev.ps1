function NotInstalled($Cmd){
    -Not (Get-Command $Cmd -ErrorAction SilentlyContinue)
}
function NotScoopInstalled($App){
    $null -eq (scoop export | Where {$_.contains($App)})
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
    -Not $null -eq (scoop bucket list | Where-Object {$_ -eq $Bucket}) 
}
function AddBucket($Bucket){
    if(-Not $(HasBucket($Bucket))){
        if(Confirm("The $Bucket bucket is not installed, install?")){
            scoop bucket add $Bucket
        }
    }
}
function AddApp($App,$Description = $App, $Exec){
    if("" -eq $Description){
        $Description = $App
    }
    if(NotScoopInstalled($App)) {
        if(Confirm("$Description is missing, install?")){
            scoop install $App

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
    
} 
AddApp "pwsh" "PowerShell core"
AddApp "dotnet-sdk" "Dotnet SDK"

if(HasBucket("jetbrains")){
    AddApp "Rider"
}
if(HasBucket("extras")){
    AddApp "vscode" "Visual Studio Code"
}

if(('code --wait' -ne (git config --global --get core.editor)) -And (Confirm("Set vscode as default git editor?"))){
    git config --global core.editor "code --wait"
}
if ($null -eq (git config --global --get user.name)){
    $user = Read-Host "Please enter a git username"
    if($null -ne $user){
        git config --global user.name $user
    }
}
if ($null -eq (git config --global --get user.password)){
    $pwd = Read-Host -AsSecureString "Please enter a git password"
    if($null -ne $pwd){
        git config --global user.password $pwd
    }
}

