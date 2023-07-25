function [filt_sig, hz, filtkernX]= filtered(fcutoff, transw, fs, npnts, sig)

%Filtering the signal
shape=[1 1 0 0];
order=round(30*fs/fcutoff);
frex=[0  fcutoff fcutoff+fcutoff*transw fs/2]/(fs/2);

%%%Filter Kernel
filtkern=firls(order, frex, shape);

%%%Power Spectrum
filtkernX=abs(fft(filtkern, npnts)).^2;
%hz=linspace(0, fs/2, floor(length(filtkern)/2)+1);
hz=linspace(0,fs/2,floor(npnts/2)+1);
filtkernX=filtkernX(1:length(hz));
% reflectsig=[sig(order:-1:1);sig;sig(end:-1:end-order+1)];
% reflectsig=filter(filtkern,1,reflectsig);
% reflectsig=filter(filtkern,1,reflectsig(end:-1:1));
% reflectsig=reflectsig(end:-1:1);
% filt_sig=reflectsig(order+1:end-order);
filt_sig=filtfilt(filtkern,1,sig);



