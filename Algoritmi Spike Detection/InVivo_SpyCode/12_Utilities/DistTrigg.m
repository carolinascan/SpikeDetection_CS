%input TrCh num
%output vector contains the distances of each channel from the Trigger
%Site Maps A4x4 CM16/CM16LP NeuroNexus
% ALberto Averna 02-23-15
function [distancefromtrigger]=DistTrigg(TrCh)
lookuptable= [  3  1; 7  2; 11  3; 15  4; 2  5; 6  6; 10  7; 14  8; ...
                4  9; 8 10; 12 11; 16 12; 1 13; 5 14; 9 15; 13 16];
lookup=[3 7 11 15; 2 6 10 14; 4 8 12 16; 1 5 9 13];
rowdist=100;
coldist=125;

       for n=1:16
       [rT,cT]=find(lookup==TrCh);
       [r,c]=find(lookup==n);
       distrow=abs(rT-r);
       distcol=abs(cT-c);
       distancefromtrigger(n)=(distrow*rowdist)+(distcol*coldist);
       end

       