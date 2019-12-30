function tickdegree_x(~)
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
 
end

