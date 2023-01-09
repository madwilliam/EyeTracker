data_path = '/net/dk-server/afassihizakeri/Leftsidemovies/ar41motor/2022_07_28/';
framei = 2;
trial_number = 1;
vL = VideoReader([data_path,num2str(trial_number),'EYE.avi'] );
ImageEye = PupilTracker.readindex(vL,double(framei));
[pupil,elipse]=extract_eye_partial(ImageEye,framei,eye_dlc_output);