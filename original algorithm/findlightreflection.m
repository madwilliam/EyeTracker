%%
function [centers,reflection,radii]=findlightreflection(i,ImageEye,eye_dlc_output)
    GuassFilterSize=4;
    I = rgb2gray(ImageEye*2);
    image_size = size(I);
    reflection_mask = zeros(image_size);
    ind = PupilTracker.get_lower_spot(eye_dlc_output,i);
    if ~ all(isnan(ind))
        reflection_mask(ind(1),ind(2))=1;
    end
    ind = PupilTracker.get_upper_spot(eye_dlc_output,i);
    if ~ all(isnan(ind))
        reflection_mask(ind(1),ind(2))=1;
    end
    B = imgaussfilt(reflection_mask,GuassFilterSize);
    BW = imbinarize(B);
    newimage = uint8(BW).*ImageEye*2;
    I = (newimage);
    % Binarize
    Igray = rgb2gray(I);
    BW = imbinarize(Igray);
    % Extract the maximum area
    BW = imclearborder(BW);
    % Calculate centroid, orientation and major/minor axis length of the ellipse
    reflection = regionprops('table',BW,'Centroid', 'MajorAxisLength','MinorAxisLength','PixelIdxList');
    centers = reflection.Centroid;
    diameters = mean([reflection.MajorAxisLength reflection.MinorAxisLength],2);
    radii = diameters/2;
end

