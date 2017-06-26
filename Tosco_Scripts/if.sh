#!/bin/bash
#teste do comando IF
#10/05/2015 

clear

declare  A
#Variavel RC recebera o return code do comando ls, sempre um INTEGER
declare -i RC=0
#Variavel ERR recebe a mensagem de erro from STDERR
declare ERR

echo -n "Digite um nome de arquivo: "
read A

ls $A 2>err.out
RC=$?
ERR=`cat err.out`
rm err.out

if [ $RC -eq 0 ]
then
	echo "O comando ls retornou zero como return code"
else
	echo "O comando ls retornou um valor diferente de zero como return code"
	echo "A mensagem de erro foi: $ERR"
fi
echo
echo "O valor do return code foi: $RC"
