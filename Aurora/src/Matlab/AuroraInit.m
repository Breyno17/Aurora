function [ Aurora ] = AuroraInit(nc,nfc,cd)
% Initializes ai Aurora structure with kernel values according to a
% specified structure.
% INPUTS:
%       -nc:    Row vector with same number of elements as convolutional 
%       layers that specifies the number of convolutions per layer.
%
%       -nfc:   Row vector with same number of elements as fully connected
%       layers that specifies the number of nodes in fully connected
%       layers.
%
%       -cd:    Matrix that specifies the dimensions of the kernel for each 
%       convolutional layer, assumes square matrices. Should have same 
%       number of elements as convolutional layers.
%
%
% OUTPUTS:
%       -Aurora:    AI structure containing randomly-assigned kernel
%       weights for convolutional operations based on the number of layers
%       specified in inputs, as well as fully-connected weights with layers
%       specified by user.

% Assigns data fields for Aurora as specified by initialization inputs.
Aurora.CL = length(nc);
Aurora.FCL = length(nfc);
Aurora.LVec = [nc nfc];
if sum(rem(cd,2)) == length(cd)
    Aurora.KDim = cd;
    % Initializes convolutional layer structure using random values from 0 to 1
    % and assigns them to Aurora.Ln
    for l=1:Aurora.CL
        Aurora.(sprintf('L%d',l)) = rand(cd(l),cd(l),nc(l));
    end
    
    % Initializes fully-connected layer structure using random values from 0
    for m=Aurora.CL+1:Aurora.CL+Aurora.FCL
        Aurora.(sprintf('L%d',m)) = rand(1,nfc(m-Aurora.CL));
    end
else
    error('I can''t even you sack of shit.');
end


end

