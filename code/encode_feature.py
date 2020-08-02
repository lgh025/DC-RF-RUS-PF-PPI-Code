# DC-RF-RUS-PF 0.1
# The code is a modification of part of LORIS v1.0 by Dhole et al.
# The person who uses this code is expected to cite the following two papers:
# "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures". 
# "Dhole K, Singh G, Pai PP and Mondal S (2014) Sequence-based prediction of protein-protein interaction sites with L1-logreg classifier. Journal of theoretical biology 348: 47-54."
# =============================================== CODE BEGINS ==================================================
import os
import time
import random
import datetime
import sys
import platform

syss = platform.system()
hydro=dict((('A',1.8),('L',3.8),('R',-4.5),('K',-3.9),('N',-3.5),('M',1.9),('D',-3.5),('F',2.8),('C',2.5),('P',-1.6),('Q',-3.5),('S',-0.8),('E',-3.5),('T',-0.7),('G',-0.4),('W',-0.9),('H',-3.2),('Y',-1.3),('I',4.5),('V',4.2)))
if syss == 'Windows':
        os.system('cls')
else:
        os.system('clear')
n=os.getcwd()
os.chdir('..')
m=os.getcwd()
print m
os.chdir(m+"/data/input_pssm")
a=[];icount=[];b=[];bflg=[];pcount=[];h=[];hy=[];fn=[];s=[];name=[]
#z=datetime.datetime.now().strftime("%a, %d-%b-%Y, %H:%M:%S")
# ==============================================================================================================
for i in range(2000):
	b.append('');
        bflg.append(0);
	name.append('');
	s.append('')
	h.append(0);
	icount.append(1);
	hy.append(0);

i=0;k=0;
for files in os.listdir("."):
	i+=1
os.chdir(m+"/data/input_prsa")
for files in os.listdir("."):
	k+=1
print k
if(i!=k):
	print("Error: Number of files not equal in both the folders!\nPlease ensure that the number of files in the folders input_prsa and input_pssm are equal.\n")
	sys.exit()

i=0;k=0;
os.chdir(n)
if syss != 'Windows':
        os.system('chmod 755 *')
os.system('python new.py')
os.chdir(m+"/data/input_prsa")
# ==============================================================================================================
for files in os.listdir("."):
	infile=files
	x=infile.split('.')[0]
	infile=x+'.prsa'
	name[k]=infile
	with open(infile, 'r') as file:
		for line in file:
			i+=1
			if i>=3:
				icount[k]+=1
	icount[k]-=1
	k+=1
	i=0
os.chdir(m+"/data/input_pssm")
k=0;i=0;
# ==============================================================================================================
for files in os.listdir("."):
	infile=name[k]
	x=infile.split('.')[0]
	infile=x+'.pssm'
	i=0
	with open(infile, 'r') as file:
		count=0
		for line in file:
			count+=1
                        if count==3:
                                if str(line[11])=='A':
                                        bflg[k]=3
                                else:
                                        bflg[k]=4
			if count>=4 and count<=(icount[k]+4):
				b[k]+=line
				i+=1
	k+=1;
i=0;l=0;k=0;v=' ';p=0;t=m;
# ==============================================================================================================
for files in os.listdir("."):
	infile=name[k]
	x=infile.split('.')[0]
	path=t+'/data/input_prsa/'
	infile=x+'.pssm'
	with open(infile, 'r') as psfile:
		count=0
                if bflg[i]==4:
		    for line in psfile:
                            #print line
			    count+=1
			    if (count>=8) and (count<=icount[k]-1):
				    m=count-4	
				    g=0
				    l=0
				    d=0
				    x=''
				    y=' '
				    for x in b[i].split('\n'):
					    if(x!=''):
						    l+=1;
						    if(l>=m-3) and (l<=m+5):
							    hy[d]=hydro[x[6]]
							    x=x[11:89] + '  '
							    y+=x
							    d+=1		
				    y+=str(hy[4]) + ' '
				    r=(hy[3]+hy[4]+hy[5])/3
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[2]+hy[3]+hy[4]+hy[5]+hy[6])/5
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[1]+hy[2]+hy[3]+hy[4]+hy[5]+hy[6]+hy[7])/7
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[0]+hy[1]+hy[2]+hy[3]+hy[4]+hy[5]+hy[6]+hy[7]+hy[8])/9
				    r=round(r,1)
				    y+=str(r) +' '
				    c=0
				    infile=infile.split('.')[0]+'.prsa'
				    with open(path+infile,'r') as prfile:
					    for line1 in prfile:
                                                    #print line1
						    c+=1
						    if(c==count-1):
							    y=y+line1[11:17]+'\n'
							    s[i]+=line1[5]+'       '+line1[7]+'\n'	
				    of=t+'/data/Output1/'
				    ofilename=(of + infile.split('.')[0] + '.txt')
				    with open(ofilename,"a+") as ofile:
					    ofile.write(y)
                elif bflg[i]==3:
                    for line in psfile:
                            #print line
			    count+=1
			    if (count>=8) and (count<=icount[k]-1):
				    m=count-4	
				    g=0
				    l=0
				    d=0
				    x=''
				    y=' '
				    for x in b[i].split('\n'):
					    if(x!=''):
						    l+=1;
						    if(l>=m-3) and (l<=m+5):
							    hy[d]=hydro[x[6]]
							    x=x[10:69] + ' '
							    y+=x
							    d+=1		
				    y+=str(hy[4]) + ' '
				    r=(hy[3]+hy[4]+hy[5])/3
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[2]+hy[3]+hy[4]+hy[5]+hy[6])/5
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[1]+hy[2]+hy[3]+hy[4]+hy[5]+hy[6]+hy[7])/7
				    r=round(r,1)
				    y+=str(r) +' '
				    r=(hy[0]+hy[1]+hy[2]+hy[3]+hy[4]+hy[5]+hy[6]+hy[7]+hy[8])/9
				    r=round(r,1)
				    y+=str(r) +' '
				    c=0
				    infile=infile.split('.')[0]+'.prsa'
				    with open(path+infile,'r') as prfile:

					    for line1 in prfile:
                                                    #print line1
						    c+=1
						    if(c==count-1):
							    y=y+line1[11:17]+'\n'
							    s[i]+=line1[5]+'       '+line1[7]+'\n'	
				    of=t+'/data/Output1/'
				    ofilename=(of + infile.split('.')[0] + '.txt')
				    with open(ofilename,"a+") as ofile:
					    ofile.write(y)
                else:
                    print 'error!'
		k+=1
		i+=1
k=0;m=t;
import os
os.chdir(n)
os.system('python expo.py')
# ==============================================================================================================
os.chdir(m+"/data/Output2")
for files in os.listdir("."):
    infile=name[k]
    x=infile.split('.')[0]
    infile=x+'.txt'
    k+=1
    prog_name=m+"/code/edit_format_x.py"

    os.system('python %s %s %s' % (prog_name, infile, m+"/data/Output3/"))
# ==============================================================================================================

# ==============================================================================================================
if syss == 'Windows':
        os.system('cls')
else:
        os.system('clear')
os.chdir(n)
#
# ============================================ END OF CODE =====================================================

