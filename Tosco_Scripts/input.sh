#!/bin/bash

#05/05/2015
#Script manolao para test da zuera

clear;
date;
echo;
echo "Ae carai, olha so quem logou, eh o $USER leke , cacarai";
echo "Seja bem-vindo a Zuera";
echo;
#Now it comes the part when the ZUERO uses parameters, lemme show ya
echo "os tres primeiros valores $1 $2 $3";
echo "agora, tudo junto aee $*";
echo "vamos agora usar o valor separado $@";
echo "Embora fora exibidos 3 valores, vc digitou $# parameters";
#Agora vem a parte de ler as variaveis usando READ:>
#Variavel zika das caverna
echo -n "Digite o primeiro numero: ";
read NOTA1;
echo -n "Digite o segundo numero: ";
read NOTA2;
echo "O valor da media eh $NOTA1"; 
