#!/bin/bash

cd steamclient
rm -rf ../generated
mkdir ../generated
PROTOFILES=( "content_manifest" "encrypted_app_ticket" "iclient_objects" "steammessages_base" "steammessages_clientserver" )
for protofile in "${PROTOFILES[@]}"
do
    echo "Compiling ${protofile}.proto..."
    protoc --java_out=../generated ${protofile}.proto
done
cd ..
cd generated
JAVAFILES=( "ContentManifest" "EncryptedAppticket" "IclientObjects" "SteammessagesBase" "SteammessagesClientserver" )
for javafile in "${JAVAFILES[@]}"
do
    echo "Setting package info for ${javafile}"
    awk 'NR==3{$0="\npackage uk.co.thomasc.steamkit.base.generated;\n"$0}1' ${javafile}.java > ${javafile}.new
    mv ${javafile}.new ${javafile}.java
done
echo "Moving into place..."
cp *.java ../../java/uk/co/thomasc/steamkit/base/generated/
cd ..
