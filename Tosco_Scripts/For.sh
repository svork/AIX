#!/bin/bash
#vamos aprender a usar o FOR
#16/05/2015 

clear

declare valor

for valor in $(ls /)
do
	file $valor 2>a
	echo
done
