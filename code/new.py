# DC-RF-RUS-PF 0.1
# The code is a modification of part of LORIS v1.0 by Dhole et al.
# The person who uses this code is expected to cite the following two papers:
# "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures." 
# "Dhole K, Singh G, Pai PP and Mondal S (2014) Sequence-based prediction of protein-protein interaction sites with L1-logreg classifier. Journal of theoretical biology 348: 47-54."
# =============================================== CODE BEGINS ==================================================
import shutil
import os
n=os.getcwd()
os.chdir(n)
os.chdir('..')
n=os.getcwd()
i=0;x=0;y=0;
newpath=n+'/data/'+'Output1'
if not os.path.exists(newpath):
	os.makedirs(newpath)
newpath=n+'/data/'+'Output2'
if not os.path.exists(newpath):
	os.makedirs(newpath)
newpath=n+'/data/'+'Output3'
if not os.path.exists(newpath):
	os.makedirs(newpath)
newpath=n+'/data/'+'Output'
if not os.path.exists(newpath):
	os.makedirs(newpath)
#
# ============================== END OF CODE ==============================
#