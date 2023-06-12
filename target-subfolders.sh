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

shopt -s globstar
ARG_MAX=$(getconf ARG_MAX)

if [ -d $ROOT/$TARGET/$l ]; then
  HASGO=$(ls $ROOT/$TARGET | grep ".go")
  # echo $HASGO
  if [ ! -z "$HASGO" ]; then
    echo "Now processing: $ROOT/$TARGET"
    go run github.com/nicolasdilley/gomela -am -result_folder "$RESULTS/$TARGET" model "$ROOT/$TARGET"
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
  go run github.com/nicolasdilley/gomela -result_folder "$RESULTS/$TARGET/$l" model "$ROOT/$TARGET/$l"
done