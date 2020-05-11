function [ts,pmin] = SNEOThreshold(data,pars_,art_idx)
%% SNEOTHRESHOLD   Smoothed nonlinear energy operator thresholding detect
%
%  [p2pamp,ts,pmin,dt,E] = SNEOTHRESHOLD(data,pars,art_idx)
%
%   --------
%    INPUTS
%   --------
%     data      :       1 x N double of bandpass filtered data, preferrably
%                       with artifact excluded already, on which to perform
%                       monopolar spike detection.
%
%     pars      :       Parameters structure from SPIKEDETECTCLUSTER with
%                       the following fields:
%
%       -> SNEO_N    \\ number of samples for smoothing window
%       -> MULTCOEFF \\ factor to multiply NEO noise threshold by
%       -> FS        \\ sampling frequency
%       -> NS_AROUND \\ window to reduce consecutive crossings to single
%                       points
%       -> REFRTIME  \\ refractory period (minimum distance between spikes)
%
%    art_idx   :        Indexing vector for artifact rejection periods,
%                       which are temporarily removed so that thresholds
%                       are not underestimated.
%
%   --------
%    OUTPUT
%   --------
%
%     ts        :       Timestamps (sample indices) of spike peaks.
%
%    pmin       :       Value at peak minimum. (pw) in SPIKEDETECTIONARRAY
%
%      dt       :       Time difference between spikes. (pp) in
%                       SPIKEDETECTIONARRAY
%
%      E        :       Smoothed nonlinear energy operator value at peaks.
%
% By: Max Murphy    1.0   01/04/2018   Original version (R2017a)

%% Defaults parameters and input validation
% pars.REFRTIME        = 0.5;  % Refractory period (suggest: 2 ms MAX).
% pars.MULTCOEFF       = 4.5;  % Multiplication coefficient for noise
% pars.SNEO_N          = 5;    % Number of samples to use for smoothed nonlinear energy operator window
% pars.NS_AROUND       = 7;    % Number of samples around the peak to "look" for negative peak

ff = fields(pars_);
for ii=1:numel(ff)
    if isfield(pars_,ff{ii})
        pars_.(ff{ii}) = pars_.(ff{ii});
    end
end

if iscolumn(data),data=data';end
if nargin < 3,art_idx=[];end
%% GET NONLINEAR ENERGY OPERATOR SIGNAL AND SMOOTH IT
Y = data - mean(data);
Yb = Y(1:(end-2));
Yf = Y(3:end);
Z = [0, Y(2:(end-1)).^2 - Yb .* Yf, 0]; % Discrete nonlinear energy operator
% Zs = fastsmooth(Z,pars.SNEO_N);
kern = ones(1,pars_.SNEO_N)./pars_.SNEO_N;
Zs = fliplr( conv( fliplr(conv(Z,kern,'same')) ,kern,'same')); % the same as the above tri option,(default one here used) but 10x faster
clear('Z','Y','Yb','Yf');
%% CREATE THRESHOLD FILTER
tmpdata = data;
tmpdata(art_idx) = [];
tmpZ = Zs;
tmpZ(art_idx) = [];

th = pars_.MULTCOEFF * median(abs(tmpZ));
data_th = pars_.MULTCOEFF * median(abs(tmpdata));
clear('tmpZ','tmpdata');
%% PERFORM THRESHOLDING
pk = Zs > th;

if sum(pk) <= 1
   ts = [];
   pmin = [];
   return
end

%% REDUCE CONSECUTIVE CROSSINGS TO SINGLE POINTS
z = zeros(size(data));
% pkloc = repmat(find(pk),pars.NS_AROUND*2+1,1) + (-pars.NS_AROUND:pars.NS_AROUND).';
% pkloc(pkloc < 1) = 1;
% pkloc(pkloc > numel(data)) = numel(data);
% pkloc = unique(pkloc(:));
% z(pkloc) = data(pkloc);

%%%%%%%%%%%%%%%% FB, 5/28/2019 optimized for speed.  The above process took 2.9s 
%%%%%%%%%%%%%%%%  now it takes more or less 0.85s. Same result
pkloc = conv(pk,ones(1,pars_.NS_AROUND*2+1),'same')>0;
z(pkloc) = data(pkloc);


minTime = 1e-3*pars_.REFRTIME; % parameter in milliseconds
[ts,pmin] = peakseek(-z,minTime*pars_.FS,data_th);

end


function [locs,pks]=peakseek(x,minpeakdist,minpeakh)
% Alternative to the findpeaks function.  This thing runs much much faster.
% It really leaves findpeaks in the dust.  It also can handle ties between
% peaks.  Findpeaks just erases both in a tie.  Shame on findpeaks.
%
% x is a vector input (generally a timecourse)
% minpeakdist is the minimum desired distance between peaks (optional, defaults to 1)
% minpeakh is the minimum height of a peak (optional)
%
% (c) 2010
% Peter O'Connor
% peter<dot>ed<dot>oconnor .AT. gmail<dot>com

if size(x,2)==1, x=x'; end

% Find all maxima and ties
locs=find(x(2:end-1)>=x(1:end-2) & x(2:end-1)>=x(3:end))+1;

if nargin<2, minpeakdist=1; end % If no minpeakdist specified, default to 1.

if nargin>2 % If there's a minpeakheight
    locs(x(locs)<=minpeakh)=[];
end

if minpeakdist>1
    while 1

        del=diff(locs)<minpeakdist;

        if ~any(del), break; end

        pks=x(locs);

        [garb,mins]=min([pks(del) ; pks([false del])]); %#ok<ASGLU>

        deln=find(del);

        deln=[deln(mins==1) deln(mins==2)+1];

        locs(deln)=[];

    end
end

if nargout>1
    pks=x(locs);
end


end