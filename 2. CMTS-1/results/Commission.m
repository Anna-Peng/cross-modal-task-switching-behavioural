function [ com_error ] = Commission( data_pos, rightanswer, hit)
% data_pos should be a logical for the position of data in interest
%   Detailed explanation goes here

com_error=0;
hit=hit(data_pos);
right=rightanswer(data_pos);
for i=1:length(hit)
    if hit(i)==1 && right(i)==0
        com_error=com_error+1;
    else
        com_error=com_error+0;
    end  
end

end

