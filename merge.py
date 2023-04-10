import pandas as pd
import sys

DESCRIPTION_PATH = sys.argv[1]
EXPRESSION_PATH = sys.argv[2]
OUT_PATH = sys.argv[3]

description = pd.read_csv(
    DESCRIPTION_PATH, sep="\t"
)

description["Sample"] = description["Sample"].str.rstrip(".fastq")
result = None

for i, row in description.iterrows():
    print(row["Sample"] + ".fastq")
    df = pd.read_csv(
        EXPRESSION_PATH + "/" + row["Sample"] + ".txt",
        sep="  ",
        header=None,
        index_col=0,
        names=[row["Sample"] + ".fastq"]
    )

    if result is None:
        result = df
    else:
        result = result.join(df, how="inner")

result.to_csv(OUT_PATH, sep="\t")
