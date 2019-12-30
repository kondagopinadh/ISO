clc
clear
names=({'GPCP','ACCESS1.0','ACCESS1.3','CanESM2','CMCC-CESM','CMCC-CMS','CNRM-CM5','GFDL-CM3',...
    'GFDL-ESM2G','GFDL-ESM2M','INM-CM4','IPSL-CM5A-LR','IPSL-CM5A-MR','IPSL-CM5B-LR',...
    'MIROC5','MIROC-ESM-CHEM','MIROC-ESM1','MPI-ESM-LR','MPI-ESM-MR','MPI-ESM-P','MRI-CGCM3',...
    'MRI-ESM1','NorESM1-M'})';

ti=({'(a) Observations','(b) ACCESS1.0','(c) ACCESS1.3','(d) CanESM2','(e) CMCC-CESM','(f) CMCC-CMS','(g) CNRM-CM5','(h) GFDL-CM3',...
    '(i) GFDL-ESM2G','(j) GFDL-ESM2M','(k) INM-CM4','(l) IPSL-CM5A-LR','(m) IPSL-CM5A-MR','(n) IPSL-CM5B-LR',...
    '(o) MIROC5','(p) MIROC-ESM-CHEM','(q) MIROC-ESM','(r) MPI-ESM-LR','(s) MPI-ESM-MR','(t) MPI-ESM-P','(u) MRI-CGCM3',...
    '(v) MRI-ESM1','(w) NorESM1-M'})';
