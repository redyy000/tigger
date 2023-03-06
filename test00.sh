#!/bin/dash

# testing that tigger-init was called before every other tigger program

touch a 

tigger-add a 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

tigger-commit -m "1" 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

tigger-log 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

tigger-rm a 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

tigger-show 0:a 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

tigger-status 2>/dev/null
if ! [ $? -eq 1 ]
    then echo "Failed to initialize empty tigger repository in .tigger"
    rm -- a
    exit 1
fi

rm -- a

echo "tests passed"