#!/bin/bash
# uso do CASE
#16/05/2015 

clear

echo "Voce quer se fuder?"
read resp

case $resp in
	(y) echo "Voce se fudeu";;
	(n) echo "Voce nao se fudeu";;
	(*) echo "Falhei :(";;
esac

select p in xota pau viadao
do
	case $p in
		(xota) echo "vc gosta de xota \\'/";;
		(pau) echo "ela quer pau";;
		(*) echo "vc eh um viadao";break ;;
	esac
done
