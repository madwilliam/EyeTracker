function [D s]=getpupil(ImageEye,coeff)
% Read image
I = imcomplement(ImageEye*coeff);
% Binarize
Igray = rgb2gray(I);
BW = imbinarize(Igray);
% Extract the maximum area
BW = imclearborder(BW);
BW = bwareafilt(BW,1);
% Calculate centroid, orientation and major/minor axis length of the ellipse
s = regionprops(BW,{'Centroid','Orientation','MajorAxisLength','MinorAxisLength'});
% Calculate the ellipse line
theta = linspace(0,2*pi);
col = (s.MajorAxisLength/2)*cos(theta);
row = (s.MinorAxisLength/2)*sin(theta);
M = makehgtform('translate',[s.Centroid, 0],'zrotate',deg2rad(-1*s.Orientation));
D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
% Visualize the result
% figure
imshow(Igray)
hold on
plot(D(1,:),D(2,:),'r','LineWidth',2)
hold off