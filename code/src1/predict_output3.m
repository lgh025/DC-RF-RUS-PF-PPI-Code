
  MCC1=0;
  bestx=[];
 result=cell(1,length(flist));
 votes=cell(1,length(flist));
 modelGOOD=cell(1,length(flist));
 result5=[];
votes5=[];
SAMPLE=[];
LABEL=[];
T_sim2=[];
pos=cell(1,length(flist));
label22=[];
pred22=[];
MCC=0;
pos2=cell(1,length(flist));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('../data/model.mat', 'model');
threshold = 0.13;% The last layer threshold fine-tuned by leave-one-out cross-validation on the training dataset.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
order=0;
result5=[];
votes5=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data1=feature;
pre_test;%cleaned2;
toc;
 order=test_number_store1{20};
 testDATA1=data1(order,:);
 test_number_pos=[];
 test_number_neg=[];
 SAMPLE=[SAMPLE;testDATA1];
 testData1 = testDATA1;%testdata
 Files186 = dir(fullfile('G:\xiaoweide\dataset_mat\dset186_mat\','*.mat'));
%  labels = dir(fullfile('F:\魏志森的数据\dataset_mat\dset186_mat\\','*.label'));
  LengthFiles186 = length(Files186);
load(['f:\PPIpred186\','CT_good222'], 'CT_good')
 CT_good=174;%174,103,1,135
 wlength186=length(Files186(CT_good).name);
     name186=strcat(Files186(CT_good).name(1:wlength186-4));   
load(['f:\PPImodel186\',name186,'_model'], 'model') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%保存深度学习参数%%%%%%%%%%%%%%%%%%%%%%%%
load(['f:\PPIpred186\','TGOOD222'], 'TGOOD')
T_good=TGOOD(CT_good);
[T_sim,votes] = classRF_predict( testData1,model);
% M=votes(:,1)/100;
pred=votes';
votes1=votes;
PSEp2=[];
for t=1:size(testData1,1)
PSEp1= (double(votes1(t,1)))/(double(votes1(t,1)+votes1(t,2)));
PSEp2=[PSEp2;PSEp1];
end
M=PSEp2;
 T_good=0.479;
M(M >T_good)=1;
M(M <=T_good)=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 mm=size( testData1,1);
     for j=1:mm
          if ((M(j)==1))
     test_number_pos=[ test_number_pos order(j)];
          end
         if ((M(j)==2))
     test_number_neg=[test_number_neg order(j)];
         end 
      end
    
  pos{CT}=test_number_pos;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Post-Filtering Procedures
  pos2{CT}= pos{CT};
 pos1=[];
pn=size(pos{CT},2);
if size(pos{CT},2)>6
 for i=1:pn
     if i<=5
         if  (pos{CT}(i)+5<pos{CT}(i+2)) 
          pos1=[pos1;i];
          pos3=i;
         end
     end
     if (i>5 &&i<=pn-5)
         if  (pos{CT}(i)+5<pos{CT}(i+1))&&(pos{CT}(i)-5>pos{CT}(i-1))  
           pos1=[pos1;i];
            pos3=i;
         end
         if  (pos{CT}(i)+5<pos{CT}(i+2))&&(pos{CT}(i)-5>pos{CT}(i-1))  
            pos1=[pos1;i];
             pos3=i;
         end
         if  (pos{CT}(i)+5<pos{CT}(i+1))&&(pos{CT}(i)-5>pos{CT}(i-2))  
            pos1=[pos1;i];
             pos3=i;
         end
     end


 end
 if size(pos1,1)~=0
pos2{CT}(pos1(:,1))=[];
pos{CT}=pos2{CT};
 end
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pred2=2*ones(size(data1,1),1);
pred2(pos{CT},:)=1;
pred22=[pred22;pred2]; 
pred1=pred';
pred=pred2;
pred_label=pred; 
