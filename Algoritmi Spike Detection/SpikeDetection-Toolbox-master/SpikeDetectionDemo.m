% This Toolbox is designed to detect spikes in generated signals as it is easier to check accuracy of the algorithms. 
% To generate the signal You have to enter following input parameters: 
% 
    % Length L which describes the total number of samples for the signal. 
    % 
    % Number of spikes numspikes You wish to detect.
    % 
    % sigma which determines the signal-to-noise ratio for the signal

    %     After input parameters are given, press "Run" to start process.
    %     Output shown is the signal with marked spikes and detection rate DR and the false-positve rate FP of the used algorithms.


L = 100000; %Length of the signal 
fs = 10000; %not to be change
numspikes = 200; %number of spikes (if this number is too large, with respect to L, then genMEASignal cannot place all spikes, resulting in an infinite loop)
sigma = 4; %determines SNR


params.method = 'numspikes';
params.numspikes = numspikes;
params.filter = 0;


[s,t,sppos,snr] = genMEASignal(L,fs,sigma,numspikes,'randpos');


plot(t,s);
hold on, plot(t(sppos),s(sppos),'*');
ylabel ('Voltage in �V')
xlabel ( 'Time in s')
hold off;


in.M = s;
in.SaRa = fs;

spikepos1 = WTEO(in,params);
spikepos2 = TIFCO(in,params); 
spikepos3 = SWTTEO(in,params);
spikepos4 = MTEO(in,[1 3 5],params);
spikepos5 = SWT2012(in,params);  
spikepos6 = ABS(in,params);
spikepos7 = PTSD(in,params);

offset = 2e-4*fs;

res1 = evalPeakList(sppos,offset,spikepos1);
res2 = evalPeakList(sppos,offset,spikepos2);
res3 = evalPeakList(sppos,offset,spikepos3);
res4 = evalPeakList(sppos,offset,spikepos4);
res5 = evalPeakList(sppos,offset,spikepos5);
res6 = evalPeakList(sppos,offset,spikepos6);
res7 = evalPeakList(sppos,offset,spikepos7);

fprintf('----------------------\n');
fprintf('WTEO - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos1) - res1)/length(spikepos1)*100), (length(spikepos1) - res1)/length(spikepos1)*100);
fprintf('GABR - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos2) - res2)/length(spikepos2)*100), (length(spikepos2) - res2)/length(spikepos2)*100);
fprintf('SWTO - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos3) - res3)/length(spikepos3)*100), (length(spikepos3) - res3)/length(spikepos3)*100);
fprintf('MTEO - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos4) - res4)/length(spikepos4)*100), (length(spikepos4) - res4)/length(spikepos4)*100);
fprintf('SWTS - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos5) - res5)/length(spikepos5)*100), (length(spikepos5) - res5)/length(spikepos5)*100);
fprintf('ABS - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos6) - res6)/length(spikepos6)*100), (length(spikepos6) - res6)/length(spikepos6)*100);
fprintf('PTSD - DR: %2.2f  \t FP: %2.2f \n',100 -((length(spikepos7) - res7)/length(spikepos7)*100), (length(spikepos7) - res7)/length(spikepos7)*100);
fprintf('----------------------\n');




%--------------------------------------------------------------------------

