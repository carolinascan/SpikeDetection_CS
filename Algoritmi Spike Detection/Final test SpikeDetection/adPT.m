function [reference_train]= adPT(data_in,mPW,T,fs)

% When call
% mPW=0.24*1e-3;
% th_value=DMth_cte*median(abs(data_in))/0.6745;
% [peak_train]= kelly_v5(data_in,mPW,th_value,fs);
%
mPW = floor(mPW*fs);
RP    = mPW*5;

SpikesIndices = zeros(length(data_in),1);
index_spk=1;
newIndex=1;

for index=2:length(data_in)-1
% Jumpt to next position
    if (index<newIndex)
        continue; 
    end 
    if index_spk>1
        if index-SpikesIndices(index_spk-1)<=RP
            newIndex=SpikesIndices(index_spk-1)+RP;
            continue;
        end
    end
% Local voltage greater or equal than threshold
% TO RUN faster
    if abs(data_in(index))<T/3
        continue;
    end
% Local maximum or minimum   
    if abs(data_in(index))>abs(data_in(index-1)) ...
            && abs(data_in(index))>= abs(data_in(index+1))
% Evaluate for local minimum within 2d window (1d before and 1d after
%    CWin1=max(index-delta,1);
    CWin2=min(index+mPW, length(data_in)-1);
% Voltage varies >= 2T within +-d ms of initial detection time
%    currW=CWin1:CWin2;
    currW=index:CWin2;
     if ~(any(abs(data_in(index)-data_in(currW))>=2*T))
     %   newIndex=index+delta;
         continue;
     end
     if data_in(index)>0
        pol=1;
     else
         pol=0;
     end
    
   % flag=0;
    nidx=index;
    counter = 0;
     while nidx<= index+mPW*3
        if pol==1    
            [~,n2d]=min(data_in(currW));
        else
            [~,n2d]=max(data_in(currW));
        end
     nidx = nidx+n2d-1;  
         if abs(data_in(nidx))>abs(data_in(nidx-1)) && abs(data_in(nidx))>= abs(data_in(nidx+1))
            SpikesIndices(index_spk)=index; %nidx
            %index_spk=index_spk+1;
            newIndex=min(nidx+nidx-index,length(data_in));
            %flag=1;
            break;
         else
            if counter <=2
                currW = [nidx+mPW:min(nidx+mPW*2, length(data_in)-1)];
                counter = counter+1;
            else 
                break
            end
         end 
     end
     
     if index_spk>1 && SpikesIndices(index_spk)==nidx%SpikesIndices(index_spk-1)==nidx
         %
         index_spk=index_spk+1;
         %
         continue;
     end
     W3=[max(1,nidx-mPW):min(nidx+mPW,length(data_in)-1)];
     if  pol==1  
         if any(data_in(W3)>data_in(index))
            newIndex=min(index+mPW,length(data_in));
            continue;
         else
            % if flag==1
             %    SpikesIndices(index_spk-1)=nidx;
             %else
                 SpikesIndices(index_spk)=nidx;
             %    index_spk = index_spk+1;
           %  end
            index_spk=index_spk+1;
            newIndex=min(nidx+nidx-index,length(data_in));

         end
     else 
         if any(data_in(W3)<data_in(index))
            newIndex=min(index+mPW,length(data_in));
            continue;
         else 
         %    if flag==1
         %        SpikesIndices(index_spk-1)=nidx;
         %    else
                 SpikesIndices(index_spk)=nidx;
                index_spk = index_spk+1;
         %    end
            newIndex=min(nidx+nidx-index,length(data_in));

         end 
         
     end
    end
end
reference_train=SpikesIndices(SpikesIndices~=0);

%UNreference_train=SpikesIndices(SpikesIndices~=0);

%% For offline
%Lx=floor(1*1e-3*fs);
%rm_train=UNreference_train(find(diff(UNreference_train)<Lx)+1);
%reference_train=setdiff(UNreference_train,rm_train);
% LCKreference_train=zeros(length(UNreference_train),1);
% remUNreference_train=UNreference_train;
% for im=1:length(UNreference_train)
%     cW=UNreference_train(im);
%     CWin1=max(cW-Lx,1);
%     CWin2=min(cW+Lx, length(data_in));
%     
%     CWIN=CWin1:CWin2;
%     C=intersect(CWIN,remUNreference_train);
%     Cn=0;
%     if length(C)>1
%     Cn=C(1);
%     end
%     
%     LCKreference_train(im)=Cn;    
%     remUNreference_train=setdiff(remUNreference_train,C);
% end
% 
% reference_train=LCKreference_train(LCKreference_train~=0);






