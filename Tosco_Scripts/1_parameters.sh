#!/bin/bash

# this script will show how many parameters are there;

# $# - total of parameters
# $0 - the command itself, in this case parameters.sh
# $1 - the first parameters, usually an option like ls <directory>

echo "You have typed $# parameters";
echo "The command name is: $0";
echo "The first parameter is: $1";
echo -e "All the parameters: $* ";
