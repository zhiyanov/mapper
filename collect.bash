for IN_PATH in PC3_*; do
    for FILE in $IN_PATH/*; do
        PATTERN=${FILE##*/}
        PATTERN=${PATTERN%.txt}
        echo $PATTERN $(cat $FILE | wc -l) >> res/$IN_PATH.txt
    done
done
