# Basics

## Creating new objects 

Powershell can use the power of dotnet libraries to fullfill its tasks. 
See https://docs.microsoft.com/en-us/dotnet/api/system.net.cache.requestcachelevel?view=netcore-3.1 . 
See https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object?view=powershell-6

### New-Object 

```pwsh
New-Object <typename> 
```

### Properties

```pwsh
New-Object <typename> -Property @{Key=Value}
```

### Arguments

```pwsh
New-Object <typename> -ArgumentList (Value1,Value2)
```

### Nesting 

```pwsh
New-Object <typename> -Property @{Key=Value}
```

## Prompt 

