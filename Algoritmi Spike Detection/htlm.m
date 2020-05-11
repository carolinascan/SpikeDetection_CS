function [locs] = htlm(signal,parameter,rumore)
% for i=1:length(signal)
%     if signal(i)<-20
        noise=rumore.data;
        std_noise=std(noise);
        threshold=-parameter*std_noise;
        [peaks,locs]=findpeaks(-signal,'MinPeakHeight',-threshold,'MinPeakDistance',24);
% end
% end
end

