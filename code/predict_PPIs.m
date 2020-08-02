function predict_PPIS
% DC-RF-RUS-PF 0.1
% The code is an implementation of algorithms described in the paper:
% "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures."
% The person who uses this code is expected to cite the paper.
% 
clc;
clear all;
close all;
tic
% addpath ('../src1/');
% path(path,'../src1/');

addpath(genpath(pwd));

disp('start to encode input_pssm and input_prsa into PPIs feature');
load('../data/PPImodel.mat','model','pre_cleaning','threshold');
system('python encode_feature.py');
flist = dir('../data/Output3/*.txt');
disp('start to predict...');
for CT = 1:length(flist)
    filename = flist(CT).name;
    disp(filename);
    fid = fopen(['../data/Output3/' filename],'r');
    tlin = fgetl(fid);
    ss = fscanf(fid,'%g',[2 1]);
    test_feature = fscanf(fid,'%g',[ss(1) ss(2)]);
    fclose(fid);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    disp('please waiting...');
    pred_label=[];
    cleaned_feature=Data_Cleaning(pre_cleaning,test_feature);    % data cleaning preprocessing
    pso=RFpredict(model,threshold,test_feature,cleaned_feature); % random forest classifier model predicting
    pred_label=Post_Filtering(test_feature,pso);                 % Post-Filtering Procedures
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    pred_label(pred_label==2)=-1;
    fid = fopen(['../data/output/' filename], 'w');
    fprintf(fid,'%d\n',pred_label);
    fclose(fid);
    toc
end
 system('python del.py');
end



