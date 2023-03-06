#!/bin/dash

# testing tigger-show


tigger-init 1>/dev/null
touch a b
echo 'hi' >a
echo 'hello' >b
tigger-add a b
tigger-commit -m '1one' 1>/dev/null

tigger-rm --force "a"

tigger-commit -m "second" 1>/dev/null

tigger-show 0:a >testa
tigger-show 1:a 2>/dev/null

if ! [ "$?" = 1 ]
then
    echo "failed to detect error with tigger-show where there is no file in a commit"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    rm -- testa testb test1b expa expb 2>/dev/null
    exit 1
fi

echo 'hi' >expa
echo 'hello' >expb
tigger-show 0:b >testb
tigger-show 1:b >test1b

if [ "$(diff testa expa)" ]
then
    echo "output from tigger-show is wrong (0:a)"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    rm -- testa testb test1b expa expb 2>/dev/null
    exit 1
fi

if [ "$(diff testb expb)" ]
then
    echo "output from tigger-show is wrong (0:b)"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    rm -- testa testb test1b expa expb 2>/dev/null
    exit 1
fi

if [ "$(diff test1b expb)" ]
then
    echo "output from tigger-show is wrong (1:b)"
    rm -r -- .tigger 2>/dev/null
    rm -- a b 2>/dev/null
    rm -- testa testb test1b expa expb 2>/dev/null
    exit 1
fi

rm -r -- .tigger 2>/dev/null
rm -- a b 2>/dev/null
rm -- testa testb test1b expa expb 2>/dev/null
echo "tests passed"