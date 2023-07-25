%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      Filter test        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

% Creating a sinusoidal signal
amp1=5;
amp2=1;
f1=5;
f2=15;
t=linspace(0,10,10/0.01+1);
sig=amp1*sin(2*pi()*f1*t)+amp2*sin(2*pi()*f2*t);
sig1=sig';
%Applying a filter in the sig
fcutoff=12;
transw=0.01;
fs=1/(t(2)-t(1));
npnts=length(sig);
[filt_sig, hz, filtkernX]= filtered(fcutoff, transw, fs, npnts, sig1);

figure(1)
plot(t,sig);
hold on;
plot(t, filt_sig);
legend("Original","Filtered");

figure(2)
plot(hz, filtkernX(1:length(hz)));

[fftsigamp1, hz1]= getfft(sig1, fs, npnts);
[fftsigamp2, hz2]= getfft(filt_sig, fs, npnts);

figure(3)
plot(hz1, fftsigamp1(1:length(hz1)));
hold on;
plot(hz2, fftsigamp2(1:length(hz2)));
legend("Original","Filtered");
