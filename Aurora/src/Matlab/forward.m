function [ rtn ] = forward( a, im )
%Takes an image and applies the given convolusion to it
%   Inputs:
%           a - structure of convolusions
%           im - images to be studied
%   Outputs:
%           rtn - possible values for the image

[r, c] = size(im);

%loop through the convolutional layers
for i = 1: a.CL
    %radius of the filter excluding center
    rad = floor(a.KDim(i) / 2);
    %initialize next layer matrix
    rtn = single(zeros(r - 2 *rad, c - 2 *rad, a.LVec(i)));
    %loop through filters in this layer
    for j = 1:a.LVec(i)
        %loop through image decreasing hieght and width by 2*rad
        for k = 1 + rad:r - rad
            for l = 1 + rad:c - rad
                %loop through filter
                for m = 1:a.KDim(i)
                    for n = 1:a.KDim(i)
                        
                        rtn(k - rad,l - rad, j) = rtn(k - rad,l - rad, j) ...
                            + im(k - rad - 1 + m, l - rad - 1 + n) ...
                            * a.(sprintf('L%d', i))(m, n, j);
                    end
                end
                %activity function
                if rtn(k - rad, l - rad, j) < 0
                    rtn(k - rad, l - rad, j) = 0;
                end
            end
        end
        
    end
    r = r - 2 * rad;
    c = c - 2 * rad;
    im = rtn;
end

for i = (i + 1):a.FCL
    
end
end

