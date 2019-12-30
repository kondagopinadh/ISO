function get_any_hycom_data(data_url,variable,start,depth,model_bbox,temp_stride,numdays,savename)
% get_any_hycom_data(data_url,variable,start,depth,model_bbox,temp_stride,numdays,save_name)
% ONLY WORKS WITH HYCOM GOM AND HYCOM GLOBAL!! 
%
% use ncdisp(data_url) to confirm everything is looking good (variable names, units etc),
% e.g. time used to be in days and now is in hours, so I had to divide time vector by 24 
% to return back to days.
% 
% if your variable is a surface variable i.e. has no depth, pass depth=[] an
% empty array; if your variable has depth and you would like it at the
% surface use depth=0;
% Otherwise use depth=[shallow deep]; it will return all depths between
% shallow and deep. Note that you will need to download variables without depth (like SSH) 
% separately (i.e. they will have their own file).
%
% Data is saved as a mat file, see get_data_nco for a ncks example that saves a
% netcdf file
%
% Select your region of interest using 
% model_bbox=[minLon maxLon minLat maxLat];
% start is a string for the start date in format 'yyyy-mm-dd' so time will
% start at first record for that day
% data will be saved as savename_yyyymmdd.mat
% Some possible urls
% http://hycom.org/data/goml0pt04/expt-02pt2  01/1992 through 12/2002
%
% http://hycom.org/data/goml0pt04/expt-20pt1  01/2003 through 12/2009
% data_url='http://tds.hycom.org/thredds/dodsC/GOMl0.04/expt_20.1';
% http://hycom.org/data/goml0pt04/expt-31pt0  01/2010 through 03/2014
% data_url='http://tds.hycom.org/thredds/dodsC/GOMl0.04/expt_31.0/hrly'
% http://hycom.org/data/goml0pt04/expt-32pt5  04/2014 to 03/2019
% data_url='http://tds.hycom.org/thredds/dodsC/GOMl0.04/expt_32.5/hrly';
% https://www.hycom.org/data/gomu0pt04/expt-90pt1m000  01/01/2019 to date
% data_url='http://tds.hycom.org/thredds/dodsC/GOMu0.04/expt_90.1m000/data/hindcasts/2019';
% data_url='http://tds.hycom.org/thredds/dodsC/GOMu0.04/expt_90.1m000';
% see also:
% http://tds.hycom.org/thredds/catalog.html
%
% For HyCOM Global URL-examples are:
% HyCOM Global 22 year reanalysis, 1994--2015; so for year 2015 use:
% data_url='http://tds.hycom.org/thredds/dodsC/GLBv0.08/expt_53.X/data/2015';
% More recent (2018--present) HyCOM Global data:
% data_url='http://tds.hycom.org/thredds/dodsC/GLBv0.08/expt_93.0/uv3z'
%
%   % EXAMPLE BLOSOM data:
%   clearvars
%   data_url='http://tds.hycom.org/thredds/dodsC/GOMl0.04/expt_32.5/hrly'; %Apr-01-2014 to Present
%   % ncdisp(data_url)  %use this to get info if needed
%   save_name='BLOSOM';
%   variable={'u','v','temperature','salinity','w_velocity'};
%   model_bbox=[-98,-86,25,30.7]; %for brutus
%   temp_stride=12;% data is hourly, I want one every 12 hours
%   numdays=7*(24/temp_stride); % number of records to download, use inf
%   for all records.
%   start='2017-04-05';
%   depth=[0 5];
%   get_any_hycom_data(data_url,variable,start,depth,model_bbox,temp_stride,numdays,save_name)
%   
% EXAMPLE Tiger tail
% data_url='http://tds.hycom.org/thredds/dodsC/GOMl0.04/expt_31.0/hrly';
% variable={'u','v'};
% model_bbox=[-98,-80,18,30.7];
% temp_stride=3;
% numdays=8*(24/temp_stride);
% start='2010-05-10';
% depth=0;
% save_name='hycom_GoM_05102010_05172010';
%
%   % EXAMPLE: 2019 -- data for past days in GoM including any available forecasts:
%   data_url='http://tds.hycom.org/thredds/dodsC/GOMu0.04/expt_90.1m000/data/hindcasts/2019';
%   past_days=5; 
%   start=datestr(now-past_days,29);
%   variable={'water_u','water_v'};
%   model_bbox=[-98,-81,18.1,30.5];% for sargazo use model_bbox=[-98,-80,14,23];
%   temp_stride=1; %hourly
%   numdays=past_days*(24/temp_stride); % number of records to download, use inf
%   depth=0;
%   numdays=inf;%everything up to most recent
%   savename=['hycom_GoM_past_',num2str(past_days),'days'];
%   get_any_hycom_data(data_url,variable,start,depth,model_bbox,temp_stride,numdays,savename)
%
% for another example 
% see also get_hycom_global


ticini=tic;
try %hycom GoM
lon=ncread(data_url,'Longitude');
lat=ncread(data_url,'Latitude');
catch %hycom global or hycom GoM expt 90.1
lon=ncread(data_url,'lon');
lat=ncread(data_url,'lat');
end
%Given a bounding box, get the indexes of interest
%Determine the bounding box indexes.
    % latitude lower and upper index
