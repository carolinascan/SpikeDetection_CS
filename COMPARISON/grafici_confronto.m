clc, clear all, close all
%% 
ptsd_1=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\PARAMETRO 1-20\ANALYSIS_firstHalf.mat');
ptsd_2=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD ANALISI\PTSD\MULTI UNIT V2\PARAMETRO 1-20\ANALYSIS_secondHalf.mat');
mptsd=load('C:\Users\Carolina\Documents\GitHub\SpikeDetection_Carolina\Analisi segnali\PTSD MODIFICATO ANALISI\PTSD MODIFICATO\PARAMETRO 1-20\MULTI UNIT\ANALYSIS.mat');
%% EFFICIENCY
eff_ptsd_plp1_snr1=ptsd_1.EFF(1,:,1);
eff_mptsd_plp1_snr1=mptsd.EFF(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.EFF(5,:,1);
eff_mptsd_plp1_snr5=mptsd.EFF(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.EFF2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.EFF(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.EFF(1,:,2);
eff_mptsd_plp2_snr1=mptsd.EFF(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.EFF(5,:,2);
eff_mptsd_plp2_snr5=mptsd.EFF(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.EFF2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.EFF(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.EFF(1,:,3);
eff_mptsd_plp3_snr1=mptsd.EFF(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.EFF(5,:,3);
eff_mptsd_plp3_snr5=mptsd.EFF(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.EFF2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.EFF(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.EFF(1,:,4);
eff_mptsd_plp4_snr1=mptsd.EFF(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.EFF(5,:,4);
eff_mptsd_plp4_snr5=mptsd.EFF(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.EFF2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.EFF(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.EFF(1,:,5);
eff_mptsd_plp5_snr1=mptsd.EFF(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.EFF(5,:,5);
eff_mptsd_plp5_snr5=mptsd.EFF(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.EFF2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.EFF(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('Efficiency')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'),ylabel('Efficiency')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'),ylabel('Efficiency')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('Efficiency')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('Efficiency')

%% ACCURACY 
eff_ptsd_plp1_snr1=ptsd_1.ACCURACY(1,:,1);
eff_mptsd_plp1_snr1=mptsd.ACCURACY(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.ACCURACY(5,:,1);
eff_mptsd_plp1_snr5=mptsd.ACCURACY(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.ACCURACY2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.ACCURACY(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.ACCURACY(1,:,2);
eff_mptsd_plp2_snr1=mptsd.ACCURACY(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.ACCURACY(5,:,2);
eff_mptsd_plp2_snr5=mptsd.ACCURACY(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.ACCURACY2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.ACCURACY(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.ACCURACY(1,:,3);
eff_mptsd_plp3_snr1=mptsd.ACCURACY(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.ACCURACY(5,:,3);
eff_mptsd_plp3_snr5=mptsd.ACCURACY(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.ACCURACY2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.ACCURACY(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.ACCURACY(1,:,4);
eff_mptsd_plp4_snr1=mptsd.ACCURACY(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.ACCURACY(5,:,4);
eff_mptsd_plp4_snr5=mptsd.ACCURACY(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.ACCURACY2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.ACCURACY(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.ACCURACY(1,:,5);
eff_mptsd_plp5_snr1=mptsd.ACCURACY(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.ACCURACY(5,:,5);
eff_mptsd_plp5_snr5=mptsd.ACCURACY(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.ACCURACY2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.ACCURACY(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('Efficienza')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('Confronto tra le efficienze, PLP = 1'), xlabel('MultCoeff'), ylabel('Efficienza')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('Confronto tra le efficienze, PLP = 1.5'), xlabel('MultCoeff'), ylabel('Efficienza')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('Confronto tra le efficienze, PLP = 2'), xlabel('MultCoeff'), ylabel('Efficienza')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('Confronto tra le efficienze, PLP = 2.5'), xlabel('MultCoeff'), ylabel('Efficienza')
%% SENSITIVITY 
eff_ptsd_plp1_snr1=ptsd_1.SENSITIVITY(1,:,1);
eff_mptsd_plp1_snr1=mptsd.SENSITIVITY(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.SENSITIVITY(5,:,1);
eff_mptsd_plp1_snr5=mptsd.SENSITIVITY(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.SENSITIVITY2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.SENSITIVITY(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.SENSITIVITY(1,:,2);
eff_mptsd_plp2_snr1=mptsd.SENSITIVITY(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.SENSITIVITY(5,:,2);
eff_mptsd_plp2_snr5=mptsd.SENSITIVITY(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.SENSITIVITY2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.SENSITIVITY(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.SENSITIVITY(1,:,3);
eff_mptsd_plp3_snr1=mptsd.SENSITIVITY(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.SENSITIVITY(5,:,3);
eff_mptsd_plp3_snr5=mptsd.SENSITIVITY(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.SENSITIVITY2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.SENSITIVITY(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.SENSITIVITY(1,:,4);
eff_mptsd_plp4_snr1=mptsd.SENSITIVITY(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.SENSITIVITY(5,:,4);
eff_mptsd_plp4_snr5=mptsd.SENSITIVITY(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.SENSITIVITY2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.SENSITIVITY(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.SENSITIVITY(1,:,5);
eff_mptsd_plp5_snr1=mptsd.SENSITIVITY(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.SENSITIVITY(5,:,5);
eff_mptsd_plp5_snr5=mptsd.SENSITIVITY(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.SENSITIVITY2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.SENSITIVITY(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('Sensitivity')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'), ylabel('Sensitivity')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'), ylabel('Sensitivity')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('Sensitivity')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('Sensitivity')
%% PRECISION  
eff_ptsd_plp1_snr1=ptsd_1.PRECISION(1,:,1);
eff_mptsd_plp1_snr1=mptsd.PRECISION(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.PRECISION(5,:,1);
eff_mptsd_plp1_snr5=mptsd.PRECISION(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.PRECISION2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.PRECISION(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.PRECISION(1,:,2);
eff_mptsd_plp2_snr1=mptsd.PRECISION(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.PRECISION(5,:,2);
eff_mptsd_plp2_snr5=mptsd.PRECISION(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.PRECISION2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.PRECISION(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.PRECISION(1,:,3);
eff_mptsd_plp3_snr1=mptsd.PRECISION(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.PRECISION(5,:,3);
eff_mptsd_plp3_snr5=mptsd.PRECISION(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.PRECISION2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.PRECISION(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.PRECISION(1,:,4);
eff_mptsd_plp4_snr1=mptsd.PRECISION(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.PRECISION(5,:,4);
eff_mptsd_plp4_snr5=mptsd.PRECISION(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.PRECISION2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.PRECISION(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.PRECISION(1,:,5);
eff_mptsd_plp5_snr1=mptsd.PRECISION(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.PRECISION(5,:,5);
eff_mptsd_plp5_snr5=mptsd.PRECISION(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.PRECISION2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.PRECISION(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('Precision')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'), ylabel('Precision')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'), ylabel('Precision')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('Precision')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('Precision')
%% SPECIFICITY  
eff_ptsd_plp1_snr1=ptsd_1.SPECIFICITY(1,:,1);
eff_mptsd_plp1_snr1=mptsd.SPECIFICITY(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.SPECIFICITY(5,:,1);
eff_mptsd_plp1_snr5=mptsd.SPECIFICITY(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.SPECIFICITY2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.SPECIFICITY(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.SPECIFICITY(1,:,2);
eff_mptsd_plp2_snr1=mptsd.SPECIFICITY(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.SPECIFICITY(5,:,2);
eff_mptsd_plp2_snr5=mptsd.SPECIFICITY(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.SPECIFICITY2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.SPECIFICITY(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.SPECIFICITY(1,:,3);
eff_mptsd_plp3_snr1=mptsd.SPECIFICITY(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.SPECIFICITY(5,:,3);
eff_mptsd_plp3_snr5=mptsd.SPECIFICITY(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.SPECIFICITY2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.SPECIFICITY(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.SPECIFICITY(1,:,4);
eff_mptsd_plp4_snr1=mptsd.SPECIFICITY(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.SPECIFICITY(5,:,4);
eff_mptsd_plp4_snr5=mptsd.SPECIFICITY(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.SPECIFICITY2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.SPECIFICITY(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.SPECIFICITY(1,:,5);
eff_mptsd_plp5_snr1=mptsd.SPECIFICITY(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.SPECIFICITY(5,:,5);
eff_mptsd_plp5_snr5=mptsd.SPECIFICITY(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.SPECIFICITY2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.SPECIFICITY(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('Specificity')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'), ylabel('Specificity')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'), ylabel('Specificity')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('Specificity')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('Specificity')
%% F1S
eff_ptsd_plp1_snr1=ptsd_1.F1_SCORE(1,:,1);
eff_mptsd_plp1_snr1=mptsd.F1_SCORE(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.F1_SCORE(5,:,1);
eff_mptsd_plp1_snr5=mptsd.F1_SCORE(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.F1_SCORE2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.F1_SCORE(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.F1_SCORE(1,:,2);
eff_mptsd_plp2_snr1=mptsd.F1_SCORE(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.F1_SCORE(5,:,2);
eff_mptsd_plp2_snr5=mptsd.F1_SCORE(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.F1_SCORE2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.F1_SCORE(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.F1_SCORE(1,:,3);
eff_mptsd_plp3_snr1=mptsd.F1_SCORE(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.F1_SCORE(5,:,3);
eff_mptsd_plp3_snr5=mptsd.F1_SCORE(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.F1_SCORE2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.F1_SCORE(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.F1_SCORE(1,:,4);
eff_mptsd_plp4_snr1=mptsd.F1_SCORE(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.F1_SCORE(5,:,4);
eff_mptsd_plp4_snr5=mptsd.F1_SCORE(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.F1_SCORE2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.F1_SCORE(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.F1_SCORE(1,:,5);
eff_mptsd_plp5_snr1=mptsd.F1_SCORE(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.F1_SCORE(5,:,5);
eff_mptsd_plp5_snr5=mptsd.F1_SCORE(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.F1_SCORE2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.F1_SCORE(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('F1 Score')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'), ylabel('F1 Score')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'), ylabel('F1 Score')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('F1 Score')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('F1 Score')

%% MCC
eff_ptsd_plp1_snr1=ptsd_1.MCC_all(1,:,1);
eff_mptsd_plp1_snr1=mptsd.MCC_all(1,:,1);
eff_ptsd_plp1_snr5=ptsd_1.MCC_all(5,:,1);
eff_mptsd_plp1_snr5=mptsd.MCC_all(5,:,1);
eff_ptsd_plp1_snr10=ptsd_2.MCC_all2(5,:,1);
eff_mptsd_plp1_snr10=mptsd.MCC_all(10,:,1);

eff_ptsd_plp2_snr1=ptsd_1.MCC_all(1,:,2);
eff_mptsd_plp2_snr1=mptsd.MCC_all(1,:,2);
eff_ptsd_plp2_snr5=ptsd_1.MCC_all(5,:,2);
eff_mptsd_plp2_snr5=mptsd.MCC_all(5,:,2);
eff_ptsd_plp2_snr10=ptsd_2.MCC_all2(5,:,2);
eff_mptsd_plp2_snr10=mptsd.MCC_all(10,:,2);

eff_ptsd_plp3_snr1=ptsd_1.MCC_all(1,:,3);
eff_mptsd_plp3_snr1=mptsd.MCC_all(1,:,3);
eff_ptsd_plp3_snr5=ptsd_1.MCC_all(5,:,3);
eff_mptsd_plp3_snr5=mptsd.MCC_all(5,:,3);
eff_ptsd_plp3_snr10=ptsd_2.MCC_all2(5,:,3);
eff_mptsd_plp3_snr10=mptsd.MCC_all(10,:,3);

eff_ptsd_plp4_snr1=ptsd_1.MCC_all(1,:,4);
eff_mptsd_plp4_snr1=mptsd.MCC_all(1,:,4);
eff_ptsd_plp4_snr5=ptsd_1.MCC_all(5,:,4);
eff_mptsd_plp4_snr5=mptsd.MCC_all(5,:,4);
eff_ptsd_plp4_snr10=ptsd_2.MCC_all2(5,:,4);
eff_mptsd_plp4_snr10=mptsd.MCC_all(10,:,4);

eff_ptsd_plp5_snr1=ptsd_1.MCC_all(1,:,5);
eff_mptsd_plp5_snr1=mptsd.MCC_all(1,:,5);
eff_ptsd_plp5_snr5=ptsd_1.MCC_all(5,:,5);
eff_mptsd_plp5_snr5=mptsd.MCC_all(5,:,5);
eff_ptsd_plp5_snr10=ptsd_2.MCC_all2(5,:,5);
eff_mptsd_plp5_snr10=mptsd.MCC_all(10,:,5);

figure 
subplot 511
plot(1:20,eff_ptsd_plp1_snr1,'--g',1:20,eff_mptsd_plp1_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp1_snr5,'--b',1:20,eff_mptsd_plp1_snr5,'b')
plot(1:20,eff_ptsd_plp1_snr10,'--r',1:20,eff_mptsd_plp1_snr10,'r')
title('PLP = 0.5'), xlabel('MultCoeff'), ylabel('MCC')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)
subplot 512
plot(1:20,eff_ptsd_plp2_snr1,'--g',1:20,eff_mptsd_plp2_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp2_snr5,'--b',1:20,eff_mptsd_plp2_snr5,'b')
plot(1:20,eff_ptsd_plp2_snr10,'--r',1:20,eff_mptsd_plp2_snr10,'r')
title('PLP = 1'), xlabel('MultCoeff'), ylabel('MCC')
subplot 513
plot(1:20,eff_ptsd_plp3_snr1,'--g',1:20,eff_mptsd_plp3_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp3_snr5,'--b',1:20,eff_mptsd_plp3_snr5,'b')
plot(1:20,eff_ptsd_plp3_snr10,'--r',1:20,eff_mptsd_plp3_snr10,'r')
title('PLP = 1.5'), xlabel('MultCoeff'), ylabel('MCC')
subplot 514
plot(1:20,eff_ptsd_plp4_snr1,'--g',1:20,eff_mptsd_plp4_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp4_snr5,'--b',1:20,eff_mptsd_plp4_snr5,'b')
plot(1:20,eff_ptsd_plp4_snr10,'--r',1:20,eff_mptsd_plp4_snr10,'r')
title('PLP = 2'), xlabel('MultCoeff'), ylabel('MCC')
subplot 515
plot(1:20,eff_ptsd_plp5_snr1,'--g',1:20,eff_mptsd_plp5_snr1,'g')
hold on 
plot(1:20,eff_ptsd_plp5_snr5,'--b',1:20,eff_mptsd_plp5_snr5,'b')
plot(1:20,eff_ptsd_plp5_snr10,'--r',1:20,eff_mptsd_plp5_snr10,'r')
title('PLP = 2.5'), xlabel('MultCoeff'), ylabel('MCC')


%%
figure
subplot 611
plot(1:20,eff_ptsd_snrH,'--g',1:20,eff_mptsd_plp1,'g')
hold on 
plot(1:20,eff_ptsd_snrM,'--b',1:20,eff_mptsd_snrM,'b')
plot(1:20,eff_ptsd_snrL,'--r',1:20,eff_mptsd_snrL,'r')
title('Efficiency'), xlabel('MultCoeff')
subplot 612
plot(1:20,sens_ptsd_snrH,'--g',1:20,sens_mptsd_snrH,'g')
hold on 
plot(1:20,sens_ptsd_snrM,'--b',1:20,sens_mptsd_snrM,'b')
plot(1:20,sens_ptsd_snrL,'--r',1:20,sens_mptsd_snrL,'r')
title('Sensitivity'), xlabel('MultCoeff')
subplot 613
plot(1:20,acc_ptsd_snrH,'--g',1:20,acc_mptsd_snrH,'g')
hold on 
plot(1:20,acc_ptsd_snrM,'--b',1:20,acc_mptsd_snrM,'b')
plot(1:20,acc_ptsd_snrL,'--r',1:20,acc_mptsd_snrL,'r')
title('Accuracy'), xlabel('MultCoeff')
subplot 614
plot(1:20,prec_ptsd_snrH,'--g',1:20,prec_mptsd_snrH,'g')
hold on 
plot(1:20,prec_ptsd_snrM,'--b',1:20,prec_mptsd_snrM,'b')
plot(1:20,prec_ptsd_snrL,'--r',1:20,prec_mptsd_snrL,'r')
title('Precision'), xlabel('MultCoeff')
subplot 615
plot(1:20,fpr_ptsd_snrH,'--g',1:20,fpr_mptsd_snrH,'g')
hold on 
plot(1:20,fpr_ptsd_snrM,'--b',1:20,fpr_mptsd_snrM,'b')
plot(1:20,fpr_ptsd_snrL,'--r',1:20,fpr_mptsd_snrL,'r')
title('False Positive Rate'), xlabel('MultCoeff')
subplot 616
plot(1:20,fnr_ptsd_snrH,'--g',1:20,fnr_mptsd_snrH,'g')
hold on 
plot(1:20,fnr_ptsd_snrM,'--b',1:20,fnr_mptsd_snrM,'b')
plot(1:20,fnr_ptsd_snrL,'--r',1:20,fnr_mptsd_snrL,'r')
title('False Negative Rate'), xlabel('MultCoeff')
legend({'PTSD snrH','mPTSD snrH','PTSD snrM','mPTSD snrM','PTSD snrL','mPTSD snrL'},'NumColumns',3)

%% FS
% first 5 leel snr 
FS_ptsd=ptsd_1.SENSITIVITY(:,:,1)+ptsd_1.EFF(:,:,1)+ptsd_1.ACCURACY(:,:,1)+ptsd_1.PRECISION(:,:,1)+ptsd_1.MCC_all(:,:,1)+(ones(size(ptsd_1.FP_rate_all(:,:,1)))-ptsd_1.FP_rate_all(:,:,1))+ptsd_1.SPECIFICITY(:,:,1)+ptsd_1.F1_SCORE(:,:,1)+ptsd_1.NPV_all(:,:,1)+(ones(size(ptsd_1.FDR_all(:,:,1)))-ptsd_1.FDR_all(:,:,1))+(ones(size(ptsd_1.FOR_all(:,:,1)))-ptsd_1.FOR_all(:,:,1));
FS_mptsd=mptsd.SENSITIVITY(1:5,:,1)+mptsd.EFF(1:5,:,1)+mptsd.ACCURACY(1:5,:,1)+mptsd.PRECISION(1:5,:,1)+mptsd.MCC_all(1:5,:,1)+(ones(size(mptsd.FP_rate_all(1:5,:,1)))-mptsd.FP_rate_all(1:5,:,1))+mptsd.SPECIFICITY(1:5,:,1)+mptsd.F1_SCORE(1:5,:,1)+mptsd.NPV_all(1:5,:,1)+(ones(size(mptsd.FDR_all(1:5,:,1)))-mptsd.FDR_all(1:5,:,1))+(ones(size(mptsd.FOR_all(1:5,:,1)))-mptsd.FOR_all(1:5,:,1));

figure
subplot 121
imagesc(FS_ptsd(:,:)), colorbar, caxis([0 12])
hold on 
[maY_FS_ptsd, max_FS_ptsd]=find(FS_ptsd==(max(max(FS_ptsd))));
yticks(1:5)
yticklabels({'0.86' '0.57' '0.43' '0.35' '0.29'})
ylabel('SNR')
xlabel('MultCoeff')
plot(max_FS_ptsd,maY_FS_ptsd,'Ow','MarkerSize',20,'LineWidth',3)
title(['PTSD FS Max = ', num2str(max(max(FS_ptsd)))])
subplot 122
imagesc(FS_mptsd(:,:)), colorbar, caxis([0 12])
yticks(1:5)
yticklabels({'0.86' '0.57' '0.43' '0.35' '0.29'})
ylabel('SNR')
xlabel('MultCoeff')
hold on 
[maY_FS_mptsd, max_FS_mptsd]=find(FS_mptsd==(max(max(FS_mptsd))));
plot(max_FS_mptsd,maY_FS_mptsd,'Ow','MarkerSize',20,'LineWidth',3)
title(['mPTSD FS Max = ', num2str(max(max(FS_mptsd)))])

%%
FS_ptsd=ptsd_2.SENSITIVITY2(:,:,1)+ptsd_2.EFF2(:,:,1)+ptsd_2.ACCURACY2(:,:,1)+ptsd_2.PRECISION2(:,:,1)+ptsd_2.MCC_all2(:,:,1)+(ones(size(ptsd_2.FP_rate_all2(:,:,1)))-ptsd_2.FP_rate_all2(:,:,1))+ptsd_2.SPECIFICITY2(:,:,1)+ptsd_2.F1_SCORE2(:,:,1)+ptsd_2.NPV_all2(:,:,1)+(ones(size(ptsd_2.FDR_all2(:,:,1)))-ptsd_2.FDR_all2(:,:,1))+(ones(size(ptsd_2.FOR_all2(:,:,1)))-ptsd_2.FOR_all2(:,:,1));
FS_mptsd=mptsd.SENSITIVITY(5:10,:,1)+mptsd.EFF(5:10,:,1)+mptsd.ACCURACY(5:10,:,1)+mptsd.PRECISION(5:10,:,1)+mptsd.MCC_all(5:10,:,1)+(ones(size(mptsd.FP_rate_all(5:10,:,1)))-mptsd.FP_rate_all(5:10,:,1))+mptsd.SPECIFICITY(5:10,:,1)+mptsd.F1_SCORE(5:10,:,1)+mptsd.NPV_all(5:10,:,1)+(ones(size(mptsd.FDR_all(5:10,:,1)))-mptsd.FDR_all(5:10,:,1))+(ones(size(mptsd.FOR_all(5:10,:,1)))-mptsd.FOR_all(5:10,:,1));

figure
subplot 121
imagesc(FS_ptsd(:,:)), colorbar, caxis([0 12])
hold on 
[maY_FS_ptsd, max_FS_ptsd]=find(FS_ptsd==(max(max(FS_ptsd))));
yticks(1:5)
yticklabels({'0.25' '0.22' '0.2' '0.18' '0.16'})
ylabel('SNR')
xlabel('MultCoeff')
plot(max_FS_ptsd,maY_FS_ptsd,'Ow','MarkerSize',20,'LineWidth',3)
title(['PTSD FS Max = ', num2str(max(max(FS_ptsd)))])
subplot 122
imagesc(FS_mptsd(:,:)), colorbar, caxis([0 12])
yticks(1:5)
yticklabels({'0.25' '0.22' '0.2' '0.18' '0.16'})
ylabel('SNR')
xlabel('MultCoeff')
hold on 
[maY_FS_mptsd, max_FS_mptsd]=find(FS_mptsd==(max(max(FS_mptsd))));
plot(max_FS_mptsd,maY_FS_mptsd,'Ow','MarkerSize',20,'LineWidth',3)
title(['mPTSD FS Max = ', num2str(max(max(FS_mptsd)))])
