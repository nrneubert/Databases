# Message for missing directory
CHECK_DIR_MSG = Directory does not exist

ifeq ($(OS),Windows_NT)
	# Use powershell as default shell
	SHELL := pwsh.exe
	# Execute commands as single-line script
	.SHELLFLAGS := -Command
	MOVE_CMD = Move-Item -Path *.png, *.jpg -Destination .\Images -Force
	CHECK_DIR = if(!(Test-Path .\Images)) { echo "$(CHECK_DIR_MSG)"; exit 1 }
else ifeq ($(shell uname -s),Linux)
	SHELL := /bin/bash
	.SHELLFLAGS := -c
	MOVE_CMD = mv *.png *.jpg Images/
	CHECK_DIR = if [ ! -d Images ]; then echo "$(CHECK_DIR_MSG)"; exit 1; fi
else 
	echo $(error Unrecognized OS)
endif

# @ suppresses outputs into the terminal!
.SILENT :
.PHONY : mv 
mv : 
	$(CHECK_DIR)
	$(MOVE_CMD)
