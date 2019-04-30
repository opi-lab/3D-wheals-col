function [D,x,xdata] = supergaussianfit(Spp_w)
% we employ a Super-Gaussian model for diameter estimation. $D = [d_1,d_2,...,d_N]$
% and $f$ denote the measured diameters and the fitted surfaces, respectively.

% http://opilab.utb.edu.co/

% This code is part of research work done by Jesus Pineda Castro. 
% Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%--------------------------------------------------------------------------------------
for i = 1: length(Spp_w)
    [yi,xi] = find(Spp_w(i).Z == max(Spp_w(i).Z(:)));
    Spp_w(i).X = Spp_w(i).X - Spp_w(i).X(yi,xi);
    Spp_w(i).Y = Spp_w(i).Y - Spp_w(i).Y(yi,xi);
    
    % Create data
    xdata(:,:,1) = Spp_w(i).X;
    xdata(:,:,2) = Spp_w(i).Y;
    
    x0 = [1,0,3,0,3,1,1,1]; %Inital guess parameters for super gaussian
    % Settings
    options = optimoptions('lsqcurvefit','OptimalityTolerance', 1e-26, 'FunctionTolerance', 1e-26);
    options.MaxFunEvals = 10000;
    options.MaxIterations = 10000;
    
    % Parameter optimization
    [x] = lsqcurvefit(@D2GaussFunctionRot,x0,xdata,Z,[],[],options);
    D(i) = max(4*x(3),4*x(5));
end


