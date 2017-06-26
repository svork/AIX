#!/bin/bash
#script para teste de quoting de comandos
#14/05/2015 

clear

declare a=$(ls)
declare b=$`ls`

echo "Usando o formato de quoting \$(), a variavel a tem o seguinte valor: $a"
echo "=========================="
echo "Usando o formato de quoting '$` `', a variavel b tem o seguinte valor: $b"
