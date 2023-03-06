#!/bin/dash

# testing tigger-commit

# testing ~file implementation

tigger-init 1>/dev/null
touch a b
tigger-add a b
tigger-commit -m 'new' 1>/dev/null

tigger-rm --force "a"

tigger-commit -m "second" 1>/dev/null

# checking if ~file is in index
if [ -e ".tigger/.index/~a" ]
then
    echo "failed implementation - ~file should be removed from index after commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

#checking if ~file is in the second commit folder
if [ -e ".tigger/.index/.commit.1/a" ]
then
    echo "failed implementation - ~file should NOT be in next commit folder after tigger-rm"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm -- a b 2>/dev/null

# now test for commit -a -m

tigger-init 1>/dev/null
touch a b
tigger-add a b
echo "h1" >a
echo "h2" >b
tigger-commit -a -m 'new' 1>/dev/null

tigger-rm --force "a"

tigger-commit -a -m "second" 1>/dev/null

# checking if ~file is in index
if [ -e ".tigger/.index/~a" ]
then
    echo "failed implementation - ~file should be removed from index after commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

#checking if ~file is in the second commit folder
if [ -e ".tigger/.index/.commit.1/a" ]
then
    echo "failed implementation - ~file should NOT be in next commit folder after tigger-rm"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm -- a b 2>/dev/null
echo "tests passed"