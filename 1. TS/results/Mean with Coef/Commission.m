function [ com_error, precomAll ] = Commission( data_pos, rightanswer, hit)
% data_pos should be a logical for the position of data in interest
%   Detailed explanation goes here

com_error=0;
hit=hit(data_pos);
right=rightanswer(data_pos);
for i=1:length(hit)
    if hit(i)==1 && right(i)==0
        com_error=com_error+1;
        comAll(i)=1;
    else
        com_error=com_error+0;
        comAll(i)=0;
    end  
end

precom=0;
for j=1:length(comAll)-1
    if comAll(j)==1 && comAll(j+1)==1
        precom(j+1)=1;
    else
        precom(j+1)=0;
    end
end

precomAll=sum(precom);
end


