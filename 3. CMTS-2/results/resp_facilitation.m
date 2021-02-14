function [ single_case, single_response, rep_case, rep_response ] = resp_facilitation( data_set, target )
%UNTITLED3 Summary of this function goes here
%  single_case is the no. of single response
% single_response is the all the data for single response

for i=1:length(target)
    if target(i)==1 & data_set(i)==1
        g(i,:)=1;
    else
        g(i,:)=0;
    end
end

rep_response=zeros(length(g),1);
for i=1:length(g)-1
    if g(i)==1 && g(i+1)==1
        rep_response(i+1)=1;
    end
end

rep_response=logical(rep_response);
g(rep_response)=0;
single_response=logical(g);
rep_case=sum(rep_response);
single_case=sum(single_response);

end

