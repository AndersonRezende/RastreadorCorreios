#!/bin/bash


if [ $# -eq 0 ]
  then
  	echo "Insira o código de rastreio:"
	read codigo
  else
  	codigo=$1
fi

echo "Rastreando "$codigo

response=$(curl -s -X GET -G 'https://rastreamento.correios.com.br/app/resultado.php' \
-d objeto=$codigo \
-d mqs=S)

descricao=$( jq -r '.eventos[0].descricao' <<< "${response}" )
origem=$( jq -r '.eventos[0].unidade.nome' <<< "${response}" )
destino=$( jq -r '.eventos[0].unidadeDestino.nome' <<< "${response}" )
data=$( jq -r '.eventos[0].dtHrCriado' <<< "${response}" )
echo ${descricao}
echo ${origem} " -> " ${destino}
echo $data