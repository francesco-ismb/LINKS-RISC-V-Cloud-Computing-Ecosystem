#! /bin/bash

# defining local variables (colors, etc.)
# colors:
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
# setting no color:
NC='\033[0m'


# running the script
STOP=0
VALID_ARGS=$(getopt -o s --long stop -- "$@")
eval set -- "$VALID_ARGS"
while [ : ]; do
	case "$1" in
		-a | --stop)
			STOP=1
			shift
			;;
	--) 
		shift; 
        	break 
        	;;
	esac
done
echo -e
echo -e "-------------------------------------------------"
echo -e "Network Bridge Configuration"
echo -e "-------------------------------------------------"
echo -e
# check if the user required to stop the network bridge
if [ $STOP -eq 1 ]; then
	echo -e "${GREEN}[exe]${NC} stopping the network bridge..."
	sudo virsh net-destroy qemu0 > /dev/null 2> /dev/null
	ERR=$?
	if [ $ERR -ne 0 ]; then
		echo -e "${YELLOW}[war]${NC} unable to stop qemu0 network"
	fi
	echo 
else
	echo -e "${GREEN}[exe]${NC} running bridged network..."
	sudo virsh net-define ../../net/qemu.xml > /dev/null  2> /dev/null
	ERR=$?
	if [ $ERR -ne 0 ]; then
		echo -e "${YELLOW}[war]${NC} the network bridge has been already defined"
	else
		echo -e "${GREEN}[exe]${NC} network bridge defined"
	fi
	sudo virsh net-start qemu0 > /dev/null 2> /dev/null
	ERR=$?
	if [ $ERR -ne 0 ]; then
		echo -e "${YELLOW}[war]${NC} the network bridge is already running"
	else
		echo -e "${GREEN}[exe]${NC} network bridge started"
	fi
	echo
fi

