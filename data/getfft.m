function [fftsigamp, hz]= getfft(filt_sig, fs, npnts)
filt_sig=filt_sig-mean(filt_sig);
fftsig=fft(filt_sig);
fftsigamp=2*abs(fftsig)/npnts;
hz=linspace(0,fs/2,floor(npnts/2)+1);
