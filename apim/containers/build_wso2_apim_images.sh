#!/bin/bash

source ./config.conf

CERT_FOLDER=$HOME/certs/api.jarry.dk

VERSION=4.2.0
FILENAME=wso2am-$VERSION
ARCHIVE_NAME=$FILENAME.zip
ARCHIVE_PATH=/home/micbn/git/wso2/product-apim/modules/distribution/product/target/$ARCHIVE_NAME

APIM_HOME=$FILENAME

#if [ -d "$APIM_HOME" ]; then
#    rm -rf $APIM_HOME
#fi

#if [  -f "$ARCHIVE_PATH" ]; then
#    echo "Do unzip of $FILENAME"
#    unzip $ARCHIVE_PATH -d $(pwd)
#else
#    echo "$ARCHIVE_PATH is missing !"
#    exit 0
#fi

echo "Add postgresql-42.6.0.jar to $APIM_HOME/repository/components/lib"
if [ ! -f "postgresql-42.6.0.jar" ]; then
    curl -o postgresql-42.6.0.jar https://jdbc.postgresql.org/download/postgresql-42.6.0.jar
fi
cp -v postgresql-42.6.0.jar $APIM_HOME/repository/components/lib/postgresql-42.6.0.jar

cp -vf  $CERT_FOLDER/api.jarry.dk.jks $APIM_HOME/repository/resources/security/api.jarry.dk.jks

#mv -v $APIM_HOME/repository/resources/security/wso2carbon.jks $APIM_HOME/repository/resources/security/wso2carbon.jks_org
#cp -v wso2carbon-jarry.jks $APIM_HOME/repository/resources/security/wso2carbon.jks

cp -v deployment_template.toml deployment.toml

sed -i 's/<apim_host>/'$POSTGRES_WSO2_APIM_HOST'/g' deployment.toml
sed -i 's/<apim_db>/'$POSTGRES_WSO2_APIM_DB'/g' deployment.toml
sed -i 's/<apim_username>/'$POSTGRES_WSO2_APIM_USER'/g' deployment.toml
sed -i 's/<apim_password>/'$POSTGRES_WSO2_APIM_PASSWORD'/g' deployment.toml

sed -i 's/<shared_host>/'$POSTGRES_WSO2_SHARED_HOST'/g' deployment.toml
sed -i 's/<shared_db>/'$POSTGRES_WSO2_SHARED_DB'/g' deployment.toml
sed -i 's/<shared_username>/'$POSTGRES_WSO2_SHARED_USER'/g' deployment.toml
sed -i 's/<shared_password>/'$POSTGRES_WSO2_SHARED_PASSWORD'/g' deployment.toml

sed -i 's/<keystore_tls_file_name>/api.jarry.dk.jks/g' deployment.toml
sed -i 's/<keystore_tls_password>/playground/g' deployment.toml
sed -i 's/<keystore_tls_alias>/api.jarry.dk/g' deployment.toml
sed -i 's/<keystore_key_password>/playground/g' deployment.toml

sed -i 's/<wso2_host_dns>/'$WSO2_APIM_HOST_DNS'/g' deployment.toml

cp -vf deployment.toml $APIM_HOME/repository/conf/deployment.toml

podman build -f Dockerfile -t jarry/wso2-apim:$VERSION .

# rm -v deployment.toml
rm -v $APIM_HOME/repository/resources/security/api.jarry.dk.jks
