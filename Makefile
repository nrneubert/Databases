# Use powershell as default shell
SHELL := pwsh.exe
# Execute commands as single-line script
.SHELLFLAGS := -Command

# @ suppresses outputs into the terminal!
.SILENT :
.PHONY : mv 
mv : 
	if(!(Test-Path .\Images)) { echo "Directory does not exist"; exit 1 }
	Move-Item -Path *.png -Destination .\Images -Force
