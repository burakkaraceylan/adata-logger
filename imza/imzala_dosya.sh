#!/bin/sh

dosya_yolu=$1
dosya_adi=`basename $dosya_yolu`
extension="${dosya_adi##*.}"
yalin_ad="${dosya_adi%.*}"

calisma_dizini=/imza/imza_isleri
saklama_dizini=/imza/imzali
hata_dizini=/imza/hatali
TSRootCert=/CA/tsroot.crt
openssl_conf=/etc/ssl/openssl.cnf

mv $dosya_yolu $calisma_dizini/
yeni_yol="$calisma_dizini/$dosya_adi"

openssl ts -query -data $yeni_yol -cert -sha256 -no_nonce -out $yeni_yol.tsq
cat $yeni_yol.tsq | curl -s -S -H 'Content-Type: application/timestamp-query' --data-binary @- http://${TS_USER}:${TS_PASS}@${TS_SERVER} -o $yeni_yol.tsr

VERIFY=`openssl ts -verify -in $yeni_yol.tsr -data $yeni_yol -CAfile $TSRootCert`

if [ "$VERIFY" == "Verification: OK" ]

        then

                echo "Dogrulama tamam."
		tar cvfz $saklama_dizini/$dosya_adi-imzali.tar.gz $yeni_yol*

        else

                echo "Dogrulama Saglanamadi."
		tar cvfz $hata_dizini/$dosya_adi-imzahatasi.tar.gz $yeni_yol*
fi


rm $calisma_dizini/$dosya_adi*
