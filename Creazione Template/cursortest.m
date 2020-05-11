
clear all; close all;
clc

[filename,pathname]=uigetfile('.mat');
cd(pathname)
load(filename,'data')
prompt = 'window size in seconds';
windowsize=input(prompt);
prompt = 'window overlap in seconds';
windowoverlap = input(prompt);
minyval=min(data);
maxyval=max(data);

Segments = (numel(data(1:30*24414)) / (windowsize * 24414));
flgSpikes = 0; XY_SelectedSpikes = [];
figure(1)


for x = 1:floor(Segments)
    if x == 1
        h = plot(((1:(windowsize*24414))),data(1:(windowsize*24414)));
        axis([-inf inf minyval maxyval])
        nextStart = floor((windowsize - windowoverlap) * 24414);
    else
        if flgSpikes == 0
            h = plot((((nextStart:(nextStart + (windowsize*24414))))),data(nextStart:(nextStart + (windowsize*24414))));
            axis([-inf inf minyval maxyval])
            nextStart = nextStart + floor((windowsize - windowoverlap) * 24414);
        else
            xVals = (((nextStart:(nextStart + (windowsize*24414)))));
            if any(X >= xVals(1) & X <= xVals(end))
                pointsX = X(X >= xVals(1) & X <= xVals(end));
                pointsY = Y(X >= xVals(1) & X <= xVals(end));
                h = plot((((nextStart:(nextStart + (windowsize*24414))))),data(nextStart:(nextStart + (windowsize*24414))));
                axis([-inf inf minyval maxyval])
                hold on
                plot(pointsX,pointsY,'r.','markersize',12);
                axis([-inf inf minyval maxyval])
                nextStart = nextStart + floor((windowsize - windowoverlap) * 24414);
            end
        end
    end
    [X,Y,button] = ginput_zoom;
    %[X,Y,button] = ginput2;
    %clf
    if ~isempty(X)
        flgSpikes = 1;
        XY_SelectedSpikes = [XY_SelectedSpikes; X, Y];
    else
        flgSpikes = 0;
    end
end

%Convert X values from ms to samples
%XY_SelectedSpikes(:,1) = (XY_SelectedSpikes(:,1) / 1000) * 24414;



for i=1:length(XY_SelectedSpikes(:,1))
    snap=[(XY_SelectedSpikes(i,1)-(2/1000*24414):XY_SelectedSpikes(i,1)+(2/1000*24414))' ...
        data(XY_SelectedSpikes(i,1)-(2/1000*24414):XY_SelectedSpikes(i,1)+(2/1000*24414))];
    for j=1:length(snap)
        D(j) = pdist([[XY_SelectedSpikes(i,1),XY_SelectedSpikes(i,2)];snap(j,:)]);
    end
    XYcorrected(i,:)=snap(find(D==min(D)),:);
    clear snap D
end
hold on;
plot(XYcorrected(:,1),XYcorrected(:,2),'*k','markersize',12);


close(figure(1))

save(fullfile('F:\In Vivo Data\Acute\Results\Visual Inspection\' , [filename(1:end-4) '_SpikePoints']),'XYcorrected','XY_SelectedSpikes');