[~,latli] = min( abs( lat - model_bbox(3) ) );
[~,latui] = min( abs( lat - model_bbox(4) ) );
    % longitude lower and upper index
[~,lonli] = min( abs( lon - model_bbox(1) ) );
[~,lonui] = min( abs( lon - model_bbox(2) ) );

numlon=lonui-lonli+1;
numlat=latui-latli+1;

try %hycom GoM
lon = ncread(data_url,'Longitude',lonli,numlon);
lat = ncread(data_url,'Latitude',latli,numlat);
catch %hycom global
lon=ncread(data_url,'lon',lonli,numlon);
lat=ncread(data_url,'lat',latli,numlat);
end

% try
try
time = ncread(data_url,'MT'); %days since 1900-12-31 00:00:00; could be hours depending on data, in which case divided by 24 to get days
days=datestr(time+datenum('1900-12-31','yyyy-mm-dd'),29);%convert to 
%matlab datenum and then to datestr
catch %hycom global or hycom GoM expt 90.1
time = ncread(data_url,'time')/24; %hours since 2000-01-01 00:00:00  divided by 24 to get days
days=datestr(time+datenum('2000-01-01','yyyy-mm-dd'),29);%convert to 
%matlab datenum and then to datestr
end
% catch
%     warning('could not download variable time, will continue without')
% end

for kk=1:size(days,1)
if strcmp(start,days(kk,:))
ind=kk;
break,
end
end

yyyy=(days(ind,1:4));%
mm=(days(ind,6:7));%
dd=(days(ind,9:10));%

if ~isempty(depth)  %WITH DEPTH ================================================================================
% now depth
try
z = ncread(data_url,'Depth');
catch
z = ncread(data_url,'depth');
end
[~,depthi] = min( abs( z - abs(depth) ) ); %abs(depth) because hycom uses positive depth
depth=z(depthi);
    tic
    disp('================================================')
    disp(['About to download data for the following variables, data starting on ',num2str(yyyy),'-',num2str(mm),'-',num2str(dd)])
for kk=1:length(variable)
    disp(variable{kk})
    ut=ncread(data_url,variable{kk},...
    [lonli latli depthi(1)  ind],... %start
    [numlon numlat depthi(end) numdays],...%count=total elements to download
    [1 1 1 temp_stride]);%stride
ut=squeeze(ut);
data.(variable{kk})=ut;
end

note{1}=['Data-file created with ',mfilename('fullpath'),'.m with data from ',data_url,' on ',date];
note{2}=model_bbox;
try
time = ncread(data_url,'MT',ind,numdays,temp_stride)/24;
days=datestr(time+datenum('1900-12-31','yyyy-mm-dd'),29);
note{3}='time is in days since 1900-12-31 00:00:00; use days=datestr(time+datenum(''1900-12-31'',''yyyy-mm-dd''),29);';%#ok
catch
time = ncread(data_url,'time',ind,numdays,temp_stride)/24; %hours since 2000-01-01 00:00:00
days=datestr(time+datenum('2000-01-01','yyyy-mm-dd'),29);
note{3}='time is in days since 2000-01-01 00:00:00; use days=datestr(time+datenum(''2000-01-01'',''yyyy-mm-dd''),29);';%#ok
end

save([savename,'_',yyyy],'data','lon','lat','depth','time','days','note');
disp('Reading and saving total time (min):')
disp(toc/60)


elseif isempty(depth) %VARIABLES WITH NO DEPTH LIKE SSH ================================================================================
    tic
   disp('================================================')
    disp(['About to download data for the following variables, data starting on ',num2str(yyyy),'-',num2str(mm),'-',num2str(dd)])
for kk=1:length(variable)
    disp(variable{kk})
    ut=ncread(data_url,variable{kk},...
    [lonli latli   ind],... %start
    [numlon numlat numdays],...%count=total elements to download
    [1 1 temp_stride]);%stride   
ut=squeeze(ut);
% eval([var_name,'=u;'])
data.(variable{kk})=ut;
end

note{1}=['Data-file created with ',mfilename('fullpath'),'.m with data from ',data_url,' on ',date];
note{2}=model_bbox;
note{3}='Surface variable';
try
time = ncread(data_url,'MT',ind,numdays,temp_stride)/24; %hours since 1900-12-31 00:00:00   divided by 24 to get days
days=datestr(time+datenum('1900-12-31','yyyy-mm-dd'),29);
note{4}='time is in days since 1900-12-31 00:00:00; use days=datestr(time+datenum(''1900-12-31'',''yyyy-mm-dd''),29);';%#ok
catch
time = ncread(data_url,'time',ind,numdays,temp_stride)/24; %hours since 2000-01-01 00:00:00  divided by 24 to get days
days=datestr(time+datenum('2000-01-01','yyyy-mm-dd'),29);
note{4}='time is in days since 2000-01-01 00:00:00; use days=datestr(time+datenum(''2000-01-01'',''yyyy-mm-dd''),29);';%#ok
end


save([savename,'_',yyyy],'data','lon','lat','time','days','note');
disp('Reading and saving total time (min):')
disp(toc/60)

end %DEPTH ================================================================================



disp('Done getting any HyCOM data! Total time (min):')
disp(toc(ticini)/60)