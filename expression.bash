IN_PATH=$1
SEQ_PATH=$2
N_PROC=$3
OUT_PATH=$4

for FASTA_PATH in $IN_PATH/PC3_*.gz; do
    NAME=${FASTA_PATH##*/}
    NAME=${NAME%.fastq.gz}

    echo $NAME
    CORE=$(head -n 1 $SEQ_PATH)
    zcat $FASTA_PATH | grep $CORE > $OUT_PATH/TEMP$NAME.fasta
    touch $OUT_PATH/$NAME.txt

    tail -n +2 $SEQ_PATH | \
        parallel --jobs $N_PROC --group \
            "echo -n {} ' ' && \
             cat $OUT_PATH/TEMP$NAME.fasta | \
             grep {} | wc -l" > $OUT_PATH/$NAME.txt  
done
