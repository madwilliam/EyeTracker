function [pupil,elipse]=extract_eye_partial(ImageEye,framei,eye_dlc_output)
    Threshold = 150;
    edgeThreshold = 0.05;
    amount = 0.1;
    [X,Y] = PupilTracker.get_pupil_outline(eye_dlc_output,framei);
    elipse = PupilTracker.get_elipse(X,Y);
    pupil_mask = PupilTracker.get_pupil_mask(ImageEye,elipse);
    ImageEye=(localcontrast(ImageEye ,edgeThreshold, amount));
    ImageEye =imcomplement(ImageEye*20);
    Igray = rgb2gray(ImageEye);
    Iblur1 = imgaussfilt(Igray,1);
    pupil_mask= bwareafilt(imbinarize(imbinarize(Iblur1/Threshold,'adaptive').*imbinarize(pupil_mask)),1,'largest',4);
    pupil_mask = imfill(pupil_mask,"holes");
    [BW]=PupilTracker.findlightreflection_mask(framei,ImageEye,eye_dlc_output);
    poly = mask2poly(pupil_mask);
    good_poly = [];
    for point =poly'
        if BW(point(2),point(1))
            continue
        end
        good_poly = [good_poly point];
    end
    good_poly = good_poly';
    hold on 
    ax = figure;
    hold on
    imagesc(ImageEye-uint8(BW*150))
    scatter(good_poly(:,1),good_poly(:,2))
    ellipse_t = fit_ellipse( good_poly(:,1),good_poly(:,2),ax );
    pupil.Centroid = [ellipse_t.X0 ,ellipse_t.Y0];
    pupil.MajorAxisLength = ellipse_t.a;
    pupil.MinorAxisLength = ellipse_t.b;
    pupil.Orientation = ellipse_t.phi;
    elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
end