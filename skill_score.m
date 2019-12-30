function [vsc, la,lb, rmsvd, sv1, sv2, bss, sdr, cr]=skill_score(lon,lat,n,a,b)

md1=a;
md2=b;

up=zeros(length(lon),length(lat));
bt=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
         a1=squeeze(md1(i,j,:));
         b1=squeeze(md2(i,j,:));
         a12=(abs(a1)).^2;
         b12=(abs(b1)).^2;
         ac=a1.*b1;
         up(i,j)=sum(ac); 
         
         b1=sqrt(sum(a12));
         b2=sqrt(sum(b12));
         bt(i,j)=b1*b2;
     end
end
vsc=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
        vsc(i,j)=up(i,j)/bt(i,j);
    end
end


%%  %%%%%%%%%%%% LA %  and LB %%%%%%%%%
clearvars -except lon lat md1 md2 time vsc n
la=zeros(length(lon),length(lat));
lb=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
         a1=squeeze(md1(i,j,:));
         a12=(abs(a1)).^2;
         b1=squeeze(md2(i,j,:));
         b12=(abs(b1)).^2;
         a13=sqrt(sum(a12)/n);
         b13=sqrt(sum(b12)/n);
         la(i,j)=a13;
         lb(i,j)=b13;
    end
end

%% %%%%% RMSVD %%%%%%%
clearvars -except lon lat md1 md2 time la lb vsc n
rmsvd=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
        a1=squeeze(md1(i,j,:));
        b1=squeeze(md2(i,j,:));
        rmsvd(i,j)=(sum((a1-b1).^2))/n;        
    end
end


%%  sv1 %%%%%%%%%
clearvars -except lon lat md1 md2 time la lb vsc rmsvd n
sv1=zeros(length(lon),length(lat));
up=zeros(length(lon),length(lat));
bt=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
        a=4*(1+vsc(i,j));
        up(i,j)=a;
        b=(1+1)*(((la(i,j)/lb(i,j))+(lb(i,j)/la(i,j)))^2);
        bt(i,j)=b;
        sv1(i,j)=a/b;
    end
end

%%  sv2 %%%%%%%%%
clearvars -except lon lat md1 md2 time la lb vsc rmsvd sv1 n
sv2=zeros(length(lon),length(lat));
up=zeros(length(lon),length(lat));
bt=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
        a=4*((1+vsc(i,j))^4);
        up(i,j)=a;
        b=((1+1)^4)*(((la(i,j)/lb(i,j))+(lb(i,j)/la(i,j)))^2);
        bt(i,j)=b;
        sv2(i,j)=a/b;
    end
end

%%  bss %%%%%%%%%
clearvars -except lon lat md1 md2 time la lb vsc rmsvd sv1 sv2 n
sdr=zeros(length(lon),length(lat));
cr=zeros(length(lon),length(lat));
bss=zeros(length(lon),length(lat));
for i=1:length(lon)
    for j=1:length(lat)
      aa=squeeze(md1(i,j,:));
      bb=squeeze(md2(i,j,:)); 
      cr(i,j)=nancorr(aa,bb);
      sdr(i,j)=std(bb)/std(aa);
      up=4*(1+cr(i,j))^4;
      bt=((sdr(i,j)+(1/sdr(i,j)))^2) * (1+1)^4;
      bss(i,j)=up/bt; 
    end
end
end