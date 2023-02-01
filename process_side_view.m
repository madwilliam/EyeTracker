Main_FolderRight='Z:\afassihizakeri\rightsidemovies\ar42motor\2022_11_04';
trials = ExperimentProcessor.get_trials(Main_FolderRight);
Threshold = 103;
Gaussianlightsourceremoval = 1.5;
biasx= -4;
biasy=-0;
xybias =1;
tracker = PupilTracker(Main_FolderRight);
allpupil = [];
for Trialnumber =trials
    disp(Trialnumber)
    try
        eye_dlc_output = tracker.get_eye_dlc_output(Trialnumber);
        vL = VideoReader(fullfile(Main_FolderRight,strcat(num2str(Trialnumber),'EYE.avi')) );
        Intersection=[];
        cp=[];
        Dy=[];
        Intersection2=[];
        cp2=[];
        c=[];
        allpupil = [];
        for framei = 1:vL.NumFrames
            try
                ImageEye = PupilTracker.readindex(vL,double(framei));
                Threshold = 100;
                edgeThreshold = 0.05;
                amount = 0.1;
                [pupil,elipse]=extract_eye_partial(ImageEye,framei,eye_dlc_output,Threshold,edgeThreshold,amount,false);
                allpupil = [allpupil pupil];
            catch
                break
            end
        end
        Pupil.Right.Pupil{Trialnumber+1}=allpupil;
        Pupil.Right.pupilcenter{Trialnumber+1}=allpupil.Centroid;
        Pupil.Right.TearDuct{Trialnumber+1}=[eye_dlc_output.Ex3,eye_dlc_output.Ey3];
        Pupil.Right.EyeBack{Trialnumber+1}=[eye_dlc_output.Ex1,eye_dlc_output.Ey1];
    catch
        disp('error')
        
        disp(Trialnumber)
    end
end
%%
save(fullfile('Z:\william','new_pupil.m'),'Pupil')
%%
unfinished = [];
for Trialnumber =trials
    if isempty(Pupil.Right.Pupil{Trialnumber+1})
        unfinished = [unfinished Trialnumber];
    end
end
%%
for Trialnumber =unfinished
    try
        eye_dlc_output = tracker.get_eye_dlc_output(Trialnumber);
        vL = VideoReader(fullfile(Main_FolderRight,strcat(num2str(Trialnumber),'EYE.avi')) );
        Intersection=[];
        cp=[];
        Dy=[];
        Intersection2=[];
        cp2=[];
        c=[];
        allpupil = [];
        for framei = 1:vL.NumFrames
            try
                ImageEye = PupilTracker.readindex(vL,double(framei));
                Threshold = 100;
                edgeThreshold = 0.05;
                amount = 0.1;
                [pupil,elipse]=extract_eye_partial(ImageEye,framei,eye_dlc_output,Threshold,edgeThreshold,amount,false);
                allpupil = [allpupil pupil];
            catch
                break
            end
        end
        Pupil.Right.Pupil{Trialnumber+1}=allpupil;
        Pupil.Right.pupilcenter{Trialnumber+1}=allpupil.Centroid;
        Pupil.Right.TearDuct{Trialnumber+1}=[eye_dlc_output.Ex3,eye_dlc_output.Ey3];
        Pupil.Right.EyeBack{Trialnumber+1}=[eye_dlc_output.Ex1,eye_dlc_output.Ey1];
    catch e
        error = {e.stack.name};
        disp(Trialnumber)
        disp(error{1})
        disp(e.identifier)
    end
end
%%
unfinished = [80,98];
for Trialnumber =unfinished
    try
        eye_dlc_output = tracker.get_eye_dlc_output(Trialnumber);
        vL = VideoReader(fullfile(Main_FolderRight,strcat(num2str(Trialnumber),'EYE.avi')) );
        Intersection=[];
        cp=[];
        Dy=[];
        Intersection2=[];
        cp2=[];
        c=[];
        allpupil = [];
        for framei = 1:vL.NumFrames
            try
                ImageEye = PupilTracker.readindex(vL,double(framei));
                Threshold = 100;
                edgeThreshold = 0.05;
                amount = 0.1;
                [pupil,elipse]=extract_eye_partial(ImageEye,framei,eye_dlc_output,Threshold,edgeThreshold,amount,false);
                allpupil = [allpupil pupil];
            catch
                pupil.Centroid = nan;
                pupil.MajorAxisLength = nan;
                pupil.MinorAxisLength = nan;
                pupil.Orientation = nan;
                pupil.R = nan;
                allpupil = [allpupil pupil];
            end
        end
        Pupil.Right.Pupil{Trialnumber+1}=allpupil;
        Pupil.Right.pupilcenter{Trialnumber+1}=allpupil.Centroid;
        Pupil.Right.TearDuct{Trialnumber+1}=[eye_dlc_output.Ex3,eye_dlc_output.Ey3];
        Pupil.Right.EyeBack{Trialnumber+1}=[eye_dlc_output.Ex1,eye_dlc_output.Ey1];
    catch e
        error = {e.stack.name};
        disp(Trialnumber)
        disp(error{1})
        disp(e.identifier)
    end
end