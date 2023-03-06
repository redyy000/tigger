#!/bin/dash

# testing tigger-rm

tigger-init 1>/dev/null

touch a b
tigger-add a b
tigger-rm a 2>/dev/null
tigger-rm --cached a 2>/dev/null

if ! [ "$?" -ne 0 ]
then
    echo "tigger-rm --cached encountered an error where it should not have"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

if [ -e ".tigger/.index/a" ]
then
    echo "tigger-rm --cached after tigger-rm did not work"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

tigger-add a
tigger-commit -m '0' 1>/dev/null

#now check if rm removes from commit history

if ! [ -e ".tigger/.index/.commit.0/a" ]
then
    echo "tigger-rm deleted from commit history"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

tigger-rm --force a
tigger-commit -m "new" 1>/dev/null

if [ -e ".tigger/.index/.commit.1/a" ]
then
    echo "tigger-rm did not delete files properly"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

touch a
tigger-add "a"
tigger-commit -m "newest" 1>/dev/null

#check if file is still in newest commit folder

if ! [ -e ".tigger/.index/.commit.2/a" ]
then
    echo "tigger-commit did not add files to commit history properly"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

echo "tests passed"
rm -r -- .tigger 2>/dev/null
rm a b 2>/dev/null