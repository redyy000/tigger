#!/bin/dash

#testing tigger-add

#if a non-existent file is added what happens

tigger-init 1>/dev/null
tigger-add a 2>/dev/null

if ! [ $? -eq 1 ]
then
    echo "Failed to catch add non-existent file error"
    exit 1
fi

touch a 
tigger-add a
tigger-commit -m '1' 1>/dev/null
tigger-rm "a"

# my implementation has failed, ~file does not exist after rm
if ! [ -e ".tigger/.index/~a" ]
then
    echo "Failed to add ~file after rm"
    rm -r -- ".tigger" 2>/dev/null
    rm -r -- "a" 2>/dev/null
    exit 1
fi

rm -r -- ".tigger" 2>/dev/null
rm -r -- "a" 2>/dev/null
echo "tests passed"

