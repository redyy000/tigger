#!/bin/dash

# testing tigger-commit -m

#check if it detects empty index correctly

tigger-init 1>/dev/null
touch a b
tigger-commit -m "first" 1>/dev/null

if ! [ $? = 0 ]
then
    echo "tigger-commit did not exit with correct status (0) after finding nothing to commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

#check if it detects untouched files

echo "hello" >a
tigger-add a
tigger-commit -m "2" 1>/dev/null

tigger-add a
tigger-commit -m "last" 2>/dev/null 1>/dev/null

if ! [ $? = 0 ]
then
    echo "tigger-commit did not exit with correct status (0) after detecting unchanged file"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

# testing tigger-commit -a -m

#check if it detects empty index correctly

tigger-add b
tigger-commit -a -m "first" 2>/dev/null 1>/dev/null

if ! [ $? = 0 ]
then
    echo "tigger-commit did not exit with correct status (0) after finding nothing to commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

#check if it detects untouched files

echo "hello" >b
tigger-add b
tigger-commit -a -m "2" 1>/dev/null

tigger-add b
tigger-commit -a -m "last" 2>/dev/null 1>/dev/null

if ! [ $? = 0 ]
then
    echo "tigger-commit did not exit with correct status (0) after detecting unchanged file"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

echo "tests passed"
rm -r -- .tigger 2>/dev/null
rm -- a b 2>/dev/null