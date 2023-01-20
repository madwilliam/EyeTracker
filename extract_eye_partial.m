function [reflection,pupil,elipse,inspect]=extract_eye_partial(ImageEye,framei,eye_dlc_output,Threshold,gaussian)
    pupil_mask = PupilTracker.get_pupil_mask(ImageEye,framei,eye_dlc_output,Threshold,10);
    [BW]=get_light_reflection_mask(framei,rgb2gray(ImageEye),eye_dlc_output);
    BW = imdilate(BW, strel('disk', gaussian));
    inspect = imfuse(pupil_mask,BW,'falsecolor','Scaling','independent','ColorChannels',[1 2 0]);
    
    poly = mask2poly(pupil_mask);
    good_poly = [];
    for point =poly'
        if BW(point(2),point(1))
            continue
        end
        good_poly = [good_poly point];
    end
    good_poly = good_poly';
    if isempty(good_poly)
        pupil = [];
        elipse = [];
        return
    end
    npoints = size(good_poly,1);
    inspect = insertShape(inspect,"rectangle",[good_poly,ones(npoints,1),ones(npoints,1)],'color','white');
    ax = [];
    ellipse_t = fit_ellipse( good_poly(:,1),good_poly(:,2),ax );
    pupil.Centroid = [ellipse_t.X0 ,ellipse_t.Y0];
    pupil.MajorAxisLength = ellipse_t.a;
    pupil.MinorAxisLength = ellipse_t.b;
    pupil.Orientation = ellipse_t.phi;
    pupil.R = ellipse_t.R;
    elipse = PupilTracker.pupil_to_elipse(pupil);
    reflection = [];
end