#!/bin/bash
set -e

EXPLANG=$1
shift
READER=$1
shift
HEADER=$1
shift

function printheader  {
    printf -- "%s\n" "$1"
    LEN="${#1}"
    printf -- "${2}%.0s" $(seq 1 $LEN)
    printf -- "\n\n"
}


printheader  "$HEADER" "="

for FILE in "$@"
do
    NAME=$(head --lines 1 "$FILE" | sed -e 's/^ *[#;]* *//g' )
    java -jar "$EXPLANG" -r "${READER}" "${FILE}" >"${FILE}.output"
    printheader "$NAME" -
    echo '```lisp'
    echo "--8<-- \"${FILE}\""
    echo '```'
    echo ""
    echo "Output:"
    echo '```'    
    echo "--8<-- \"${FILE}.output\""
    echo '```'    
    echo 
done
