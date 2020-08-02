load MCC2 MCC111
load  result2  result123

test1=result123{45};
test2=result123{46};
result=[test1;test2];
testlabels=result(:,1);
   pred=result(:,2);
acc2 = mean(result(:,1) == result(:,2))
fprintf('Accuracy: %0.3f%%\n', acc2 * 100);
acc_pos= mean( testlabels(find( testlabels ==1))== pred(find( testlabels==1)));
 fprintf('positive_Accuracy: %0.3f%%\n', acc_pos * 100);
acc_neg=mean( testlabels(find( testlabels ==2))== pred(find( testlabels==2)));
 fprintf('neg_Accuracy: %0.3f%%\n', acc_neg * 100);
 
 TP=sum(testlabels(find(testlabels==1))== pred(find(testlabels==1)));
  FP=sum(testlabels(find(testlabels==2))~= pred(find(testlabels==2)));
  TN=sum(testlabels(find(testlabels==2))== pred(find(testlabels==2)));
  FN=sum(testlabels(find(testlabels==1))~= pred(find(testlabels==1)));
  
  Precision=TP/(TP+FP)
  Recall=TP/(TP+FN)
  Specificity=TN/(TN+FP)
  Accuracy=(TP+TN)/(TP+FP+TN+FN)
  if Recall==0
      Recall=0.0001;
  end
   Fmeasure=2*(Precision* Recall)/(Precision+ Recall)
  ConfusionMatrix=[TP,FN;FP,TN]
  
  MCC4546=(TP*TN-FP*FN)/(sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))
mcc123=sum(MCC111(:,1:44))+sum(MCC111(:,47:end))+ MCC4546
mcc_72=mcc123/72
