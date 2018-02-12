#!/bin/bash

cd "$(dirname "$0")"

if ! [[ -x "$(command -v create-dmg)" ]]
then
    echo "Please install create-dmg before packaging"
    echo "$ npm install --global create-dmg"
    exit 1;
fi

if [[ -d "dist" && -d "dist/Lock Screen.app" ]]
then
    pushd dist > /dev/null
    rm -rf "Lock-Screen-*.dmg"
    create-dmg "Lock Screen.app"
    popd > /dev/null
    exit 0;
else
    echo "Please execute build.command before packaging"
    exit 1;
fi
