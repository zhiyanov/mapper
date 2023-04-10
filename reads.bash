IN_PATH=$1
OUT_PATH=$2

for FILE in $IN_PATH/*; do
    NAME=${FILE##*/}
    NAME=${NAME%.txt}
    echo $FILE
    cat $FILE | grep "\^" | grep "$ " | uniq -u | sort -n -r -k 2 > $OUT_PATH/$NAME.txt
done
