# echo "PATTERN GENERATION"
# python3 generate.py CTACCTGCACGAACAGCACTTTG > PATTERNS.txt

# echo "AGGREGATION"
# bash expression.bash ../../cutadapt/ PATTERNS.txt 64 exp

# echo "READS"
# bash reads.bash exp rds
# 
# echo "GROUP BY DESCRIPTION"
# for DSCR in description/*.tsv; do
#     NAME=${DSCR##*/}
#     NAME=${NAME%.tsv}
# 
#     python3 merge.py $DSCR exp/ expres/$NAME.tsv
#     python3 merge.py $DSCR rds/ rdsres/$NAME.tsv
# done
 
echo "DIFF EXPRESSION"
for DSCR in description/*.tsv; do
    NAME=${DSCR##*/}
    NAME=${NAME%.tsv}
    Rscript DESeq2.R expres/$NAME.tsv $DSCR overexp control expres $NAME
    Rscript DESeq2.R rdsres/$NAME.tsv $DSCR overexp control rdsres $NAME
done
