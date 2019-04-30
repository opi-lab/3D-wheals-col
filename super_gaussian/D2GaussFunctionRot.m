function F = D2GaussFunctionRot(x,xdata)
% x = [Amp, x0, wx, y0, wy, fi] % for gaussian
% x = [Amp, x0, wx, y0, wy, fi, Px, Py] % for super gaussian

% http://opilab.utb.edu.co/

% This code is part of research work done by Jesus Pineda Castro. 
% Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%--------------------------------------------------------------------------------------
xdatarot(:,:,1)= xdata(:,:,1)*cos(x(6)) - xdata(:,:,2)*sin(x(6));
xdatarot(:,:,2)= xdata(:,:,1)*sin(x(6)) + xdata(:,:,2)*cos(x(6));
x0rot = x(2)*cos(x(6)) - x(4)*sin(x(6));
y0rot = x(2)*sin(x(6)) + x(4)*cos(x(6));

% for gaussian
if length(x) == 6
    F = x(1)*exp(   -((xdatarot(:,:,1)-x0rot).^2/(2*x(3)^2) + (xdatarot(:,:,2)-y0rot).^2/(2*x(5)^2) ));
else
    F = x(1)*exp(   -(((xdatarot(:,:,1)-x0rot).^2/(2*x(3)^2)).^x(7) + ((xdatarot(:,:,2)-y0rot).^2/(2*x(5)^2)).^x(8) ));
end