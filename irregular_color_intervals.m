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

pindex=load('J:\Data\Models_CMIP5\indexes\IND_SLat_prcp_aave_GPCP.txt');

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
 aln=63; bln=73; alt=-10; blt=30;
           
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
            rss1(i,kk)=regress(a(:,1),pindex(:,4));
        end
      end  
pppp=rss1;


%%
x1=[1:13]';
y1=[1:13]';
 TT=pppp;
y22 = 1:16;  
x22=[-0.8 -0.7 -0.6 -0.5,-0.4,-0.3,-0.2,-0.1,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8];
    t3=TT';
    dtr = t3;
    dtr(:) = interp1(x22,y22,t3(:),'pchip');
contourf(lag1,plat3,dtr','levelstep',0.01,'LineStyle','none');
hold on
colormap((brewermap([15],'BrBg')));
caxis([1 16])

h1 = colorbar;
% set(cblh,'ytick',1:21)
set(h1,'ytick',1:16,'yticklabel',num2str(x22'))
% set(cblh, 'Position', [.95 .14 .015 .72])
set(h1,'Position',[.93 .212 .01 .6],'FontSize',16,'Fontweight','normal','TickDir','In');
% cbarrow