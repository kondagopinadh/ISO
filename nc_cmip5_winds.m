G:\gopi\CMIP5_Daily\CMCC-CMS

I:\Colleaques\GopiNadh\winds

clear
clc;
u_pwd=('NCEP_vwnd_day_850hPa_1948-2017.nc');
ncdisp(u_pwd);
%%
u1=ncread(u_pwd,'v850');
lon=ncread(u_pwd,'lon');
lat=ncread(u_pwd,'lat');
% u1=squeeze(u(:,:,2,:));
contourf(lon,lat,u1(:,:,3)','levelstep',1,'LineStyle','none');
hold on;
ss=load('coast');
plot(ss.long,ss.lat,'-k','linewidth',2);
colormap jet;

 %% Time Adjustment %%%%%
nt=datetime(1948,01,01);
tttt=datetime(2017,12,31);
aaaa=nt:tttt;
aaaa=datevec(aaaa);
% t=aaaa;

% ind=find(aaaa(:,2)==2 & aaaa(:,3)==29);
% aaaa(ind,:)=[];
t=aaaa;
f1=find(t(:,1)>=1980 & t(:,1)<=2005);
t3=t(f1,:);
time=datenum(t3);
u_850=u1(:,:,f1);

%  %%  nc creation %%%%%%
ncid = netcdf.create('M_v_NCEP_850hPa_19800101-20051231.nc','CLOBBER');
    dimid_lon = netcdf.defDim(ncid,'lon',length(lon));
    dimid_lat = netcdf.defDim(ncid,'lat',length(lat));
    dimid_time = netcdf.defDim(ncid,'time',length(time));

    varid1 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimid_lon);
    varid2 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimid_lat);
    varid3 = netcdf.defVar(ncid,'time','NC_DOUBLE',dimid_time);
    varid4 = netcdf.defVar(ncid,'u','double',[dimid_lon dimid_lat dimid_time]);

    netcdf.endDef(ncid);
 
    netcdf.putVar(ncid,varid1,lon);
    netcdf.putVar(ncid,varid2,lat);
    netcdf.putVar(ncid,varid3,time);
    netcdf.putVar(ncid,varid4,u_850);
  
    netcdf.reDef(ncid);
    netcdf.putAtt(ncid,varid1,'units','degrees_east');
    netcdf.putAtt(ncid,varid2,'units','degrees_north');
    netcdf.putAtt(ncid,varid3,'units','day');
    netcdf.putAtt(ncid,varid4,'units','m/sec');
       
    netcdf.close(ncid);

    %%%%%%%   V wind   
    
    %%
    clc;
    clear;    
    v_pwd=('Va_1000hPa_Nor-ESM1-M_19500101-20051231.nc');
    ncdisp(v_pwd);
%%
v1=ncread(v_pwd,'v1000');
lon=ncread(v_pwd,'lon');
lat=ncread(v_pwd,'lat');
% lev=ncread(v_pwd,'plev');
% v1=squeeze(v(:,:,2,:));

contourf(lon,lat,v1(:,:,3)','levelstep',1,'LineStyle','none');
hold on;
ss=load('coast');
plot(ss.long,ss.lat,'-k','linewidth',2);
colormap jet;

%% Time Adjustment %%%%%
nt=datetime(1950,01,01);
tttt=datetime(2005,12,31);
aaaa=nt:tttt;
aaaa=datevec(aaaa);
% t=aaaa;

ind=find(aaaa(:,2)==2 & aaaa(:,3)==29);
aaaa(ind,:)=[];
t=aaaa;
f1=find(t(:,1)>=1980 & t(:,1)<=2005);
t3=t(f1,:);
time=datenum(t3);
v_850=v1(:,:,f1);

% %%  nc creation %%%%%%

ncid = netcdf.create('M_V_1000hPa_Nor-ESM1-M_19800101-20051231.nc','CLOBBER');
    dimid_lon = netcdf.defDim(ncid,'lon',length(lon));
    dimid_lat = netcdf.defDim(ncid,'lat',length(lat));
    dimid_time = netcdf.defDim(ncid,'time',length(time));

    varid1 = netcdf.defVar(ncid,'lon','NC_DOUBLE',dimid_lon);
    varid2 = netcdf.defVar(ncid,'lat','NC_DOUBLE',dimid_lat);
    varid3 = netcdf.defVar(ncid,'time','NC_DOUBLE',dimid_time);
    varid4 = netcdf.defVar(ncid,'v','double',[dimid_lon dimid_lat dimid_time]);

    
    netcdf.endDef(ncid);
 
    netcdf.putVar(ncid,varid1,lon);
    netcdf.putVar(ncid,varid2,lat);
    netcdf.putVar(ncid,varid3,time);
    netcdf.putVar(ncid,varid4,v_850);
  
    netcdf.reDef(ncid);
    netcdf.putAtt(ncid,varid1,'units','degrees_east');
    netcdf.putAtt(ncid,varid2,'units','degrees_north');
    netcdf.putAtt(ncid,varid3,'units','day');
    netcdf.putAtt(ncid,varid4,'units','m/sec');
       
    netcdf.close(ncid);


%%

clear
clc

pwd=('Re_M_U_850hPa_ACCESS1-0_19800101-20041229.nc');
ncdisp(pwd);

t=ncread(pwd,'TIME');
t1=datevec(t);
u=ncread(pwd,'U_850');
lon=ncread(pwd,'XFNR');
lat=ncread(pwd,'YFNR');

contourf(lon,lat,u(:,:,3)','levelstep',1,'LineStyle','none');
hold on;
ss=load('coast');
plot(ss.long,ss.lat,'-k','linewidth',2);
colormap jet;
