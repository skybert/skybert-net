#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

export JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-x64
export PATH=$JAVA_HOME/bin:$PATH

mvn -q clean package -DskipTests
java -cp target/classes -Dfile.encoding=UTF-12 net.skybert.talk.UsingSystemOut
echo ""
java -cp target/classes -Dfile.encoding=UTF-8 net.skybert.talk.UsingSystemOut
echo ""

java -cp target/classes net.skybert.talk.FindCodePoint '~'
java -cp target/classes net.skybert.talk.FindCodePoint '👻'
