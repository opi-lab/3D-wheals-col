function F = D2GaussFunctionRot(x,xdata)
%% x = [Amp, x0, wx, y0, wy, fi] % for gaussian
%% x = [Amp, x0, wx, y0, wy, fi, Px, Py] % for super gaussian
%[X,Y] = meshgrid(x,y) 
%  xdata(:,:,1) = X
%  xdata(:,:,2) = Y           
% Mrot = [cos(fi) -sin(fi); sin(fi) cos(fi)]
%%
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
%F = x(1)*exp(   -((xdatarot(:,:,1)-x0rot).^2/(2*x(3)^2) + (xdatarot(:,:,2)-y0rot).^2/(2*x(5)^2) ));
% for supper gaussian


% figure(3)
% alpha(0)
% imagesc(F)
% colormap('gray')
% figure(gcf)%bring current figure to front
% drawnow
% beep
% pause %Wait for keystroke
