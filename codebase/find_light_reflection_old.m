%%
function [centers,stats,radii]=find_light_reflection_old(i,ImageEye,TRight,xybias)
    GuassFilterSize=4;
    I = rgb2gray(ImageEye*2);
    image_size = size(I);
    thisim = zeros(image_size);
    ind = sub2ind(image_size,floor(TRight.LDOWNy1(i))+xybias,floor(TRight.LDOWNx1(i))+xybias);
    thisim(ind(~isnan(ind)))=1;
    ind = sub2ind(image_size,floor(TRight.LUPy1(i))+xybias,floor(TRight.LUPx1(i))+xybias);
    thisim(ind(~isnan(ind)))=1;
    B = imgaussfilt(thisim,GuassFilterSize);
    BW = imbinarize(B);
    newimage = uint8(BW).*ImageEye*2;
    I = (newimage);
    % Binarize
    Igray = rgb2gray(I);
    BW = imbinarize(Igray);
    % Extract the maximum area
    BW = imclearborder(BW);
    % Calculate centroid, orientation and major/minor axis length of the ellipse
    stats = regionprops('table',BW,'Centroid', 'MajorAxisLength','MinorAxisLength','PixelIdxList');
    centers = stats.Centroid;
    diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameters/2;
end

