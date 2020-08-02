# DC-RF-RUS-PF 0.1
# The code is a modification of part of LORIS v1.0 by Dhole et al.
# The person who uses this code is expected to cite the following two papers:
# "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures." 
# "Dhole K, Singh G, Pai PP and Mondal S (2014) Sequence-based prediction of protein-protein interaction sites with L1-logreg classifier. Journal of theoretical biology 348: 47-54."
# =============================================== CODE BEGINS ==================================================

import os, sys

inp=sys.argv[1]
outdir=sys.argv[2]

newF=open(outdir+inp, 'w')

allval=[]
f=open(inp, 'r')
for line in f:
    allval.append(line.rstrip().split())
f.close()

newF.write('%%MatrixMarket matrix array real general'+'\n')
newF.write(str(len(allval))+' '+str(len(allval[0]))+'\n')

c=0
while c < len(allval[0]):
    r=0
    while r < len(allval):
        newF.write(allval[r][c]+'\n')
        r=r+1
    c=c+1
newF.close()

# ============================= END OF CODE ==================================

# 
