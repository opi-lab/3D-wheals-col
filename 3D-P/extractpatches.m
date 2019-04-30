function [Spp_w] = extractpatches(Sp,L)
% we detect wheals from Sp and extract $N$ surface patches referred to as
% Sp_w_i, where i = {1,2,...,N}. For each surface Sp_w_i, we set the origin
% at the center of mass to obtain Spp_w_i by means of Principal Component
% Analysis (PCA).

% http://opilab.utb.edu.co/

% This code is part of research work done by Jesus Pineda Castro. 
% Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%--------------------------------------------------------------------------------------
for i = 1 : size(L,1)
    % Metric crop
    if L(i,3) > 30
        w = 8; % mm
        h = 8; % mm
    elseif L(i,3) <= 30
        w = 6; % mm
        h = 6; % mm
    end
    
    % for X...
    [~,up] = min(min(abs(Sp.X'-(Sp.X(L(i,1),L(i,2)) - h))));
    [~,down] = min(min(abs(Sp.X'-(Sp.X(L(i,1),L(i,2)) + h))));
    
    % for Y...
    [~,left] = min(min(abs(Sp.Y-(Sp.Y(L(i,1),L(i,2)) - w))));
    [~,rigth] = min(min(abs(Sp.Y-(Sp.Y(L(i,1),L(i,2)) + w))));
    
    % Extract patches
    Sp_w(i).Z  = Sp.Z(up:down,left:rigth);
    Sp_w(i).X  = Sp.X(up:down,left:rigth);
    Sp_w(i).Y  = Sp.Y(up:down,left:rigth);
    
    % Surface Centering (PCA)
    [~,score] = pca([Sp_w(i).X(:) Sp_w(i).Y(:) Sp_w(i).Z(:)]);
    Spp_w(i).Z = reshape(score(:,3),size(Sp_w(i).Z));
    Spp_w(i).Z = Sp_w(i).Z
    Spp_w(i).X = Sp_w(i).X;
    Spp_w(i).Y = Sp_w(i).Y;
    
end



