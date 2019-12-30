function [sdr,cr,gss] = untitled2(lon,lat,ob,md)
ln=length(lon);
lt=length(lat);
md1=ob;
md2=md;
sdr=zeros(length(lon),length(lat));
cr=zeros(length(lon),length(lat));
gss=zeros(length(lon),length(lat));
for i=1:lt
    for j=1:ln
      aa=squeeze(md1(i,j,:));
      bb=squeeze(md2(i,j,:)); 
      cr(i,j)=nancorr(aa,bb);
      sdr(i,j)=std(bb)/std(aa);
      up=4*(1+cr(i,j))^4;
      bt=((sdr(i,j)+(1/sdr(i,j)))^2) * (1+1)^4;
      gss(i,j)=up/bt; 
    end
end
end