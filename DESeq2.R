library(DESeq2)

argv <- commandArgs(trailingOnly = TRUE)

counts <- read.table(argv[1], sep = "\t", header = TRUE, row.names = 1, check.names = FALSE)
groups <- read.table(argv[2], sep = "\t", header = TRUE)
expr_group <- argv[3]
ctrl_group <- argv[4]
output_path <- argv[5]
prefix <- argv[6]

groups <- groups[groups$Group %in% c(ctrl_group, expr_group),]
groups$Group <- relevel(factor(groups$Group), ref = ctrl_group)
rownames(groups) <- groups$Sample
groups$Sample <- NULL

index <- rownames(counts)
counts <- counts[, rownames(groups)]

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = groups,
                              design = ~ Group)

dds <- DESeq(dds)

res <- as.data.frame(results(dds))
res$index <- index

res <- res[order(res$padj),]
write.table(res, file = paste(output_path, "/", prefix, "_", expr_group, "_vs_", ctrl_group, "_all.tsv", sep=""), sep = "\t", quote = FALSE, row.names = FALSE)
