function [yIntersection, xIntersection] =projectiontoline(m,b,x,y,plotthis)

% coefficients = polyfit([x1, x2], [y1, y2], 1);


% m = 5.6; 
% b = -7.1; 
% x = 50; 
% y = 0; 
perpSlope = -1/m; 
% To get the y intercept of the 2nd line you just need to solve for y=mx+b using your point (x,y)
yInt = -perpSlope * x + y;
% Now you've got the two linear equations and you need to find out where they intersect. Here we find the x coordinate of the intersection.  m and b are the slope and intercept of line 1, perSlope and yInt are the slope and intercept of line 2.  
xIntersection = (yInt - b) / (m - perpSlope); 
% To get the y coordinate of the intersection, we just plug the x coordinate into one of the equations.  
yIntersection = perpSlope * xIntersection + yInt; 


% figure
if plotthis
plot(x,y, 'rx')
hold on
plot(xIntersection, yIntersection, 'ro')
refline(m, b)
% refline(perpSlope, yInt)
axis equal
end