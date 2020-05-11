function [isi_cl0_s,isi_cl1_s,isi_cl2_s] = check_isi_distribution(class0,class1,class2)
fc=24414;
isi_cl0=diff(class0);
isi_cl1=diff(class1);
isi_cl2=diff(class2);
isi_cl1_s=isi_cl1./fc;
isi_cl2_s=isi_cl2./fc;
isi_cl0_s=isi_cl0./fc;
end

