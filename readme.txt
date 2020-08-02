The source code is an implementation of our method described in the paper "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures". The person who uses this code is expected to cite the paper. 

--Dependence
Before running this code, you need install Matlab and python. In our experiment, Matlab R2013a and Python 2.7 are tested. This code is tested in Centos 5 and Windows 7. It should be able to run in other Linux or Windows systems.

--Input
The inputs are PSSM and PRSA of the query protein sequences. They must be placed in the folds /data/input_pssm and /data/input_prsa, respectively.In both folds, the same sequence are identified by the file name. PSSM can be calculated by ncbi-blast. The specific version Ncbi-blast-2.2.29+ is recommended since other may cause problems for differences in output format. PSSM is stored in textfiles with .pssm extension. PRSA is calculated by the SANN web server and is stored in textfiles with .prsa extension. Please refer to our paper to the details of calculation of PSSM and PRSA.
--How to run
In Matlab, run predict_PPI.m in fold DC-RF-RUS-PF-PPI-Code/code

--Output
if the code runs successfully, the prediction results will be placed in /data/output. For the specific feature representation in our method, the 8 residues placed in two sides of a sequence will not be predicted.

For your convenience, the independent validation dataset PSSM and PRSA used in our paper are located in fold /data.

Email:lgh025@163.com.
