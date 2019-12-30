function tickdegree(~,~)
%%%xtick
tickvals = get(gca,'xtick');
NewTickLabels = cell(1,length(tickvals));
 for k=1:numel(tickvals)
     if tickvals(k)==0
         NewTickLabels{k}=[num2str(tickvals(k)) char(0176)];
     elseif tickvals(k)>0
         NewTickLabels{k}=[num2str(tickvals(k)) char(0176) 'E'];
     else
         NewTickLabels{k}=[num2str(tickvals(k)) char(0176) 'W'];
     end
 end
 set(gca,'xticklabel',NewTickLabels);
 
 
 %%%%ytick
 tickvals_y = get(gca,'ytick');
NewTickLabels_y = cell(1,length(tickvals_y));
 for j=1:numel(tickvals_y)
        if tickvals_y(j)==0
            NewTickLabels_y{j}=[num2str(tickvals_y(j)) char(0176)];
        elseif tickvals_y(j)>0
            NewTickLabels_y{j}=[num2str(tickvals_y(j)) char(0176) 'N'];
        else
            NewTickLabels_y{j}=[num2str(-tickvals_y(j)) char(0176) 'S'];
        end
 end
 set(gca,'yticklabel',NewTickLabels_y);
%  set(gca,'LineWidth',1,'FontSize',20,'Fontweight','Bold','TickDir','In');
end
