function [reflection,pupil,elipse,mask]=ExtractEyeInfoNew(ImageEye,framei,eye_dlc_output,Threshold,GuassFilterSize)
    reflection = [];    
    mask = PupilTracker.get_pupil_mask(ImageEye,framei,eye_dlc_output,Threshold,GuassFilterSize);
    [pupil,~] = PupilTracker.fit_pupil_from_pupil_mask(mask);
    if ~isempty(pupil)
        elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
    else
        elipse = [];
    end
end