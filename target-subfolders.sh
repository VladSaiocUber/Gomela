#!/bin/bash

TARGET=$1
ROOT=$2
RESULTS=$3

if [ -z $1 ]; then
  echo "Give me a target."
  exit 1
fi

if [ -z $2 ]; then
  ROOT="../benchmarks"
fi

if [ -z $3 ]; then
  RESULTS="$ROOT/results"
fi

ROOTREGEXP=$(echo "$ROOT" | sed "s+\.+\\\.+g")

rm -rf "$RESULTS/$TARGET"

go build github.com/nicolasdilley/gomela

shopt -s globstar
if [ -d $ROOT/$TARGET ]; then
  HASGO=$(ls $ROOT/$TARGET | grep ".go")
  # echo $HASGO
  if [ ! -z "$HASGO" ]; then
    echo "Now processing: $ROOT/$TARGET"
    ./gomela -am -result_folder "$RESULTS/$TARGET" fs "$ROOT/$TARGET"
  fi
fi


for l in $(ls $ROOT/$TARGET/** \
  | grep "$ROOTREGEXP" \
  | sed "s+$ROOTREGEXP/$TARGET/++g" \
  | sed "s+:++g" \
  | grep -vP "(\.|vendor|benchmarks|examples|testdata|/test/)");
do
  if [ ! -d $ROOT/$TARGET/$l ]; then
    continue
  fi
  HASGO=$(ls $ROOT/$TARGET/$l | grep ".go")
  # echo $HASGO
  if [ -z "$HASGO" ]; then
    continue
  fi
  echo "Now processing: $ROOT/$TARGET/$l"
  ./gomela -am -result_folder "$RESULTS/$TARGET/$l" fs "$ROOT/$TARGET/$l"
done