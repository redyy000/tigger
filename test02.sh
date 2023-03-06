#!/bin/dash

#testing tigger-add

tigger-init 1>/dev/null
touch a 
tigger-add a
tigger-commit -m '1' 1>/dev/null
tigger-rm "a"
tigger-add "a"

# test whether the ~file is removed after re-adding a removed file
if [ -e ".tigger/.index/~a" ] && [ -e "a" ]
then
    echo "Failed to replace ~file in index after adding a tigger-rm'd  file"
    rm -r -- ".tigger" 2>/dev/null
    rm -r -- "a" 2>/dev/null
    exit 1
fi

rm -r -- ".tigger" 2>/dev/null
rm -r -- "a" 2>/dev/null
echo "tests passed"
