
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
cleaned2;
toc;
 order=test_number_store1{20};
 testDATA1=data1(order,:);
 test_number_pos=[];
 test_number_neg=[];
 SAMPLE=[SAMPLE;testDATA1];
 testData1 = testDATA1;%testdata
 load('../data/model.mat', 'stackedTEST');
 stackedAEOptTheta=stackedTEST.stackedAEOptTheta;
inputSize=stackedTEST.inputSize;
hiddenSizeL2=stackedTEST.hiddenSizeL2;
numClasses=stackedTEST.numClasses;
netconfig=stackedTEST.netconfig;
[p,pred,activation2,activation3] = stackedAEPredict333(stackedAEOptTheta, inputSize, hiddenSizeL2, ...
                          numClasses, netconfig, testData1);

votes1=p';
% [T_sim,votes] = classRF_predict( testData1,model);
% M=votes(:,1)/100;
% pred=votes';
% votes1=votes;
PSEp2=[];
for t=1:size(testData1,1)
PSEp1= (double(votes1(t,1)))/(double(votes1(t,1)+votes1(t,2)));
PSEp2=[PSEp2;PSEp1];
end
M=PSEp2;
M(M >threshold)=1;
M(M <=threshold)=2;
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
