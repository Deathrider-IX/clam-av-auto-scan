#!/bin/bash 

cat binary.txt

# COLORS #
RED="\e[31m"
GREEN="\e[32m"
BOLD="\e[1m"
RESET="\e[0m"
MAGENTA="\e[35m"

set -uo pipefail

# WORKDIR FOR CLAMAV LOGS 
#
#
WORKDIR="$HOME/clamav"
mkdir -p "$WORKDIR"
cd $HOME/clamav
cd $HOME/clamav || exit 1

sudo apt update -y 

# loop 
while true; do
	echo 
	read -rp  "${MAGENTA}${BOLD}Type 'scan' to run CLAM-AV, or 'q' to quit:${RESET}" command
	echo
	echo -e "${GREEN}CTRL+C to quit ${RESET}"
	
	if 

	[[ "$command" == "q" || "$command" == "quit" ]]; then
	break

	fi 


	if [[ -z "$command" ]]; then
		echo "try again.."
		continue
	fi

	#COMMANDS 
	 

	


	if command -v clamscan &> /dev/null; then

		echo -ne "${RED}${BOLD}RUNNING FRESHCLAM[/[][/]${RESET}"  
		
		sudo freshclam  #  >> Results_scan.txt 2>&1
		#grep -i "FOUND" Results_scan.txt 
		#grep -i "error\|denied" Results_scan.txt
		#echo -e "${RED} //CHECK >> Results_scan.txt// ${RESET}"

		echo -e "${GREEN}//scanning [DOWNLOADS] (auto-remove infected files)....${RESET}" 
		echo -e "${GREEN} // CHECK >> Downloads_Scan.txt // ${RESET}"
		#CHECKS FOR INFECTED FILES
		clamscan -i -r --remove "$HOME/Downloads" # >> Downloads_scan_results 2>&1

	       	# Warning automatic removal
		echo -e "${GREEN}//scanning [HOME] [TMP] ,[VAR][TMP]....${RESET}"  
		clamscan -r --exclude-dir="^/proc|^/sys|^/dev" "$HOME" /tmp /var/tmp # >> Home_results_txt 2>&1
		# echo -e "{$GREEN} // CHECK >> Home_results_txt // ${RESET}"
	       	# skip system directories

		echo "EXIT CODE: $?"
	else
		echo "clam-av NOT FOUND.. INSTALLING COMMAND."
		sudo apt update -y 
		sudo apt install -y --fix-missing clamav clamav-daemon
		sudo systemctl stop clamav-freshclam
		sudo freshclam

		cd $HOME/clamav || exit 1
		
	fi
done



	
