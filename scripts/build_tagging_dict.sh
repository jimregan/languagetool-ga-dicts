#!/bin/bash

echo "Create morfologik tagger dictionary, based on irishfst"
echo "This script assumes you have the full LanguageTool build environment"
echo "Please call this script from the LanguageTool top-level directory"
echo ""

LANG_CODE=ga
COUNTRY_CODE=IE
REPO=/home/jim/.m2/repository
LT_VERSION=4.3-SNAPSHOT
INPUT_ENCODING=utf8
OUTPUT_ENCODING=utf8
TEMP_FILE=/tmp/lt-tagger.dump
BASE=/home/jim/Playing

if [ ! -e pairs.tsv ]
then
	sh export-irishfst.sh
fi

LTTOOLPATH=$BASE/languagetool/languagetool-tools/target/languagetool-tools-$LT_VERSION-jar-with-dependencies.jar
CPATH=$REPO/com/carrotsearch/hppc/0.7.1/hppc-0.7.1.jar:$REPO/com/beust/jcommander/1.48/jcommander-1.48.jar:$REPO/org/carrot2/morfologik-fsa-builders/2.1.2/morfologik-fsa-builders-2.1.2.jar:$REPO/org/carrot2/morfologik-stemming/2.1.2/morfologik-stemming-2.1.2.jar:$REPO/org/carrot2/morfologik-fsa/2.1.2/morfologik-fsa-2.1.2.jar:$REPO/org/carrot2/morfologik-tools/2.1.2/morfologik-tools-2.1.2.jar:$REPO/commons-cli/commons-cli/1.2/commons-cli-1.2.jar:languagetool-tools/target/languagetool-tools-${LT_VERSION}.jar:${LTTOOLPATH}
PREFIX=irish
PREFIXSYN=irish_synth
TOKENIZER_LANG=${LANG_CODE}-${COUNTRY_CODE}
CONTENT_DIR=$BASE/languagetool-ga-dicts/src/main/resources/org/languagetool/resource/ga
INFO_FILE=${CONTENT_DIR}/${PREFIX}.info
INFOSYN_FILE=${CONTENT_DIR}/${PREFIXSYN}.info
DIC_NO_SUFFIX=$CONTENT_DIR/$PREFIX
DICFILE=${DIC_NO_SUFFIX}.dict
DICSYN_NO_SUFFIX=$CONTENT_DIR/$PREFIX
DICSYNFILE=${DICSYN_NO_SUFFIX}.dict

cat pairs.tsv | perl tsv2tsv.pl > $TEMP_FILE

java -cp $CPATH:languagetool-standalone/target/LanguageTool-*/LanguageTool-*/languagetool.jar \
  org.languagetool.tools.POSDictionaryBuilder -i $TEMP_FILE -info $INFO_FILE -o $DICFILE

java -Xmx4g -cp $CPATH:languagetool-standalone/target/LanguageTool-*/LanguageTool-*/languagetool.jar \
  org.languagetool.tools.SynthDictionaryBuilder -i $TEMP_FILE -info $INFOSYN_FILE -o $DICSYNFILE

rm $TEMP_FILE
