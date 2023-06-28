#!/bin/bash

CERT_FOLDER=$HOME/certs/api.jarry.dk

if [ ! -f "$CERT_FOLDER/fullchain.pem" ]; then
    echo "$CERT_FOLDER/fullchain.pem is missing"
    return 0
fi

if [ ! -f "$CERT_FOLDER/privkey.pem" ]; then
    echo "$CERT_FOLDER/privkey.pem is missing"
    return 0
fi

echo "Create api.jarry.dk.pfx ..."
openssl pkcs12 \
	-export \
	-in $CERT_FOLDER/fullchain.pem \
	-inkey $CERT_FOLDER/privkey.pem \
	-name "api.jarry.dk" \
	-out $CERT_FOLDER/api.jarry.dk.pfx \
	-password pass:playground

echo
echo "Create api.jarry.dk.jks (JSK)..."
keytool \
	-importkeystore \
	-srckeystore $CERT_FOLDER/api.jarry.dk.pfx \
	-srcstoretype pkcs12 \
	-destkeystore $CERT_FOLDER/api.jarry.dk.jks \
	-deststoretype JKS \
	-storepass playground \
	-srcstorepass playground

echo
echo "Convert api.jarry.dk.jks (JKS) to  api.jarry.dk.jks (pkcs12) ..."
keytool \
	-importkeystore \
	-srckeystore $CERT_FOLDER/api.jarry.dk.jks \
	-destkeystore $CERT_FOLDER/api.jarry.dk.jks \
	-deststoretype pkcs12 \
	-storepass playground \
	-srcstorepass playground