function [ Cim ] = convolve( im, k )
%Takes an image and performs a convolusion using the given kernel
%   Inputs:
%           im - Image to be convolved
%           k - kernel/filter to convolve with
%   Outputs:
%           Cim - convolved image

rad = floor(length(k) / 2);
[r, c] = size(im);
Cim = zeros(r - 2 * rad, c - 2 * rad);
for ri = 1 + rad:r - rad
    for ci = 1 + rad: c - rad
        Cim(ri - rad, ci - rad) = sum(sum( ...
            im(ri - rad:ri + rad, ci - rad: ci - rad) .* k));
    end
end

end

