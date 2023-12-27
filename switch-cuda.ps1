# https://github.com/wensheng/cuda-version-switcher
# Check if a version number is passed as an argument
if ($args.Length -eq 0) {
    Write-Error "No CUDA version supplied. Usage: .\script.ps1 [version]"
    exit
}
$cudaVersion = $args[0]

#check if CUDA_PATH_vVersion exists
$cudaVersion2 = "CUDA_PATH_V" + "$cudaVersion".replace('.','_')
if (Test-Path env:/$cudaVersion2) {
    Write-Host "$cudaVersion2 exists, switching to it..."
} else {
    Write-Host "CUDA version $cudaVersion2 is not installed, not switching."
    exit
}

# Read the PATH environment variable and split it into an array
$paths = $env:PATH.Split(';')

# Loop over each path and update CUDA version if present
for ($i = 0; $i -lt $paths.Length; $i++) {
    if ($paths[$i] -match "kit\\CUDA\\v(\d\d\.\d)") {
        $paths[$i] = $paths[$i] -replace "kit\\CUDA\\v\d\d\.\d", "kit\CUDA\v$cudaVersion"
    }
}

# Combine the updated paths
$newPath = $paths -join ';'

# Set the updated PATH environment variable
$env:PATH = $newPath

