#!/bin/bash

usage() {
  echo "Usage: $0 [OPTION...]" 1>&2
  echo "" 1>&2
  echo "Valid options:" 1>&2
  echo "  -h             Print this help." 1>&2
  echo "  -o ZIPFILE     Name of the flashable zip file. Default value is update.zip." 1>&2
  echo "  -d DIRECTORY   Directory to include in the zip file. Default value is zip." 1>&2
  echo "  -s             Sideload the flashable zip to the connected Android device." 1>&2
  exit 1
}

error() {
  echo "Error: $*" >>/dev/stderr
  exit 1
}

ZIPFILE="update.zip"
DIR="zip"
SIDELOAD=false

while getopts ":h:o:d:s" o; do
  case "${o}" in
    o) ZIPFILE=${OPTARG} ;;
    d) DIR=${OPTARG} ;;
    s) SIDELOAD=true ;;
    *) usage ;;
  esac
done

[ ! -d "$DIR" ] && error "$DIR directory does not exist."

echo "Building $ZIPFILE..."
current_dir=$(pwd)
cd "$DIR"

# Zip the contents of the folder
if [ "${ZIPFILE:0:1}" = "/" ]; then
  zip -r "$ZIPFILE" . 1>/dev/null 2>/dev/null
else
  zip -r "$current_dir/$ZIPFILE" . 1>/dev/null 2>/dev/null
fi

cd "$current_dir"

# Sideload if the flag is set
if [ "$SIDELOAD" = true ]; then
  echo "Sideloading $ZIPFILE..."
  adb sideload "$ZIPFILE"
fi

echo "Done."
