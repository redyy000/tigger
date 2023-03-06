#!/bin/dash

# testing tigger-status for the parts of my implementation that work
# (when all files are in cd)


# get my implementation output

mkdir testfolder
cd testfolder

../tigger-init 1>/dev/null
touch a b c f g h
../tigger-add a b c f
../tigger-commit -m "first commit" 1>/dev/null
echo hello >a
echo hello >b
echo hello >c
../tigger-add a b
echo world >a
../tigger-add g
../tigger-status >"myoutput.txt"

cd ..
mv "testfolder/myoutput.txt" .
rm -r -- testfolder

# now get reference implementation output
mkdir testfolder2
cd testfolder2

2041 tigger-init 1>/dev/null
touch a b c f g h
2041 tigger-add a b c f
2041 tigger-commit -m "first commit" 1>/dev/null
echo hello >a
echo hello >b
echo hello >c
2041 tigger-add a b
echo world >a
2041 tigger-add g
2041 tigger-status >"refoutput.txt"

cd ..
mv "testfolder2/refoutput.txt" .
rm -rf -- testfolder2

# when status is run for both, status is run on the txt file as well as CD beacuse of ">" which creates the txt file instantly
# remove last line of each with sed
sed '$d' "myoutput.txt">"myoutput.txt" 1>/dev/null
sed '$d' "refoutput.txt">"refoutput.txt" 1>/dev/null

if [ "$(diff "myoutput.txt" "refoutput.txt")" ]
then
    echo "There is a difference between reference output and your output"
    rm myoutput.txt refoutput.txt 2>/dev/null
    rm -rf testfolder testfolder2 2>/dev/null
    exit 1
fi

echo "tests passed"
rm myoutput.txt refoutput.txt 2>/dev/null
rm -rf testfolder testfolder2 2>/dev/null