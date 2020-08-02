function  pos=RFpredict(model,threshold,data1,data2);
 votes=[];
T_sim=[];
order=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 test_number_store=data2;
 order=test_number_store{20};
 testDATA1=data1(order,:);
 test_number_pos=[];
 test_number_neg=[];
  testData1 = testDATA1;%testdata
 [T_sim,votes] = classRF_predict( testData1,model);
pred=votes';
votes1=votes;
PSEp2=[];
for t=1:size(testData1,1)
PSEp1= (double(votes1(t,1)))/(double(votes1(t,1)+votes1(t,2)));
PSEp2=[PSEp2;PSEp1];
end
M=PSEp2;
%  T_good=0.479;
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
    
  pos=test_number_pos;
  
end
