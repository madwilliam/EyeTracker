function [Intersection,cp,c,Dy] = findprojectedvalues (z,x1,y1,ifplot)

% it calculated the projection of z to xy line and finds the values of
% projected z point into xy line and its distance from the line

%%
% z= [ 1.5 5];
% x1 = [1 2];
% y1 = [5 4];
% find the equation for the line between two points x1 y1
c = [[1; 1]  x1(:)]\y1(:);                        % Calculate Parameter Vector
slope_m = c(2);
intercept_b = c(1);

% find the equation for the Perpendicular line that passes the z


cp(2) = -1./c(2);
cp(1)= z(2)-(z(1).*cp(2));


% find the intersect of two lines
Intersection(1) = (cp(1)-c(1))./(c(2)-cp(2));
Intersection(2) = Intersection(1)*slope_m+intercept_b;

Dy = sqrt(abs(Intersection(2)-z(2)).^2+abs(Intersection(1)-z(1)).^2);
%% plot them
if ifplot
% hold off
x = linspace(min(x1),max(x1),10);
y = polyval([c(2) c(1)],x);
plot(x,y ,'--g')
% hold on
plot(x1(1),y1(1),'.r')
plot(x1(2),y1(2),'.r')

plot(Intersection(1),Intersection(2),'.m','markersize',20)

plot(z(1),z(2),'.g','markersize',20)
x = linspace(min([z(1) Intersection(1) ]),max([z(1) Intersection(1)]),10);
y = polyval([cp(2) cp(1)],x);
plot(x,y ,'--b')
% xlim([0 6])
% ylim([0 6])
axis square

end
