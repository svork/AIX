#!/bin/bash
#exercicio de notas dos alunos
#10/05/2015 

clear

declare -i NOTA=0

echo -n "Digite sua nota: "
read NOTA

if [ $NOTA -lt 6 ]
then
	clear
	echo "Voce foi REPROVADO, HAHAHA se fudeu"
#-a ( and ) eh o mesmo que usar o && (e) e -o significa || ( or ) 
elif [ $NOTA -ge 6 -a $NOTA -lt 9 ]
then
	clear
	echo "Voce foi APROVADO"
else
	clear
	echo "Voce tirou um MB seu viado :D"
fi
