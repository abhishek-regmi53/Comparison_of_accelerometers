clear all
close all
clc
%Reading the acceleration data
j=0;
for i=1:3
    fname=strcat("rp",num2str(i+j+4),".sg2");
    fileid=fopen(fname);
    c{i}=textscan(fileid,'%f %f','HeaderLines',1); 
    j=j+3;
end

dat1=cell2mat(c{1,1});
dat2=cell2mat(c{1,2});
dat3=cell2mat(c{1,3});

%data_filtering
%Removing mean
dat1(:,2)=3.845E+05*dat1(:,2);
dat2(:,2)=3.845E+05*dat2(:,2);
dat3(:,2)=3.845E+05*dat3(:,2);

acc_1=dat1(:,2)-mean(dat1(:,2));
acc_2=dat2(:,2)-mean(dat2(:,2));
acc_3=dat3(:,2)-mean(dat3(:,2));

acc1=flip(acc_1);
acc2=flip(acc_2);
acc3=flip(acc_3);

fcutoff=12;
transw=0.1;
fs=100;
[filt_acc1, hz, filtkernX]= filtered(fcutoff, transw, fs, length(acc1), acc1);

[filt_acc2, hz, filtkernX]= filtered(fcutoff, transw, fs, length(acc2), acc2);

% [fftsigamp1, hz1]= getfft(acc1, fs, length(acc1));
% [fftsigamp2, hz2]= getfft(filt_acc1, fs, length(acc2));

%%%%Plotting original and filtered signal%%%%

% figure(1)
% plot(sig);
% hold on;
% plot(filt_acc1);
% legend("Original","Filtered");

%%%%Plotting frequency spectrum of original and filtered signal%%%%

% figure(3)
% plot(hz1, fftsigamp1(1:length(hz1)));
% hold on;
% plot(hz2, fftsigamp2(1:length(hz2)));
% legend("Original","Filtered");

%%%Finding the maximum and matching two graphs

[max_acc1, idx_acc1]= max(abs(filt_acc1(55000:65000)));
[max_acc2, idx_acc2]= max(abs(filt_acc2(55000:65000)));
% c=max_pz/max_fbal;
% c=2.4;
idx_diff=idx_acc1-idx_acc2; %difference in maximum index of two measurements

if idx_diff>=0
    acc1_new=filt_acc1(idx_diff:end); %New acceleration signal after deduction
    plot(acc1_new);
    hold on;
    plot(filt_acc2);
    legend('acc1','acc2');
else 
    acc2_new=filt_acc2(-idx_diff:end); %New acceleration signal after deduction
    plot(acc2_new);
    hold on;
    plot(filt_acc1);
    legend('acc2','acc1');
end

time_difference=abs(idx_diff)/100;
fprintf("Time Difference is: %f sec", time_difference);

figure(4)
t1= linspace(0,length(acc1)/fs,length(acc1));
t2= linspace(0,length(acc2)/fs,length(acc2));
plot(t1,acc1);
hold on;
plot(t2,acc2);









