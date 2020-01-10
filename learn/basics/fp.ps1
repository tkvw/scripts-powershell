function Prompt($Message){
    return {
        param($Exec)
        
        $answer = Read-Host $Message;
        if($answer -eq 'y'){
            $Exec.Invoke();
        }
    }.GetNewClosure();
}