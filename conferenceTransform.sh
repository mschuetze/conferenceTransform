#!/bin/bash

if [ -z "$1" ]
  then
    echo "Bitte geben Sie das Eingabeverzeichnis als ersten Parameter an!"
    exit
fi

echo
echo Verarbeite: $1
echo Von Datum: $2
echo Bis Datum: $3

echo

SAXON_JAR=`pwd`/xslt/saxonb9-1-0-8j/saxon9.jar
XSLT_PATH=`pwd`/xslt/

INPATH=`pwd`/$1 
TEMP_FILE1=temp/merged.xml
TEMP_FILE2=temp/fixed.xml
OUT_DIR=indesign-out
OUTPATH=`pwd`/$OUT_DIR

echo
echo Merge ...
echo Suche nach Konferenz-XML-Dateien in $INPATH
java -jar "$SAXON_JAR" -o:"$TEMP_FILE1" -xsl:"${XSLT_PATH}merge.xslt" -it:"mergeStart" folder-in=$INPATH

echo
echo Fix HTML-Tags ...
java -jar "$SAXON_JAR" -o:"$TEMP_FILE2" -s:"$TEMP_FILE1" -xsl:"${XSLT_PATH}fix.xslt"  p-from-date=$2 p-to-date=$3

echo
echo InDesign Transform ...
echo Speichere Ergebnisse in $OUTPATH 
java -jar -Duser.language=en -Duser.region=US "$SAXON_JAR" -s:"$TEMP_FILE2" -xsl:"${XSLT_PATH}createInDesign_v0.4.1.xslt" p-folder-out=$OUTPATH

echo
echo Fertig 