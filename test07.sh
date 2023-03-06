#!/bin/dash

# testing tigger-rm

#check --cached removes from index

tigger-init 1>/dev/null

touch a b
tigger-add a b
tigger-commit -m "first" 1>/dev/null

echo "newline">a
echo "anotherline">b

tigger-add a b
tigger-rm --cached a

if [ -e ".tigger/.index/a" ]
then
    echo "tigger-rm --cached has not removed file from index"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

if ! [ -e ".tigger/.index/b" ]
then
    echo "tigger-rm --cached has removed file a file it was not supposed to"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

# checking if --cached removes from cd

if ! [ -e "a" ]
then
    echo "tigger-rm --cached has wrongly removed file from current directory"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm a b 2>/dev/null

# retry without --cached

tigger-init 1>/dev/null

touch a b
tigger-add a b
tigger-commit -m "first" 1>/dev/null

echo "newline">a
echo "anotherline">b

tigger-add a b
tigger-rm a 2>/dev/null

if [ "$?" -ne 1 ]
then
    echo "tigger-rm did not prevent user from losing work with exit status 1"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

tigger-rm --force a

if [ -e ".tigger/.index/a" ]
then
    echo "tigger-rm --force has not removed file from index"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

if ! [ -e ".tigger/.index/b" ]
then
    echo "tigger-rm has removed file a file it was not supposed to"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

# checking if removed from cd

if [ -e "a" ]
then
    echo "tigger-rm has not removed file from current directory"
    rm -r -- .tigger 2>/dev/null
    rm a b 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm a b 2>/dev/null
echo "tests passed"