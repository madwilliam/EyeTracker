plotthis =1;
 for i=1:120;
% i=120
ImageEye = readindex(vR,double(i));

[centers,stats,radii] = findlightreflection(i,ImageEye,TRight,plotthis);



GuassFilterSize=1;
I = rgb2gray(ImageEye*2);
Thissize = size(I);
% Thissize(entd)=1;
% make a image the size of im2
thisim = zeros(Thissize);
ind = sub2ind(Thissize,floor(centers(:,2)),floor(centers(:,1)));
% thisim(ind(~isnan(ind)))=1;
for ii=1:numel(stats.MajorAxisLength)
thisim(stats.PixelIdxList{ii})=1;
end
% thisim(stats.PixelIdxList{2})=1;


% use guassina filtering to expand the points
B = imgaussfilt(thisim,GuassFilterSize);
BW = imbinarize(B);

Iblur = imgaussfilt(uint8(BW)*500,1.5);
% imagesc(Iblur)

% Read image
I = imcomplement(4*ImageEye-Iblur*2);
% Binarize
Igray = rgb2gray(I);
BW2 =(imbinarize(Igray/487));
% Extract the maximum area
BW2 = imclearborder(BW2);
BW2= bwareafilt(BW2,1);

s = regionprops(BW2,{'Centroid','Orientation','MajorAxisLength','MinorAxisLength'});
% s=s(2);
theta = linspace(0,2*pi);
col = (s.MajorAxisLength/2)*cos(theta);
row = (s.MinorAxisLength/2)*sin(theta);
M = makehgtform('translate',[s.Centroid, 0],'zrotate',deg2rad(-1*s.Orientation));
D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
% [D, s]=getpupil(((4*ImageEye-Iblur*2)),11);
imshow(ImageEye*8)
hold on
plot(D(1,:),D(2,:),'r','LineWidth',2)

% centers = stats.Centroid;
% diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
% radii = diameters/2;

viscircles(centers,radii);
plot(TRight.tearx(i),TRight.teary(i),'g.','Markersize',25)
hold off

  pause
  end