#!/usr/bin/bash

set -e

PDF_URL=${PDF_URL:="https://irn.justica.gov.pt/Portals/33/Regras%20Nome%20Proprio/Lista%20Nomes%20Pr%C3%B3prios.pdf"}

echo "Downloading pdf from $(echo "${PDF_URL}" | awk -F'/' '{print $3}')"
wget -qO nomes.pdf "${PDF_URL}"
pdftotext -layout nomes.pdf nomes.txt

grep "Femininos" nomes.txt | awk '{print $2}' | sort | uniq > femininos.txt
echo "Há $(wc -l femininos.txt) nomes femininos"

grep "Masculinos" nomes.txt | awk '{print $4}' | sort | uniq > masculinos.txt
echo "Há $(wc -l masculinos.txt) nomes masculinos"

rm nomes.txt

