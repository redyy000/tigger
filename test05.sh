#!/bin/dash

# testing tigger-log + tigger-commit

tigger-init 1>/dev/null

touch a b c d

echo 'l1' >a
echo 'l2' >b
echo 'l3' >c

echo '1 gone' >d
echo '0 first_commit!!!' >>d

tigger-add a b c
tigger-commit -m 'first_commit!!!' 1>/dev/null
tigger-rm --force a b c
tigger-add a b c

tigger-commit -m "gone" 1>/dev/null

tigger-log >e

# test if output is correct
if [ "$(diff "d" "e")" ]
then
    echo "output produced by tigger-log is incorrect"
    rm -r -- .tigger 2>/dev/null
    rm -- a b c d e 2>/dev/null
    exit 1
fi

if [ -e ".tigger/.index/.commit.1/a" ] || [ -e ".tigger/.index/.commit.1/b" ] ||
[ -e ".tigger/.index/.commit.1/c" ] || [ -e ".tigger/.index/.commit.1/d" ] || [ -e ".tigger/.index/.commit.1/e" ]
then
    echo "tigger-commit behaves incorrectly after rm > commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b c d e 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm -- a b c d e 2>/dev/null

echo "tests passed"