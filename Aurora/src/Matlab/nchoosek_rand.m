function [ rtn ] = nchoosek_rand( n, k, c )
%Returns matrix of size c with random groupings of
%of elements of size k
%   inputs:
%           n - An array of elements to be chosen from
%           k - The number of elements in desired array
%           c - The desired number of groupings
%   outputs:
%           rtn - k by c matrix of elements from n

rtn = zeros(c, k);
if length(n) ~= 1
    y = nchoosek(length(n), k);
    x = nchoosek(n, k);
    idx = ceil(y * rand(1, c));
    for i = 1:c
        rtn(i, :) = x(idx(i), :);
    end
end


end

