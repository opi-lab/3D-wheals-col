function [Sp] = gsr(S,pyr,levels,scales)
%  By zeroing the levels that are not directly related to the 3D information
%  of the wheals, the Laplacian pyramid is collapsed to obtain Sp.

% http://opilab.utb.edu.co/

% This code is part of research work done by Jesus Pineda Castro. 
% Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%--------------------------------------------------------------------------------------
% Zerozing...
for i = 1 : levels
    if sum(i == scales)
        pyr{i} = zeros(size(pyr{i}));
    end
end
% Image size
D = size(pyr{1});
% Image reconstrction
Sp.Z = pyrReconstruct(pyr);
% Adjust x- and y- coordinates
Sp.X = S.X(1:D(1),1:D(2)); 
Sp.Y = S.Y(1:D(1),1:D(2));
end

