# Sample Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:5.0.400-windowsservercore-ltsc2019

# FROM mcr.microsoft.com/dotnet/sdk:5.0.400-nanoserver-20H2

# FROM mcr.microsoft.com/dotnet/sdk:6.0.100-preview.7-nanoserver-20H2

USER "NT Authority\System"

# docker run --user "NT Authority\System" -it mcr.microsoft.com/dotnet/sdk:5.0.400-nanoserver-20H2

RUN pwsh -command $ProgressPreference = 'SilentlyContinue'

RUN pwsh -command Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile dotnet-install.ps1 -Verbose

RUN pwsh -command .\dotnet-install.ps1 -Version 6.0.100-preview.7.21379.14 -InstallDir "$env:ProgramFiles\dotnet" -Verbose

# Install the maui workload
RUN dotnet workload install maui

# Install the maui-check utility
RUN dotnet tool install -g redth.net.maui.check

# Update .NET MAUI workload and check for missing updates
RUN dotnet tool update -g redth.net.maui.check

# Check your development environment
RUN maui-check --ci --non-interactive --fix --force-dotnet --skip androidemulator --skip xcode --skip vswin --skip vsmac --skip edgewebview2