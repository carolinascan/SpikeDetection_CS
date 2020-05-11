%input TrCh num
%output vector contains the distances of each channel from the Trigger
%Site Maps A4x4 CM16/CM16LP NeuroNexus
% ALberto Averna 02-23-15
function [distancefromtrigger]=DistTrigg(TrCh)

lookup=[1 7 13 14; 3 4 10 16; 2 8 12 11; 6 5 9 15];
rowdist=100;
coldist=125;
distancefromtrigger=[];
  [rT,cT]=find(lookup==TrCh);     
  for i=1:16
      [r,c]=find(lookup==i);
      distrow=abs(rT-r);
      distcol=abs(cT-c);
      if r==rT||c==cT
          
          distancefromtrigger(i)=(distrow*rowdist)+(distcol*coldist);
      else
          distancefromtrigger(i)=sqrt((distrow*rowdist)^2+(distcol*coldist)^2);
      end
  end
  