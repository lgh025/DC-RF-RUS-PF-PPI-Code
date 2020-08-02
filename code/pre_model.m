 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result1=[];
result2=[];
P11=[];
P22=[];
load(['../data/model.mat'], 'data_n','label_n','traindata_p','T_train_p' );
% load(['G:\DPparameter186\1AY7B_stackedTEST'], 'stackedTEST') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load(['G:\PPIpred186\','TGOOD111'], 'TGOOD')
% save (['F:\CRF-PPI-Code\DC-RF-RUS-PF-PPI-Code\data\model.mat'], 'model', 'data_n','label_n','traindata_p','T_train_p','stackedTEST');
   P_data=traindata_p;%train positive data
   P_label=T_train_p;%train positive labels
   N_data=data_n;%train negative data
   N_label=label_n ;%train negative labels
   label_p=P_label;
   label_n1= [N_label{1};N_label{2};N_label{3};N_label{4};N_label{5};N_label{6}];
   traindata_p1=P_data;
   traindata_n1=[N_data{1};N_data{2};N_data{3};N_data{4};N_data{5};N_data{6}];;
   [mtrain,ntrain]=size( traindata_p1);
   [m_major,n_major]=size( traindata_n1);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
   DC_model=cell(1,20);
data_n=cell(1,20);
label_n=cell(1,20);
dataN=cell(1,20);
labelN=cell(1,20);
numN=cell(1,20);%split 20
N1=cell(1,20);
testN=cell(1,20);
test_labelN=cell(1,20);
data_n_save=cell(1,20);
test_label_score1=cell(1,20);
test_data_score1=cell(1,20);
test_label_score2=cell(1,20);
test_data_score2=cell(1,20);
test_label_scoreP2=cell(1,20);
test_data_scoreP2=cell(1,20);
test_label_scoreN2=cell(1,20);
test_data_scoreN2=cell(1,20);
test_label_scoreP1=cell(1,20);
test_data_scoreP1=cell(1,20);
test_label_scoreN1=cell(1,20);
test_data_scoreN1=cell(1,20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for k=1:20
for i=1:802
  ii=20*(i-1)+k;
    data_n{k}(i,:)=traindata_n1(ii,:);
     label_n{k}(i,:)=label_n1(ii,:);
end
end
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 result5=[];
 votes5=[];
 data1=feature;
 SAMPLE=[SAMPLE;data1];
 testDATA1=data1;
 order=0;
     for j=1:size(data1,1)
          order(j)=j;
     
     end
      test_number_store1=cell(1,20);
      test_number_del2=cell(1,20);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5555
     for k=1:20
          test{k}=testDATA1;
      dataN{k}= data_n{k} ;
   labelN{k}=label_n{k};
    err1=1;
MAXacc=0;
mcc=0;
    T=0;     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_train1=[traindata_p1;dataN{k}];
T_train1=[  P_label;labelN{k}];
m=size(P_train1,1);

%% creat random forest
err1=1;
MAXacc=0;
mcc=0;
    T=0;
    for times=1:1
    for tt=50:50
  T1=tt/100; 
  T2=1-T1;
  extra_options.classwt = [1 1]; %for the [-1 +1] classses in twonorm
    
  extra_options.cutoff = [T1 T2]; %for the [-1 +1] classses in twonorm
    
   ntree=100;
    mtry=30;
   model = classRF_train(P_train1,T_train1,ntree, mtry,extra_options);
   DC_model{k}=model;
   save DC_model DC_model
    BER=sum(model.outcl~=T_train1)/m;

    if err1>BER
        err1=BER;
        
        T3=T1;
        model1=model;
    end
  tt;
  BER1(tt)=BER;
  end
%  toc;
 model=model1;
 bb_err=model.errtr(:,1);
 pred=model.outcl;
 P22=model.votes;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 PSEp2=[];
for t=1:m
PSEp1= (double(P22(t,1)))/(double(P22(t,1)+P22(t,2)));
PSEp2=[PSEp2;PSEp1];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rate=[];
sub=1;
for i=1:100
  T=i/100; 
  M=PSEp2;
M(M > T)=1;
M(M <= T)=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testlabels=T_train1;
testlabels (testlabels == 0) = 2; 
positivenumber=size(testlabels(find(testlabels==1)),2);
negativenumber=size(testlabels(find(testlabels==2)),2);
 % Confusion Matrix
  TP=sum(testlabels(find(testlabels==1))== M(find(testlabels==1)));
  FP=sum(testlabels(find(testlabels==2))~= M(find(testlabels==2)));
  TN=sum(testlabels(find(testlabels==2))== M(find(testlabels==2)));
  FN=sum(testlabels(find(testlabels==1))~= M(find(testlabels==1)));
  ConfusionMatrix=[TP,FP;FN,TN];
  tpr=TP/(TP+FN);
  fpr=FP/(FP+TN);
  rate1=[fpr,tpr];
  rate=[rate;rate1];
  MCC=(TP*TN-FP*FN)/(sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)));
  testlabels=T_train1;
testlabels (testlabels == 0) = 2;
acc_pos= mean(testlabels(find(testlabels==1))==M(find(testlabels==1)));
  acc_neg= mean(testlabels(find(testlabels==2))==M(find(testlabels==2)));
  acc2 = mean(testlabels(:) == M(:));
 SUB=abs(acc_pos-acc_neg);
 if MAXacc<acc2

  if (acc_pos>0.6)
     if (acc_neg>0.6)
         MAXacc=acc2;

   sub=SUB;
      mcc=MCC;
     T_good=T; 
     ConfusionMatrix1=ConfusionMatrix;
   ACC=acc2;
   acc_pos1=acc_pos;
   acc_neg1=acc_neg;
   vote=M;
   end
  end
 end
  T;
 end
end
%   T=T_good
  T=0.7;
 %% sim
[T_sim,votes] = classRF_predict(test{k},model);


M=votes(:,1)/100;
M(M > T)=1;
M(M <= T)=2;
 mm=size( test{k},1);
      for j=1:mm
          if ((M(j)==1))
     test_number_store1{k}=[test_number_store1{k} order(j)];
           end
         if ((M(j)==2))
     test_number_del2{k}=[test_number_del2{k} order(j)];
         end 
      end

      
  order=test_number_store1{k};
 %saved
 test_data_score1{k}=test{k}((M==1),:);
 %deleted
 test_data_score2{k}=test{k}((M==2),:);

testDATA1= data1(test_number_store1{k},:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
end
   



  