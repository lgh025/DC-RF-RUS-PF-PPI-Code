
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
    disp('please waiting...');
    pred_label=[];
    cleaned_feature=Data_Cleaning(pre_cleaning,test_feature);    % data cleaning pre_progress
    pso=RFpredict(model,threshold,test_feature,cleaned_feature); % random forest classifier model predicting
    pred_label=Post_Filtering(test_feature,pso);                 % Post-Filtering Procedures
     
    
    wlength=length(filename);
     name1=strcat(filename(1:wlength-4)); 
    data= load(strcat('G:\xiaoweide\dataset_mat\dset164_mat\', name1));
              data1=data.feature;
                  label1=data.lb;
 %%%%%%%%%%   
  result2=[];
 label1(label1==-1)=2;
   result2 = [label1   pred_label];
   result123{CT}=result2;
   testlabels=label1;
   pred=pred_label;
acc2 = mean(result2(:,1) == result2(:,2))
fprintf('Accuracy: %0.3f%%\n', acc2 * 100);
acc_pos= mean( testlabels(find( testlabels ==1))== pred(find( testlabels==1)));
 fprintf('positive_Accuracy: %0.3f%%\n', acc_pos * 100);
acc_neg=mean( testlabels(find( testlabels ==2))== pred(find( testlabels==2)));
 fprintf('neg_Accuracy: %0.3f%%\n', acc_neg * 100);
 
 TP=sum(testlabels(find(testlabels==1))== pred(find(testlabels==1)));
  FP=sum(testlabels(find(testlabels==2))~= pred(find(testlabels==2)));
  TN=sum(testlabels(find(testlabels==2))== pred(find(testlabels==2)));
  FN=sum(testlabels(find(testlabels==1))~= pred(find(testlabels==1)));
  
  Precision(CT)=TP/(TP+FP)
  Recall(CT)=TP/(TP+FN)
  Specificity(CT)=TN/(TN+FP)
  Accuracy(CT)=(TP+TN)/(TP+FP+TN+FN)
  if Recall(CT)==0
      Recall(CT)=0.0001;
  end
   Fmeasure(CT)=2*(Precision(CT)* Recall(CT))/(Precision(CT)+ Recall(CT))
  ConfusionMatrix=[TP,FN;FP,TN]
  
  MCC111(CT)=(TP*TN-FP*FN)/(sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))
                  
                  
                  
                  
                  
                  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    pred_label(pred_label==2)=-1;
    fid = fopen(['../data/output/' filename], 'w');
    fprintf(fid,'%d\n',pred_label);
    fclose(fid);
    toc
end
%  save MCC2 MCC111
% save  result2 result123
MCC_average=(sum(MCC111))/ length(flist)
Precision_average=(sum(Precision))/ length(flist)

Recall_average=(sum(Recall))/ length(flist)
Specificity_average=(sum(Specificity))/length(flist)
Accuracy_average=(sum(Accuracy))/ length(flist)
Fmeasure_average=(sum(Fmeasure))/length(flist)
system('python del.py');



