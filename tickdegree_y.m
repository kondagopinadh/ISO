function tickdegree_y(~)

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
 
end

