
% DC-RF-RUS-PF-PPI 0.1
% The code is an implementation of algorithms described in the paper:
% "Guang-Hui Liu, Hong-Bin Shen, and Dong-Jun Yu. Prediction of Protein-Protein Interaction Sites with Machine Learning based Data-Cleaning and Post-Filtering Procedures."
% The person who uses this code is expected to cite the paper.
% 
clc;
clear all;
close all;
tic
disp('start to prepare data...');
T_good = 0.497;% The last layer threshold fine-tuned by leave-one-out cross-validation on the training dataset.
system('python prepare_data.py');

flist = dir('../data/Output3/*.txt');
disp('start to predict...');
for CT = 1:length(flist)
    filename = flist(CT).name;
    disp(filename);
    fid = fopen(['../data/Output3/' filename],'r');
    tlin = fgetl(fid);
    ss = fscanf(fid,'%g',[2 1]);
    feature = fscanf(fid,'%g',[ss(1) ss(2)]);
    fclose(fid);
    disp('please waiting...');
    predict_output;
    pred_label(pred_label==2)=-1;
    fid = fopen(['../data/output/' filename], 'w');
    fprintf(fid,'%d\n',pred_label);
    fclose(fid);
end
system('python del.py');



