#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com
set -e
set -u
set -o pipefail

export JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-x64
export PATH=$JAVA_HOME/bin:$PATH

javac UsingSystemOut.java &&
java -Dfile.encoding=UTF-12 UsingSystemOut
java -Dfile.encoding=UTF-16 UsingSystemOut
java -Dfile.encoding=UTF-8 UsingSystemOut

echo "----"

javac FindCharacterPoint.java &&
java FindCharacterPoint '~'
java FindCharacterPoint '👻'
