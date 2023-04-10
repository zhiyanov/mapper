FASTQ_PATH=$1
for IN_PATH in $FASTQ_PATH/*; do
    echo $IN_PATH $(zcat $FASTQ_PATH/$IN_PATH.fastq.gz | sed -n "n;p;n;n;" | wc -l)
done
