#!/bin/sh

# TODO: validate required inputs - KEYSTORE_PASSWORD
if [[ -z "${KEYSTORE_PASSWORD}" ]]
then
    echo "You need to set the KEYSTORE_PASSWORD environment variable... aborting!"
    exit 1
fi

# Create empty keystore if one wasn't passed
if [[ -f "./$KEYSTORE_NAME" ]]
then
  keytool -genkeypair -alias boguscert -storepass $KEYSTORE_PASSWORD -keypass secretPassword -keystore $KEYSTORE_NAME -dname "CN=Developer, OU=Department, O=Company, L=City, ST=State, C=CA"
  keytool -delete -alias boguscert -storepass $KEYSTORE_PASSWORD -keystore $KEYSTORE_NAME
fi

# Create combined Cert+Key from PEM files
cat $KEY_PATH $CRT_PATH > /tmp/cert.pem

# Create PKCS12 version of PEM input
openssl pkcs12 -export -out /tmp/cert.pkcs12 -in /tmp/cert.pem -passout pass:$KEYSTORE_PASSWORD

# Add PKCS12 version to the empty Java keystore
keytool -v -importkeystore -srckeystore /tmp/cert.pkcs12 -srcstoretype PKCS12 -destkeystore $KEYSTORE_NAME -deststoretype JKS -storepass $KEYSTORE_PASSWORD -srcstorepass $KEYSTORE_PASSWORD

# Change alias of keys
keytool -changealias -storepass $KEYSTORE_PASSWORD -keystore $KEYSTORE_NAME -alias 1 -destalias $KEYSTORE_ALIAS

# Move result to host mounted location
mv $KEYSTORE_NAME /out

# Cleanup
rm /tmp/cert.pem
rm /tmp/cert.pkcs12