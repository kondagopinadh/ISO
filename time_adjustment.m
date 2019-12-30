clc
clear

file=('a_hfls_day_MIROC5_historical_r1i1p1_19500101-20051231.nc');
ncdisp(file);

t1=datetime(1950,01,01);
t2=datetime(2009,12,31);
t3=t1:t2;
t3=datevec(t3);
ind=find(t3(:,2)==2 & t3(:,3)==29);
t3(ind,:)=[];

find