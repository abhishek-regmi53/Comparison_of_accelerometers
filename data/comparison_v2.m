clear all
close all
clc
%Reading the acceleration data
n=11; %number of data
for i=1:n
    fname=strcat("rp",num2str(i),".sg2");
    fileid=fopen(fname);
    c{i}=textscan(fileid,'%f %f','HeaderLines',1); 
end
%%%Removing mean
for i=1:n
    dat=cell2mat(c{1,i});
    dat(:,2)= 3.845E+05*dat(:,2);
    acc= dat(:,2)-mean(dat(:,2));
    acc_flip=flip(acc);
    d{i}=acc_flip;
end

fcutoff=12;
transw=0.1;
fs=100;
for i=1:n
    acc_tem=(d{1,i});
    [filt_acc, hz, filtkernX]= filtered(fcutoff, transw, fs, length(acc_tem), acc_tem);
    acc_f{i}=filt_acc;
end

%%%Finding the maximum and matching two graphs
for i=1:n
    [max_acc, idx_acc]= max(abs(acc_f{1,i}(55000:65000)));
    peak{i}=max_acc;
    peak_idx{i}=idx_acc;
end

for i=1:n
    for k=1:n
        if i==k
            diff{i,k}=0;
        else
            diff{i,k}=(abs(peak_idx{i}-peak_idx{k}))/100;
        end
    end
end
max_time=max(diff);


% [max_acc1, idx_acc1]= max(abs(filt_acc1(55000:65000)));
% [max_acc2, idx_acc2]= max(abs(filt_acc2(55000:65000)));
% % c=max_pz/max_fbal;
% % c=2.4;
% idx_diff=idx_acc1-idx_acc2; %difference in maximum index of two measurements
% 
% if idx_diff>=0
%     acc1_new=filt_acc1(idx_diff:end); %New acceleration signal after deduction
%     plot(acc1_new);
%     hold on;
%     plot(filt_acc2);
%     legend('acc1','acc2');
% else 
%     acc2_new=filt_acc2(-idx_diff:end); %New acceleration signal after deduction
%     plot(acc2_new);
%     hold on;
%     plot(filt_acc1);
%     legend('acc2','acc1');
% end
% 
% time_difference=abs(idx_diff)/100;
% fprintf("Time Difference is: %f sec", time_difference);
% 
% figure(4)
% t1= linspace(0,length(acc1)/fs,length(acc1));
% t2= linspace(0,length(acc2)/fs,length(acc2));
% plot(t1,acc1);
% hold on;
% plot(t2,acc2);