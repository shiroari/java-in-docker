#!/bin/sh

set -e

PATH=$PATH:$JAVA_HOME/bin

echo "--------------------------"
echo "1. Compiling..."

rm -rf mods && mkdir -v mods

javac -d mods/api \
	$(find src/main/java/io/b3/api/ -name "*.java")

javac -d mods/provider \
	--module-path mods \
	$(find src/main/java/io/b3/provider/ -name "*.java")

javac -d mods/app \
	--module-path mods \
	$(find src/main/java/io/b3/app/ -name "*.java")

echo "--------------------------"
echo "2. Testing..."

java --module-path mods -m app/io.b3.app.Main

echo "--------------------------"
echo "3. Packaging..."

rm -rf dist && mkdir -v dist

jar --create --file=dist/api@1.0.jar --module-version=1.0 -C mods/api .
jar --create --file=dist/provider@1.0.jar --module-version=1.0 -C mods/provider .
jar --create --file=dist/app.jar --main-class=io.b3.app.Main -C mods/app .

echo "--------------------------"
echo "4. Testing..."

jar --describe-module --file=dist/api@1.0.jar
jar --describe-module --file=dist/provider@1.0.jar
java -p dist -m app

echo "--------------------------"
echo "5. Linking..."

rm -rf image
${JAVA_HOME}/bin/jlink --module-path ${JAVA_HOME}/jmods:mods \
	--add-modules app,api,provider \
	--output image \
	--compress=2

echo "--------------------------"
echo "6. Testing..."

image/bin/java -m app/io.b3.app.Main

echo "Done!"