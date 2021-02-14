function [ CI ] = bootstrap_mean(iteration, data)
% Bootstrap for mean and CI at 95%
%   Detailed explanation goes here

stats = bootstrp(iteration, @mean, data);
stats=sort(stats);
lower_pos=round(iteration*((1-0.95)/2));
upper_pos=round(iteration*(0.95+((1-0.95)/2)));
lower=stats(lower_pos);
upper=stats(upper_pos);
CI=[lower, upper];

end

