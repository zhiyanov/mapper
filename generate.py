import sys
from itertools import product

FPR = 4 
FPL = 4 
TPL = 4 
TPR = 4 
NTS = ["A", "T", "G", "C"]

SEQ = sys.argv[1]
if TPL == 0:
    CORE = SEQ[FPR:]
else:
    CORE = SEQ[FPR:-TPL]

def variants(seq):
    yield "^" + seq + "$"
    yield "^" + seq
    yield seq + "$"
    yield seq


print(CORE)
print("^" + SEQ + "$")
for i in range(0, FPR + 1):
    seq = SEQ[i:]
    if i > 0:
        print(*list(variants(seq)), sep="\n")
    for j in range(1, TPR + 1):
        for add in product(NTS, repeat=j):
            res = seq + "".join(add)
            print(*list(variants(res)), sep="\n")
            

SEQ = SEQ[::-1]
for i in range(0, TPL + 1):
    seq = SEQ[i:]
    if i > 0:
        print(*list(variants(seq[::-1])), sep="\n")
    for j in range(1, FPL + 1):
        for add in product(NTS, repeat=j):
            res = seq + "".join(add)
            print(*list(variants(res[::-1])), sep="\n")