%%
scrsz = get(0,'ScreenSize');
scr=figure('Color',[1 1 1],'Position',[1 1 scrsz(4) scrsz(3)]);
kkk=1;
% pindex=load('J:\Data\Models_CMIP5\indexes\EQIO_SLon_prcp_aave_GPCP.txt');
pindex=load('J:\Data\Models_CMIP5\indexes\IND_SLat_prcp_aave_GPCP.txt');
%%%%%%%%%  MCONV %%%%%%%%%%%%
mp=('J:\Data\Models_CMIP5\winds\u850\bpf_u850\JJAS_files\');
ofile=[mp,'M_Re_Ind_JJAS_U850_filt_NCEP_1980-2005.mat'];
ol=load(ofile);
olr=ol.u850;
olon=ol.lon;
olat=ol.lat;
otime=ol.time;

f1=find(otime(:,2)>=6 & otime(:,2)<=9 & otime(:,1)>=1997 & otime(:,1)<=2005);
ot2=otime(f1,:);
olr1=olr(:,:,f1);
    
 aln=63; bln=73; alt=-10; blt=30;
     f_lon=[]; f_lat=[];
     f_lon=find(olon(:,1)>=aln & olon(:,1)<=bln);
     f_lat=find(olat(:,1)>=alt & olat(:,1)<=blt);
     olon3=olon(f_lon);
     olat3=olat(f_lat);
     olr3=olr1(f_lon,f_lat,:);
              
        sss=[];
        for i=1:length(ot2)
            d1=olr3(:,:,i);
            dd=nanmean(d1);
            dd=dd;
            sss=[sss;dd];
        end
           sss=sss;
           
      lag1=sort((-30:1:30),'descend')';
      lag=sort(-30:1:30)';
      am=[];
      for i=1:length(olat3)
        for kk=1:61
            a=[];
            a=lagmatrix(sss(:,i),lag(kk));
            cc=[a(:,1),pindex(:,4)];
      cc(cc<=-3)=NaN;
      cc(cc>=3)=NaN;      
      f1=find(isnan(cc(:,1))<1);
      cc=cc(f1,:);
      f1=find(isnan(cc(:,2))<1);
      cc=cc(f1,:);
       mss1(i,kk)=regress(a(:,1),pindex(:,4));
            [h(i,kk),p(i,kk)]=ttest2(cc(:,1),cc(:,2),'Alpha',0.05);
        end
      end
      
      mss1(mss1<0.05 & mss1>-0.05)=NaN;
olrr=mss1;
olrr=smooth2a(olrr,1,1);

%%%%%%%%  PRCP  %%%%%%%%%%%%%
pp=('J:\Data\Models_CMIP5\prcp\daily_data\BPF_PRCP\bpf8005\jjas_files\');
pfile=[pp,'M_Re_Ind_JJAS_PRCP_filt_GPCP_1997-2005.mat'];
pd=load(pfile);
pr=pd.jjas_pr;
plon=pd.lon;
plat=pd.lat;
ptime=pd.time;

f1=find(ptime(:,2)>=6 & ptime(:,2)<=9 & ptime(:,1)>=1997 & ptime(:,1)<=2005);
pt2=ptime(f1,:);
pr1=pr(:,:,f1);
           
     f_lon=[]; f_lat=[];
     f_lon=find(plon(:,1)>=aln & plon(:,1)<=bln);
     f_lat=find(plat(:,1)>=alt & plat(:,1)<=blt);
     plon3=plon(f_lon);
     plat3=plat(f_lat);
     pr3=pr1(f_lon,f_lat,:);
           
           rr=[];
        for i=1:length(pt2)
            d1=pr3(:,:,i);
            dd=nanmean(d1);
            dd=dd;
            rr=[rr;dd];
        end
           rr=rr;      
            
      lag1=sort((-30:1:30),'descend')';
      lag=sort(-30:1:30)';
      am=[];p=[]; h=[];
      for i=1:length(plat3)
        for kk=1:61
            a=[];
            a=lagmatrix(rr(:,i),lag(kk));%            
      cc=[a(:,1),pindex(:,4)];
      cc(cc<=-3)=NaN;
      cc(cc>=3)=NaN;      
      f1=find(isnan(cc(:,1))<1);
      cc=cc(f1,:);
      f1=find(isnan(cc(:,2))<1);
      cc=cc(f1,:);
       rss1(i,kk)=regress(a(:,1),pindex(:,4));       
            [h(i,kk),p(i,kk)]=ttest2(cc(:,1),cc(:,2),'Alpha',0.05);
        end
      end  
      rss1(rss1<0.05 & rss1>-0.05)=NaN;
pppp=rss1;
pppp=smooth2a(pppp,3,3);
subtightplot(6,4,kkk,[0.05 0.06],[0.07 0.05], [0.05 0.09]);
contourf(lag1,plat3,pppp,'levelstep',0.01,'LineStyle','none');
colormap((brewermap([80],'BrBg')));
caxis([-0.8 0.8]); 
hold on p
levels=[0.1 0.3 0.5 0.7]';
levels1=[-0.1 -0.3 -0.5 -0.7]';
[c h]=contour(lag1,olat3,olrr,levels,'-b','linewidth',1.2);
clabel(c,h,'FontSize',8,'Color','b','labelspacing',700)
[c h]=contour(lag1,olat3,olrr,levels1,'-k','linewidth',1.2);
clabel(c,h,'FontSize',8,'Color','k','labelspacing',700)
set(gca,'YTick',[alt:10:blt],'YTickLabel',{alt:10:blt});
set(gca,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',{'-30','-20','-10','0','10','20','30'});
set(gca,'LineWidth',1,'FontSize',12,'Fontweight','Bold','TickDir','In');
 ylim([alt blt]) 
tickdegree_y;
tt=[];
tt=title(['\fontsize{12}\color{red}' ti{kkk}]);
set(tt,'position',get(tt,'position')-[10 1.0 0])
% xlabel('<-- lag/lead -->','FontSize',10,'Fontweight','normal','position',[3 -16.5 3]);
xlabel('<-- days -->','FontSize',10,'Fontweight','normal','position',[1 -16.5 3]);
  grid on
  h=colorbar;
set(h, 'Position',[.93 .212 .01 .6],'FontSize',16,'Fontweight','normal','TickDir','In');

  %%
 pin=('J:\Data\Models_CMIP5\indexes\');
for kkk=2:length(names)
     clearvars -except files names kkk ti scr mp pp pin aln bln alt blt
x=names{kkk}
pind=dir([pin,'IND', '*' x '*' '.txt']);
pf=[pin,pind.name];
pindex=load(pf);
f2=find(pindex(:,1)>=1980 & pindex(:,1)<=2004);
pindex=pindex(f2,:);

ofiles=dir([mp, '*' x '*' '.mat']);
ofile=[mp,ofiles.name];
ol=load(ofile);
olr=ol.u850;
olon=ol.lon;
olat=ol.lat;
otime=ol.time;

f1=find(otime(:,2)>=6 & otime(:,2)<=9 & otime(:,1)>=1980 & otime(:,1)<=2004);
ot2=otime(f1,:);
olr1=olr(:,:,f1);
     
     f_lon=[]; f_lat=[];
     f_lon=find(olon(:,1)>=aln & olon(:,1)<=bln);
     f_lat=find(olat(:,1)>=alt & olat(:,1)<=blt);
     olon3=olon(f_lon);
     olat3=olat(f_lat);
     olr3=olr1(f_lon,f_lat,:);
              
        sss=[];
        for i=1:length(ot2)
            d1=olr3(:,:,i);
            dd=nanmean(d1);
            dd=dd;
            sss=[sss;dd];
        end
           sss=sss;
           
      lag1=sort((-30:1:30),'descend')';
      lag=sort(-30:1:30)';
      am=[];
      for i=1:length(olat3)
        for kk=1:61
            a=[];
            a=lagmatrix(sss(:,i),lag(kk));
             cc=[a(:,1),pindex(:,4)];
      cc(cc<=-3)=NaN;
      cc(cc>=3)=NaN;      
      f1=find(isnan(cc(:,1))<1);
      cc=cc(f1,:);
      f1=find(isnan(cc(:,2))<1);
      cc=cc(f1,:);
       mss1(i,kk)=regress(a(:,1),pindex(:,4));
            [h(i,kk),p(i,kk)]=ttest2(cc(:,1),cc(:,2),'Alpha',0.05);
        end
      end
      
      mss1(mss1<0.05 & mss1>-0.05)=NaN;
olrr=mss1;

olrr=smooth2a(olrr,3,3);

%%%%%%%%%  PRCP %%%%%%%%%%%%%
pfiles=dir([pp, '*' x '*' '.mat']);
pfile=[pp,pfiles.name];
pd=load(pfile);
pr=pd.jjas_pr;
plon=pd.lon;
plat=pd.lat;
ptime=pd.time;

f1=find(ptime(:,2)>=6 & ptime(:,2)<=9 & ptime(:,1)>=1980 & ptime(:,1)<=2004);
pt2=ptime(f1,:);
pr1=pr(:,:,f1);
           
     f_lon=[]; f_lat=[];
     f_lon=find(plon(:,1)>=aln & plon(:,1)<=bln);
     f_lat=find(plat(:,1)>=alt & plat(:,1)<=blt);
     plon3=plon(f_lon);
     plat3=plat(f_lat);
     pr3=pr1(f_lon,f_lat,:);
           
           rr=[];
        for i=1:length(pt2)
            d1=pr3(:,:,i);
            dd=nanmean(d1);
            dd=dd;
            rr=[rr;dd];
        end
           rr=rr;      
            
      lag1=sort((-30:1:30),'descend')';
      lag=sort(-30:1:30)';
      am=[];
      for i=1:length(plat3)
        for kk=1:61
            a=[];
            a=lagmatrix(rr(:,i),lag(kk));
            cc=[a(:,1),pindex(:,4)];
      cc(cc<=-3)=NaN;
      cc(cc>=3)=NaN;      
      f1=find(isnan(cc(:,1))<1);
      cc=cc(f1,:);
      f1=find(isnan(cc(:,2))<1);
      cc=cc(f1,:);
       rss1(i,kk)=regress(a(:,1),pindex(:,4));       
            [h(i,kk),p(i,kk)]=ttest2(cc(:,1),cc(:,2),'Alpha',0.05);
        end
      end  
         rss1(rss1<0.05 & rss1>-0.05)=NaN;
pppp=rss1;
pppp=smooth2a(pppp,3,3);

subtightplot(6,4,kkk,[0.05 0.06],[0.07 0.05], [0.05 0.09]);
contourf(lag1,plat3,pppp,'levelstep',0.01,'LineStyle','none');
colormap((brewermap([80],'BrBg')));
caxis([-0.6 0.6]); 
hold on 
levels=[0.1 0.3 0.5 0.7]';
levels1=[-0.1 -0.3 -0.5 -0.7]';
[c h]=contour(lag1,olat3,olrr,levels,'-b','linewidth',1.2);
clabel(c,h,'FontSize',8,'Color','b','labelspacing',700)
[c h]=contour(lag1,olat3,olrr,levels1,'-k','linewidth',1.2);
clabel(c,h,'FontSize',8,'Color','k','labelspacing',700)
set(gca,'YTick',[alt:10:blt],'YTickLabel',{alt:10:blt});
set(gca,'XTick',[-30 -20 -10 0 10 20 30],'XTickLabel',{'-30','-20','-10','0','10','20','30'});
set(gca,'LineWidth',1,'FontSize',12,'Fontweight','Bold','TickDir','In');
 ylim([alt blt]) 
tickdegree_y;
tt=[];
tt=title(['\fontsize{12}\color{red}' ti{kkk}]);
set(tt,'position',get(tt,'position')-[10 1.2 0])
% xlabel('<-- lag/lead -->','FontSize',10,'Fontweight','normal','position',[3 -16.5 3]);
xlabel('<-- days -->','FontSize',10,'Fontweight','normal','position',[1 -16.5 3]);
  grid on
end

% h=colorbar;
% set(h, 'Position',[.93 .212 .01 .6],'FontSize',16,'Fontweight','normal','TickDir','In');
  % print(1,'-dtiff','sig_dpi_Regress_AS_lag_lat_PRCP_U850C_600dpi.tif','-r600');
  