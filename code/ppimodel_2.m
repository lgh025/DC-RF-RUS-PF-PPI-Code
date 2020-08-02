Files186 = dir(fullfile('G:\xiaoweide\dataset_mat\dset186_mat\','*.mat'));
%  labels = dir(fullfile('F:\魏志森的数据\dataset_mat\dset186_mat\\','*.label'));
  LengthFiles186 = length(Files186);
  load(['F:\aPPI重新做的model\刘光徽数据\PPIpred186_2\','CT_good222'], 'CT_good')
 CT_good=1;
 wlength186=length(Files186(CT_good).name);
     name186=strcat(Files186(CT_good).name(1:wlength186-4));   
load(['F:\aPPI重新做的model\刘光徽数据\PPImodel186_2\',name186,'_model'], 'model') 
% load  F:\aPPI重新做的model\刘光徽数据\PPImodel186_2\2C9XB_model  

load(['F:\aPPI重新做的model\刘光徽数据\PPIpred186_2\','TGOOD222'], 'TGOOD')
T_good=TGOOD(CT_good);
  
  
  
  
  
% load(['f:\PPIpred186\','CT_good222'], 'CT_good')
%  CT_good=174;%174,103,1,135
%  wlength186=length(Files186(CT_good).name);
%      name186=strcat(Files186(CT_good).name(1:wlength186-4));   
% load(['f:\PPImodel186\',name186,'_model'], 'model')


 load  DC_model1 DC_model
 threshold=T_good;
  threshold=0.5;
 pre_cleaning=DC_model;
 save PPImodel.mat model pre_cleaning threshold;
 toc