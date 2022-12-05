function [stats,s,D]=ExtractEYEinfo(ImageEye,ind,T,plotthis,devider,xybias,GuassFilterSize2,biasx,biasy)
% ImageEye = readindex(vR,double(i));
%  biasx= -3;
% biasy= -5;
Ratio=1.5;
Ratio=1.2;

[~,stats,~] = findlightreflection(ind,ImageEye,T,xybias);

 X = [T.Px1(ind),T.Px2(ind),T.Px3(ind),T.Px4(ind)];
 Y = [T.Py1(ind),T.Py2(ind),T.Py3(ind),T.Py4(ind)];
T.Px1=T.Px1-2;
T.Px2=T.Px2-2;
T.Px3=T.Px3-2;
T.Px4=T.Px4-2;
T.Px5=T.Px5-2;
T.Px6=T.Px6-2;
T.Px7=T.Px7-2;
T.Px8=T.Px8-2;
shift = 4;
T.Py1=T.Py1+shift;
T.Py2=T.Py2+shift;
T.Py3=T.Py3+shift;
T.Py4=T.Py4+shift;
T.Py5=T.Py5+shift;
T.Py6=T.Py6+shift;
T.Py7=T.Py7+shift;
T.Py8=T.Py8+shift;


% T.Py1=T.Px1-2;




 X = [T.Px1(ind),T.Px2(ind),T.Px3(ind),T.Px4(ind),T.Px5(ind),T.Px6(ind),T.Px7(ind),T.Px8(ind)]-biasx;
 Y = [T.Py1(ind),T.Py2(ind),T.Py3(ind),T.Py4(ind),T.Py5(ind),T.Py6(ind),T.Py7(ind),T.Py8(ind)]-biasy;

[zg, ag, bg, alphag] = fitellipse( [X',Y']);
theta = linspace(0,2*pi);
col = (ag*Ratio)*cos(theta);
row = (bg*Ratio)*sin(theta);
M = makehgtform('translate',[zg', 0],'zrotate',deg2rad(-1*alphag));
D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];

[xq,yq]= find(ones(size(ImageEye)));
thismask = zeros(size(ImageEye));
in = inpolygon(xq,yq,D(2,:),D(1,:));
thismask(in)=1;
thismask = rgb2gray(thismask);

% imshow(uint8(thismask*40).*ImageEye)


GuassFilterSize=5;
% I = rgb2gray(ImageEye*2);
Thissize = size(ImageEye);
Thissize(end)=[];
% Thissize(entd)=1;
% make a image the size of im2
thisim = zeros(Thissize);
thisind = sub2ind(Thissize,floor(X),floor(Y));
thisim(thisind(~isnan(thisind)))=1;
% use guassina filtering to expand the points 
B = imgaussfilt(thisim,GuassFilterSize);
% BWmask = imbinarize(B);

BWmask = imbinarize(thismask);

binaryImage = imfill(BWmask, 'holes');
% imagesc(binaryImage)


% GuassFilterSize2=1;
Thissize = size(ImageEye);
Thissize(end)=[];
% Thissize(entd)=1;
% make a image the size of im2
thisim = zeros(Thissize);
% for ii=1:numel(stats.MajorAxisLength)
% thisim(stats.PixelIdxList{ii})=1;
% end
thisind = sub2ind(Thissize,round(stats.Centroid(:,2)),round(stats.Centroid(:,1)));
thisim(thisind)=1;
% thisim(stats.PixelIdxList{2})=1;


% use guassina filtering to expand the points
B = imgaussfilt(thisim,GuassFilterSize2);
BW = imbinarize(B);

Iblur = imgaussfilt(uint8(BW)*500,1.6);
% imagesc(Iblur1)

% Read image
% I = imcomplement(3*ImageEye-Iblur*2);
I = imcomplement((ImageEye-Iblur)*30);

% Binarize
Igray = rgb2gray(I);
% BW2 =(imbinarize(Igray/devider));
% % Extract the maximum area
% BW2 = imclearborder(BW2);
% BW2= bwareafilt(BW2,1,'largest',4);

 Iblur1 = imgaussfilt(Igray,1);
% Iblur1 = Igray;
% BW2 = imclearborder(imbinarize(Iblur1/devider));
% BW2= bwareafilt(BW2,1,'largest',4);

BW2= bwareafilt(imbinarize(imbinarize(Iblur1/devider).*binaryImage),1,'largest',4);
test=edge(BW2,'canny');
test = bwmorph(test, 'bridge'); % Use this to connect the pixels
outputs = imfill(test,'holes');
outputs= bwareafilt(outputs,1,'largest',4);
% imshow(outputs)



s = regionprops(outputs,{'Centroid','Orientation','MajorAxisLength','MinorAxisLength'});
% s=s(2);
if ~isempty(s)
theta = linspace(0,2*pi);
col = (s.MajorAxisLength/2)*cos(theta);
row = (s.MinorAxisLength/2)*sin(theta);
M = makehgtform('translate',[s.Centroid, 0],'zrotate',deg2rad(-1*s.Orientation));
D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
% [D, s]=getpupil(((4*ImageEye-Iblur*2)),11);
if plotthis
imshow(ImageEye*8)
hold on
  plot(D(1,:),D(2,:),'r','LineWidth',2)
%   plot(stats.Centroid(:,1),stats.Centroid(:,2),'b.','LineWidth',2)
  plot( s.Centroid(1),s.Centroid(2),'g.','Markersize',25)

% viscircles(centers,radii);
% biasx= -3;
% biasy= -5;
T.Ey3=T.Ey3+4;
T.Ex3=T.Ex3-4;

plot(T.Ex1(ind)-biasx,T.Ey1(ind)-biasy,'g.','Markersize',25)
plot(T.Ex3(ind)-biasx,T.Ey3(ind)-biasy,'m.','Markersize',25)
plot(T.Ex2(ind)-biasx,T.Ey2(ind)-biasy,'m.','Markersize',25)
plot(T.Ex4(ind)-biasx,T.Ey4(ind)-biasy,'m.','Markersize',25)

plot([T.Ex1(ind)-biasx T.Ex3(ind)-biasx],[T.Ey1(ind)-biasy T.Ey3(ind)-biasy],'g--','Markersize',25)


 plot(T.Px1(ind)-biasx,T.Py1(ind)-biasy,'r.','Markersize',25)
 plot(T.Px5(ind)-biasx,T.Py5(ind)-biasy,'r.','Markersize',25)
plot(T.Px3(ind)-biasx,T.Py3(ind)-biasy,'r.','Markersize',25)
 plot(T.Px7(ind)-biasx,T.Py7(ind)-biasy,'r.','Markersize',25)

% plot(T.Ex3(ind),T.EY3(ind),'g.','Markersize',25)

hold off
title(['frame = ' num2str(ind)]) 
    
end
else
 D = []; 
end

  
  end