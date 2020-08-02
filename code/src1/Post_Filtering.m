function  pred_label=Post_Filtering(data,number_pos)   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Post-Filtering Procedures

label22=[];
pred22=[];

pos= number_pos;
pos2= number_pos;
pos1=[];
pn=size(pos,2);
if size(pos,2)>6
 for i=1:pn
     if i<=5
         if  (pos+5<pos(i+2)) 
          pos1=[pos1;i];
          pos3=i;
         end
     end
     if (i>5 &&i<=pn-5)
         if  (pos(i)+5<pos(i+1))&&(pos(i)-5>pos(i-1))  
           pos1=[pos1;i];
            pos3=i;
         end
         if  (pos(i)+5<pos(i+2))&&(pos(i)-5>pos(i-1))  
            pos1=[pos1;i];
             pos3=i;
         end
         if  (pos(i)+5<pos(i+1))&&(pos(i)-5>pos(i-2))  
            pos1=[pos1;i];
             pos3=i;
         end
     end


 end
 if size(pos1,1)~=0
pos2(pos1(:,1))=[];
pos=pos2;
 end
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pred2=2*ones(size(data,1),1);
pred2(pos,:)=1;
pred22=[pred22;pred2]; 

pred=pred2;
pred_label=pred; 
end
