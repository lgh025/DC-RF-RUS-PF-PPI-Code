 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 function cleaned_data=Data_cleaning(DC_model,data);
 result1=[];
result2=[];
P11=[];
P22=[];
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

 result5=[];
votes5=[];
SAMPLE=[];
LABEL=[];
T_sim2=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
 result5=[];
 votes5=[];
 data1=data;
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
  T=0.70;
 [T_sim,votes] = classRF_predict(test{k},DC_model{k});
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
cleaned_data= test_number_store1;


 end
   



  