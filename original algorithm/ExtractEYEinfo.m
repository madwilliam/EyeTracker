function [reflection,pupil,elipse,pupil_mask]=ExtractEYEinfo(ImageEye,framei,eye_dlc_output,Threshold,GuassFilterSize)
    edgeThreshold = 0.05;
    amount = 0.1;
    [~,reflection,~] = findlightreflection(framei,ImageEye,eye_dlc_output);
    [X,Y] = PupilTracker.get_pupil_outline(eye_dlc_output,framei);
    elipse = PupilTracker.get_elipse(X,Y);
    reflection_removed_image = PupilTracker.remove_reflection(ImageEye,reflection,GuassFilterSize,edgeThreshold,amount);
    pupil_mask = PupilTracker.get_pupil_mask(ImageEye,elipse);
    [pupil,pupil_mask] = PupilTracker.fit_pupil(reflection_removed_image,Threshold,pupil_mask);
    if ~isempty(pupil)
        elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
    else
        elipse = [];
    end
end