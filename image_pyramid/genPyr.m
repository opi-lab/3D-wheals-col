function [ pyr ] = genPyr( img, type, level )
%GENPYR generate Gaussian or Laplacian pyramid
%   PYR = GENPYR(A,TYPE,LEVEL) A is the input image, 
%	can be gray or rgb, will be forced to double. 
%	TYPE can be 'gauss' or 'laplace'.
%	PYR is a 1*LEVEL cell array.
% Yan Ke @ THUEE, xjed09@gmail.com
% Modified by: Jes�s Pineda - jesuspinedacastro@outlook.com

pyr = cell(1,level);
pyr{1} = im2double(img.Z);

for p = 2:level
    % Reduce i-1'th scale
	pyr{p} = pyr_reduce(pyr{p-1});
end
if strcmp(type,'gauss'), return; end

% When expanding, we may get image dimensions that
% aren't quite the same when targetting a particular scale
% As such, we need to make sure we are consistent
for p = level-1:-1:1 
	osz = size(pyr{p+1})*2-1;
	pyr{p} = pyr{p}(1:osz(1),1:osz(2),:);
end

for p = 1:level-1
    % Take i'th scale and subtract with expanded i+1'th scale
	pyr{p} = pyr{p}-pyr_expand(pyr{p+1});
end

end