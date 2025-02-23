Write-Host "🔍 Verificando se o Docker está instalado..."
$docker_installed = Get-Command docker -ErrorAction SilentlyContinue

if ($docker_installed) {
    Write-Host "✅ Docker já está instalado: " -NoNewline
    docker --version
} else {
    Write-Host "📌 Instalando Docker Desktop..."
    
    $dockerInstaller = "https://desktop.docker.com/win/main/amd64/Docker Desktop Installer.exe"
    $outputPath = "$env:TEMP\DockerInstaller.exe"

    Invoke-WebRequest -Uri $dockerInstaller -OutFile $outputPath
    Start-Process -FilePath $outputPath -ArgumentList "/quiet" -Wait
    Write-Host "✅ Docker instalado! Reinicie seu computador antes de usar."
}

Write-Host "🔍 Verificando se o Docker Compose está instalado..."
$docker_compose_installed = Get-Command docker-compose -ErrorAction SilentlyContinue

if ($docker_compose_installed) {
    Write-Host "✅ Docker Compose já está instalado: " -NoNewline
    docker-compose --version
} else {
    Write-Host "📌 Instalando Docker Compose..."
    
    $latestVersion = (Invoke-RestMethod -Uri "https://api.github.com/repos/docker/compose/releases/latest").tag_name
    $downloadUrl = "https://github.com/docker/compose/releases/download/$latestVersion/docker-compose-Windows-x86_64.exe"
    
    $outputPath = "$env:ProgramFiles\Docker\docker-compose.exe"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath

    Write-Host "✅ Docker Compose instalado com sucesso!"
}

Write-Host "🎉 Instalação finalizada! Verifique com 'docker --version' e 'docker-compose --version'."
