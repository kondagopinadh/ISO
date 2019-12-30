
function varargout = crosscorr_s(st,pr,numLags,numSTD)


%%% example format
        % [x11 x22]=crosscorr_s(st,pr,30,0);
%%%% st=st(year, month, day,value);
%%%% pr=pr(year, month, day,value);

L=numLags;
S=numSTD;

aa=[st(:,4) pr(:,4)];
% SST leads Precip (Precip lags SST)
x=[1:1:L]';

for kk=1:length(x)
    a1=aa(1:length(aa(:,1))-x(kk),1);
    a2=aa((1+x(kk)):length(aa(:,1)),2);
    bb=[a1 a2];
    cc(kk,:)=[-x(kk) corr(a1,a2)];
end

% Precip Leads SST (SST lags Precip)

x1=[0:1:L]';

for kk=1:length(x1)
    a1=aa(1:length(aa(:,1))-x1(kk),2);
    a2=aa((1+x1(kk)):length(aa(:,1)),1);
    bb=[a1 a2];
    cc1(kk,:)=[x1(kk) corr(a1,a2)];
end

CC=sortrows([sortrows(cc1,-1);cc],1);

numSTD=S; %default
N=length(a1);
% 
bounds = [numSTD;-numSTD]/sqrt(N);
% b1(1:length(CC(:,1)))=bounds(1);
% b2(1:length(CC(:,1)))=bounds(2);
% 
% figure
% plot(CC(:,1),CC(:,2))
% ylim([-1 1])
% 
% % hold on
% % plot(CC(:,1),b1,'-r','linewidth',1.5);
% % plot(CC(:,1),b2,'-r','linewidth',1.5);
% 
varargout = {CC,bounds};

end


