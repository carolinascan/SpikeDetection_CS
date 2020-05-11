function [MAT,camp] = DELTA_TRAIN(X)
Tc=0.5;
massimo=max(max(X)); 
camp=[0:Tc:massimo]; 
M=zeros(1,length(camp));
[m,n]=size(X);
for i=1:m
    row=round(X(i,:),2);
    M=ismember(round(camp,2),row);
    MAT(i,:)=M;
end 
end 
