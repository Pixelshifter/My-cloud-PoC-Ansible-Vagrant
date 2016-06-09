#!/bin/bash

# deploy function
function deploy() {

	echo ""
	echo "----------------------------------------------"
	echo "|                                            |"
	echo "| The $input environment is being put online |"
	echo "|                                            |"
	echo "----------------------------------------------"
	echo ""

	# change to env dir with Vagrantfile
	cd $HOME/Documents/Arsenaal/VM2/environments/$input

	# call up function in vagrant to deploy environment
	vagrant up

	# change to ansible base dir
	cd ../..

	echo ""
	echo "--------------------------------------------"
	echo "|                                          |"
	echo "| The $input environment is being deployed |"
	echo "|                                          |"
	echo "--------------------------------------------"
	echo ""

	# run configuration playbook
	ansible-playbook deploy_$input.yml

	exit 0

}

# rolling update function
function rolling_update() {

	echo ""
	echo "-------------------------------------------"
	echo "|                                         |"
	echo "| The $input environment is being updated |"
	echo "|                                         |"
	echo "-------------------------------------------"
	echo ""

	# change to vagrant dir
	cd $HOME/Documents/Arsenaal/VM2/environments/$input

	# execute vagrant box update
	vagrant box update

	# change to Ansible basedir
	cd ../..

	# run configuration playbook
	ansible-playbook update_$input.yml

	exit 0

}

# shutdown environment function
function shutdown_environment() {

	echo ""
	echo "---------------------------------------------"
	echo "|                                           |"
	echo "| The $input environment is being shut down |"
	echo "|                                           |"
	echo "---------------------------------------------"
	echo ""

	# change to env dir with Vagrantfile
	cd $HOME/Documents/Arsenaal/VM2/environments/$input

	#call suspend function in Vagrant to shutdown environment
	vagrant suspend
	
exit 0

}

# sanity checking
if [ "$#" -ne 2 ] ; then

	echo ""
	echo "No arguments supplied. I accept two arguments. Argument 1: 'bronze', 'silver' or 'gold'. Argument 2: 'deploy', 'update' or 'shutdown'"
	echo ""
	
	exit 1

fi

# sanity checking
if ([ "$1" = "bronze" ] || [ "$1" = "silver" ] || [ "$1" = "gold" ]) && ([ "$2" = "deploy" ] || [ "$2" = "update" ] || [ "$2" = "shutdown" ]) ; then

	# store input
	input=$1
	type=$2

	# call deploy function
	if [ "$type" = "deploy" ] ; then deploy

	# call rolling update function
	elif [ "$type" = "update" ] ; then rolling_update

	# else call shutdown function
	else shutdown_environment

	fi

else

	#no valid input
	echo ""
	echo "Incorrect arguments supplied. I accept two arguments. Argument 1: 'bronze', 'silver' or 'gold'. Argument 2: 'deploy', 'update' or 'shutdown'"
	echo ""

	exit 1

fi
