# DC-RF-RUS-PF 0.1
# The code is a modification of part of LORIS v1.0 by Dhole et al.
# The person who uses this code is expected to cite the following two papers:
# "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures." 
# "Dhole K, Singh G, Pai PP and Mondal S (2014) Sequence-based prediction of protein-protein interaction sites with L1-logreg classifier. Journal of theoretical biology 348: 47-54."
# =============================================== CODE BEGINS ==================================================
import os
import math
os.chdir('..')
n=os.getcwd()
os.chdir(n+"/data/Output1")
for files in os.listdir("."):
    infile=files
    x=infile.split('.')[0]
    path=n+'/data/input_prsa/'
    infile=x+'.txt'
    print infile
    with open(infile, 'r') as file:
        file_info=''
        fname=file.name
        l=[1.1]*186
        j=0
	for line in file:
                #print line
		j=0
                #print line[6]
                if line[6]==' ':
                #if line[6]<'0' or line[6]>'9':
                    for i in range(180):	
                            #print j
        	    	    l[i]=float(math.exp((-1)*float(line[j:j+3])))
        	    	    l[i]=round(1/(1+l[i]),2)
        	    	    j+=3
                else:
        	    for i in range(180):	
                            #print j
        	    	    l[i]=float(math.exp((-1)*float(line[j:j+4])))
        	    	    l[i]=round(1/(1+l[i]),2)
        	    	    j+=4
        	s=line.split(' ')
        	l[185]=float(s[-1])
        	l[184]=float(s[-2])
        	l[183]=float(s[-3])
        	l[182]=float(s[-4])
        	l[181]=float(s[-5])
        	l[180]=float(s[-6])
        	for k in range(186):
        	    file_info+=' '+ str(l[k])
        	file_info+='\n'
        f=n+'/data/Output2/'+ fname
        with open(f,"w") as ofile:
            ofile.write(file_info)
#
# ========================================== END OF CODE ==============================================
#