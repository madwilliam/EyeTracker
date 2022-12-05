biasx= -4;
biasy= -2;
xybias=4;
plotthis = 1;
checkparam =1;
threshold = 150;
gaussian = 1.2;
data_path = '/net/dk-server/afassihizakeri/Leftsidemovies/ar41motor/2022_07_28/';
clear allpupil
gongsound = load('gong.mat','y').y;
load(fullfile(data_path,'Pupil.mat'),'Pupil')
tracker = PupilTracker(data_path);
% figure
for Trialnumber = 52:52
    user_input='';
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
%     sound(gognsound/2,1e4);
    for framei = 1:150
        tic
        if strcmp(user_input,'p')
            continue
        end
        hold off
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
%                 sound(gognsound/2,1e4);
            else
                checkparam =0;
            end
        end

        Center=reflection.Centroid;
        Centersize=reflection.MajorAxisLength;
        Center(Centersize<3,:)=0;
        [~,maxid] = max(Center(:,2));
        pupilcenter(framei,:)=pupil.Centroid;
        thiscenter(framei,:)=Center(maxid,:);
        allpupil = [allpupil;struct2table(pupil)];
        
        hold on
        shift = 4;
        cornerx = [eye_dlc_output.Ex1(framei),eye_dlc_output.Ex3(framei)]-biasx;
        cornery = [eye_dlc_output.Ey1(framei),eye_dlc_output.Ey3(framei)+shift]-biasy;
        [Intersectpupil(framei,:),pupil_line(framei,:),~,pupil_to_corner_line_distance(framei)] = findprojectedvalues (pupil.Centroid,cornerx,cornery);
%         PupilPlotter.plot_projection_lines(cornerx,cornery,eye_corner_line,perpendicular_line,Intersection,pupil_center)
        [Intersectlight(framei,:),reflection_line(framei,:),eye_corner_line(framei,:),~] = findprojectedvalues (Center(maxid,:),cornerx,cornery);
%         PupilPlotter.plot_projection_lines(cornerx,cornery,eye_corner_line,perpendicular_line,Intersection,pupil_center)
        hold off
        toc
    end
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
end
%%
hold off
trial =94;
plot(Pupil.Left.intersectlight{trial}-Pupil.Left.intersectpupil{trial}-Pupil.Left.TearDuct{trial}(1:size(Pupil.Left.intersectpupil{trial},1),:))
