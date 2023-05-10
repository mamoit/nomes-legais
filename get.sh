#!/usr/bin/env bash

set -e

PDF_URL=${PDF_URL:="https://irn.justica.gov.pt/Portals/33/Regras%20Nome%20Proprio/Lista%20Nomes%20Pr%C3%B3prios.pdf"}

if [ -f nomes.pdf ]; then
    echo "PDF already downloaded, skipping..."
else
    echo "Downloading pdf from $(echo "${PDF_URL}" | awk -F'/' '{print $3}')"
    wget -qO nomes.pdf "${PDF_URL}"
fi

pdftotext -layout nomes.pdf nomes.txt

grep "Femininos" nomes.txt | awk '{print $2}' | sort | uniq > femininos.txt
echo "Há $(wc -l femininos.txt | awk '{ print $1 }') nomes femininos"

grep "Masculinos" nomes.txt | awk '{print $4}' | sort | uniq > masculinos.txt
echo "Há $(wc -l masculinos.txt | awk '{ print $1 }') nomes masculinos"

cat femininos.txt masculinos.txt | sort | uniq -c | sort -n | grep -E "^\s+2" | awk '{ print $2 }' > neutros.txt
echo "Há $(wc -l neutros.txt | awk '{ print $1 }') nomes neutros"

rm nomes.txt
