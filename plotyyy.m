function [ax,hlines] = plotyyy(x1,y1,x2,y2,x3,y3,ylabels)
%PLOTYYY - Extends plotyy to include a third y-axis
%
%Syntax:  [ax,hlines] = plotyyy(x1,y1,x2,y2,x3,y3,ylabels)
%
%Inputs: x1,y1 are the xdata and ydata for the first axes' line
%        x2,y2 are the xdata and ydata for the second axes' line
%        x3,y3 are the xdata and ydata for the third axes' line
%        ylabels is a 3x1 cell array containing the ylabel strings
%
%Outputs: ax -     3x1 double array containing the axes' handles
%         hlines - 3x1 double array containing the lines' handles
%
%Example:
%x=0:10; 
%y1=x;  y2=x.^2;   y3=x.^3;
%ylabels{1}='First y-label';
%ylabels{2}='Second y-label';
%ylabels{3}='Third y-label';
%[ax,hlines] = plotyyy(x,y1,x,y2,x,y3,ylabels);
%legend(hlines, 'y = x','y = x^2','y = x^3',2)
%
%m-files required: none

%Author: Denis Gilbert, Ph.D., physical oceanography
%Maurice Lamontagne Institute
%Dept. of Fisheries and Oceans Canada
%email: gilbertd@dfo-mpo.gc.ca  
%Web: http://www.qc.dfo-mpo.gc.ca/iml/
%April 2000; Last revision: 14-Nov-2001

if nargin==6
   %Use empty strings for the ylabels
   ylabels{1}=' '; ylabels{2}=' '; ylabels{3}=' ';
elseif nargin > 7
   error('Too many input arguments')
elseif nargin < 6
   error('Not enough input arguments')
end

figure('units','normalized',...
       'DefaultAxesXMinorTick','on','DefaultAxesYminorTick','on'); 

%Plot the first two lines with plotyy
[ax,hlines(1),hlines(2)] = plotyy(x1,y1,x2,y2,'bar','bar');
cfig = get(gcf,'color');
pos = [0.1  0.1  0.7  0.8];
offset = pos(3)/5.5;

%Reduce width of the two axes generated by plotyy 
pos(3) = pos(3) - offset/2;
set(ax,'position',pos);  

%Determine the position of the third axes
pos3=[pos(1) pos(2) pos(3)+offset pos(4)];

%Determine the proper x-limits for the third axes
limx1=get(ax(1),'xlim');
limx3=[limx1(1)   limx1(1) + 1.2*(limx1(2)-limx1(1))];
%Bug fix 14 Nov-2001: the 1.2 scale factor in the line above
%was contributed by Mariano Garcia (BorgWarner Morse TEC Inc)

ax(3)=axes('Position',pos3,'box','off',...
   'Color','none','XColor','k','YColor','r',...   
   'xtick',[],'xlim',limx3,'yaxislocation','right');

hlines(3) = plotyy(x3,y3,'bar','Color','r','Parent',ax(3));
limy3=get(ax(3),'YLim');

%Hide unwanted portion of the x-axis line that lies
%between the end of the second and third axes
line([limx1(2) limx3(2)],[limy3(1) limy3(1)],...
   'Color',cfig,'Parent',ax(3),'Clipping','off');
axes(ax(2))

%Label all three y-axes
set(get(ax(1),'ylabel'),'string',ylabels{1})
set(get(ax(2),'ylabel'),'string',ylabels{2})
set(get(ax(3),'ylabel'),'string',ylabels{3})