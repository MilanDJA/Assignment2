#!/bin/bash			
# This line specifies that the script should be run using the Bash shell.			
PACKAGES=("kakoune" "tmux")			
# The packages are in an array called PACHAGES	
		
# Loop through each package in the PACKAGES array.			
for pkg in "$PACKAGES	
			
for pkg in			
; do			
"# 11 ${PACHAGES[@]}"" expands to each element in the PACHAGES array."			
# Each element is assigned to the variable pkg one by one.			
if !pacman -Q ''$pkg '; then			
"# 'pa man -Q ' is for if the package isn't installed, it will return a non-zero status ."			
echo 'Installing $pkg ...'			
# Informs the user that the package installation is starting.			
pacman -S --noconfirm '$pkg '			
# Installs the package using pacman.			
# --noconfirm automatically answers yes to all prompts. else			
"echo ""$pkg is already installed."""			
"# If the package is found , says it's been installed already and has exit code 1."			
1			
		exit	
fi			