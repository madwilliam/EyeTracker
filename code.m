%% next trial
Intersectpupil=[];
pupil_line=[];
pupil_to_corner_line_distance=[];
Intersectlight=[];
reflection_line=[];
eye_corner_line=[];
eye_dlc_output = tracker.get_eye_dlc_output(Trialnumber);
vL = VideoReader([data_path,num2str(Trialnumber),'EYE.avi'] );
allpupil = array2table(zeros(0,4));
allpupil.Properties.VariableNames = {'Centroid','MajorAxisLength', ...
    'MinorAxisLength','Orientation'};
%% next frame
Center=reflection.Centroid;
Centersize=reflection.MajorAxisLength;
Center(Centersize<3,:)=0;
[~,maxid] = max(Center(:,2));
pupilcenter(framei,:)=pupil.Centroid;
thiscenter(framei,:)=Center(maxid,:);
allpupil = [allpupil;struct2table(pupil)];
shift = 4;
cornerx = [eye_dlc_output.Ex1(framei),eye_dlc_output.Ex3(framei)]-biasx;
cornery = [eye_dlc_output.Ey1(framei),eye_dlc_output.Ey3(framei)+shift]-biasy;
[Intersectpupil(framei,:),pupil_line(framei,:),~,pupil_to_corner_line_distance(framei)] = findprojectedvalues (pupil.Centroid,cornerx,cornery);
[Intersectlight(framei,:),reflection_line(framei,:),eye_corner_line(framei,:),~] = findprojectedvalues (Center(maxid,:),cornerx,cornery);
checkparam =0;
while checkparam==0
    framei=framei+1;
    ImageEye = PupilTracker.readindex(vL,double(framei));
    [reflection,pupil,elipse]=ExtractEYEinfo(ImageEye,framei,eye_dlc_output,threshold,gaussian);
    PupilPlotter.plot_pupil_fit(gca,ImageEye,elipse,pupil,eye_dlc_output,framei)
    if framei>4
        imagesc(ImageEye*4)
        hold on
        plot(elipse(1,:),elipse(2,:),'r')
    end
    if framei>3
        pupilarea= ( pi.*(allpupil.MinorAxisLength.*allpupil.MajorAxisLength));
        pupilarea=mean(pupilarea(end-2:end));
        thisarea =  pi.*pupil.MajorAxisLength.*pupil.MinorAxisLength;
        if thisarea>pupilarea*1.1||thisarea<pupilarea*0.9
            checkparam =1;
            [reflection,pupil,elipse]=ExtractEYEinfo(ImageEye,framei,eye_dlc_output,threshold,gaussian);
            PupilPlotter.plot_pupil_fit(gca,ImageEye,elipse,pupil,eye_dlc_output,framei)
        end
    end
end
%%
Pupil.Left.intersectpupil{Trialnumber+1}=Intersectpupil;
Pupil.Left.intersectlight{Trialnumber+1}=Intersectlight;
Pupil.Left.DY{Trialnumber+1}=pupil_to_corner_line_distance;
Pupil.Left.EYEhorizontalaxis{Trialnumber+1}=eye_corner_line;
Pupil.Left.Pupil{Trialnumber+1}=allpupil;
Pupil.Left.pupilcenter{Trialnumber+1}=pupilcenter;
Pupil.Left.Light{Trialnumber+1}=thiscenter;
Pupil.Left.TearDuct{Trialnumber+1}=[eye_dlc_output.Ex1,eye_dlc_output.Ey1];
Pupil.Left.EyeBack{Trialnumber+1}=[eye_dlc_output.Ex3,eye_dlc_output.Ey3];
save Pupil Pupil

