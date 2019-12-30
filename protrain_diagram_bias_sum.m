clc
clear

names=({'ACCESS1.0','ACCESS1.3','CanESM2','CMCC-CESM','CMCC-CMS','CNRM-CM5','GFDL-CM3',...
    'GFDL-ESM2G','GFDL-ESM2M','INM-CM4','IPSL-CM5A-LR','IPSL-CM5A-MR','IPSL-CM5B-LR',...
    'MIROC5','MIROC-ESM-CHEM','MIROC-ESM1','MPI-ESM-LR','MPI-ESM-MR','MPI-ESM-P','MRI-CGCM3',...
    'MRI-ESM1','NorESM1-M'})';

scrsz = get(0,'ScreenSize');
scr=figure('Color',[1 1 1],'Position',[1 1 scrsz(4) scrsz(3)]);
%% Wh ind
subtightplot(5,1,1,[0.04 0.06],[0.05 0.05], [0.09 0.09]);
a=load('J:\plotting\lead_lag_Regress\wh_Ind\significant\pcorr\pcorr_WhIND_PULSR-60-100.txt');
a1=a';
a1=a1(1:end,:);
imagesc(a1)
caxis([-0.4 1]);
set(gca,'XTick',[1:1:22],'XTickLabel',[]);
set(gca,'YTicklabel',{'PRCP','U850','LHF','SST','DSSR'},'YTick',[1:1:5])
set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
colormap jet
text(1,0,'(a) Wh Ind','FontSize',20,'Fontweight','Bold');

b=load('J:\plotting\lead_lag_Regress\wh_Ind\significant\pcorr\bias_WhIND_PULSR_60-100.txt');
b1=b';
b1=b1(1:end,:);
b1=b1';
for i=1:22
    for j=1:5
        c=round(b1(i,j),1)
        h=text(i,j,num2str(c),'color','k');
        set(h,'Rotation',45,'position',get(h,'position')-[0.28 -0.26 0]);   

    end
end
%%  as
subtightplot(5,1,2,[0.04 0.06],[0.05 0.05], [0.09 0.09]);
a=load('J:\plotting\lead_lag_Regress\AS\significant\pcorr\pcorr_as_PULSR.txt');
a1=a';
a1=a1(1:end,:);
imagesc(a1)
caxis([-0.4 1]);
set(gca,'XTick',[1:1:22],'XTickLabel',[]);
set(gca,'YTicklabel',{'PRCP','U850','LHF','SST','DSSR'},'YTick',[1:1:5])
set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
colormap jet
text(1,0,'(b) AS','FontSize',20,'Fontweight','Bold');

b=load('J:\plotting\lead_lag_Regress\AS\significant\pcorr\bias_as_PULSR.txt');
b1=b';
b1=b1(1:end,:);
b1=b1';
for i=1:22
    for j=1:5
        c=round(b1(i,j),1)
        h=text(i,j,num2str(c),'color','k');
        set(h,'Rotation',45,'position',get(h,'position')-[0.28 -0.26 0]);   

    end
end

%% bob
a=load('J:\plotting\lead_lag_Regress\BoB\significant\pcorr\pcorr_BoB_PULSR.txt');
a1=a';
a1=a1(1:end,:);
subtightplot(5,1,3,[0.04 0.06],[0.07 0.05], [0.09 0.09]);
imagesc(a1)
caxis([-0.4 1]);
set(gca,'XTick',[1:1:22],'XTickLabel',[]);
set(gca,'YTicklabel',{'PRCP','U850','LHF','SST','DSSR'},'YTick',[1:1:5])
set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
colormap jet
text(1,0,'(c) BoB','FontSize',20,'Fontweight','Bold');

b=load('J:\plotting\lead_lag_Regress\BoB\significant\pcorr\bias_BoB_PULSR.txt');
b1=b';
b1=b1(1:end,:);
b1=b1';
for i=1:22
    for j=1:5
        c=round(b1(i,j),1)
        h=text(i,j,num2str(c),'color','k');
        set(h,'Rotation',45,'position',get(h,'position')-[0.28 -0.26 0]);   

    end
end

%% sci
a=load('J:\plotting\lead_lag_Regress\IND\significant\pcorr\pcorr_SCI_PULR.txt');
a1=a';
a1=a1(1:end,:);
subtightplot(5,1,4,[0.04 0.06],[0.07 0.05], [0.09 0.09]);imagesc(a1)
colormap((brewermap([14],'RdBu')));
caxis([-0.4 1]);
set(gca,'XTick',[1:1:22],'XTickLabel',[]);
set(gca,'YTicklabel',{'PRCP','U850','LHF','SST','DSSR'},'YTick',[1:1:5])
set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
colormap jet
text(1,0,'(d) SCI','FontSize',20,'Fontweight','Bold');

b=load('J:\plotting\lead_lag_Regress\IND\significant\pcorr\bias_SCI_PULR.txt');
b1=b';
b1=b1(1:end,:);
b1=b1';
for i=1:22
    for j=1:4
        c=round(b1(i,j),1)
        h=text(i,j,num2str(c),'color','k');
        set(h,'Rotation',45,'position',get(h,'position')-[0.28 -0.26 0]);   

    end
end

set(gca,'YTicklabel',{'PRCP','U850','LHF','DSSR'},'YTick',[1:1:5])
set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
colormap jet

ti=({'ACCESS1.0','ACCESS1.3','CanESM2','CMCC-CESM','CMCC-CMS','CNRM-CM5','GFDL-CM3',...
    'GFDL-ESM2G','GFDL-ESM2M','INM-CM4','IPSL-CM5A-LR','IPSL-CM5A-MR','IPSL-CM5B-LR',...
    'MIROC5','MIROC-ESM-CHEM','MIROC-ESM','MPI-ESM-LR','MPI-ESM-MR','MPI-ESM-P','MRI-CGCM3',...
    'MRI-ESM1','NorESM1-M'})';

set(gca,'XTick',[1:1:22],'XTickLabel',ti);
xtickangle(45)


cbh=colorbar('v');
set(cbh,'YTicklabel',[-0.4:0.1:1],'YTick',[-0.4:0.1:1])
set(cbh, 'Position',[.92 .37 .02 .5],'FontSize',20,'Fontweight','normal','TickDir','In');

% print(1,'-dtiff','sig_Pattern_corr_potrait_4regions_bias_sum.tif','-r300');