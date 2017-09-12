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
    rtn = uint8(zeros(r - 2 *rad, c - 2 *rad, a.LVec(i)));
    
    % loop through filters in this layer
    for j = 1:a.LVec(i)
        % summing combined convolusion layers
        if i > 1
            % if there is a difference, a combination must occor
            if a.LVec(i) ~= a.LVec(i - 1)
                combs = a.(sprintf('L%dcomb', i));
                
                % for combinations of different sizes some end in 0
                % those must be truncated to avoid erros
                % averaging combination images
                if combs(j,end) == 0
                    tmp = sum(im(:, :, combs(j,end - 1)), 3) ...
                        / length(combs);
                else
                    tmp = sum(im(:, :, combs(j,:)), 3) ...
                        / length(combs - 1);
                end
            else
                tmp = double(im);
            end
            rtn(:, :, j) = convolve(tmp, a.(sprintf('L%d',i))(:, :, j));
        else
            rtn(:, :, j) = convolve(double(im), a.(sprintf('L%d',i))(:, :, j));
        end
        
    end
    r = r - 2 * rad;
    c = c - 2 * rad;
    im = rtn;
end

for i = (i + 1):a.FCL + a.CL
    rtn = zeros(1, a.LVec(i));
    for j = 1:a.LVec(i)
        rtn(j) = sum(mean(mean(im)) * a.(sprintf('L%d', i))(j));
    end
    im = rtn;
end
rtn = im / 255;
end

