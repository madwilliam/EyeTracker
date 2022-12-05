biasx= -4;
biasy= -2;
xybias=4;
plotthis = 1;
data_path = '/net/dk-server/afassihizakeri/Leftsidemovies/ar41motor/2022_07_28/';
clear allpupil
gongsound = load('gong.mat','y').y;
load(fullfile(data_path,'Pupil.mat'),'Pupil')
tracker = PupilTracker(data_path);
for Trialnumber = 52:52
    user_input='';
    devider = 150;
    Gaussianlightsourceremoval = 1.2;
    Intersection=[];
    cp=[];
    Dy=[];
    Intersection2=[];
    cp2=[];
    c=[];
    checkparam =1;
    eye_dlc_output = tracker.get_eye_dlc_output(Trialnumber);
    allpupil = array2table(zeros(0,4));
    allpupil.Properties.VariableNames = {'Centroid','MajorAxisLength', ...
        'MinorAxisLength','Orientation'};
%     sound(gongsound/2,1e4);
    for ind = 1:150
        tic
        if strcmp(user_input,'p')
            continue
        end
        hold off
        ImageEye = PupilTracker.readindex(vL,double(ind));
        if ind<4
            [stats,s,elipse]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
        else
            [stats,s,elipse]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,0,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
            imagesc(ImageEye*4)
            hold on
            plot(elipse(1,:),elipse(2,:),'r')
        end
        if ind>3
            pupilarea= ( pi.*(allpupil.MinorAxisLength.*allpupil.MajorAxisLength));
            pupilarea=mean(pupilarea(end-2:end));
            thisarea =  pi.*s.MajorAxisLength.*s.MinorAxisLength;
            if thisarea>pupilarea*1.1||thisarea<pupilarea*0.9
                checkparam =1;
                [stats,s,elipse]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
                sound(gongsound/2,1e4);
            else
                checkparam =0;
            end
        end
        if checkparam
            prompt = "is eye edge position correct? Y/N [Y]: ";
            user_input = input(prompt,"s");
            if strcmp(user_input,'p')
                continue
            end
            if strcmp(user_input,'n')
                [x, y] = ginput(1);
                eye_dlc_output.Ex3(ind) = x+biasx;
                eye_dlc_output.Ey3(ind) = y+biasy;
                [stats,s,elipse]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
            end
            Center=stats.Centroid;
            Centersize=stats.MajorAxisLength;
            Center(Centersize<3,:)=0;
            [~,maxid] = max(Center(:,2));
            Center(maxid,:);
            hold on
            plot(Center(maxid,1),Center(maxid,2),'b.','Markersize',25)
            prompt = "is pupil fine: ";
            user_input = input(prompt,"s");
            while strcmp(user_input,'n')
                prompt = ['devider ' num2str(devider) ' ?'];
                user_input = input(prompt,"s");
                devider = str2num(user_input);
                prompt =  ['Gaussianlight ' num2str(Gaussianlightsourceremoval) ' ?'];
                user_input = input(prompt,"s");
                Gaussianlightsourceremoval = str2num(user_input);
                [stats,s,elipse]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
                prompt = "better? [n/p(to exsit) /else] ";
                user_input = input(prompt,"s");
                if strcmp(user_input,'p')
                    break
                end
            end
            if strcmp(user_input,'p')
                user_input = '';
                continue
            end
        end
        Center=stats.Centroid;
        Centersize=stats.MajorAxisLength;
        Center(Centersize<3,:)=0;
        [~,maxid] = max(Center(:,2));
        pupilcenter(ind,:)=s.Centroid;
        thiscenter(ind,:)=Center(maxid,:);
        allpupil = [allpupil;struct2table(s)];
        hold on
        shift = 4;
        [Intersection(ind,:),cp(ind,:),~,Dy(ind)] = findprojectedvalues (s.Centroid,[eye_dlc_output.Ex1(ind),eye_dlc_output.Ex3(ind)]-biasx,[eye_dlc_output.Ey1(ind),eye_dlc_output.Ey3(ind)+shift]-biasy,1);
        [Intersection2(ind,:),cp2(ind,:),c(ind,:),~] = findprojectedvalues (Center(maxid,:),[eye_dlc_output.Ex1(ind),eye_dlc_output.Ex3(ind)]-biasx,[eye_dlc_output.Ey1(ind),eye_dlc_output.Ey3(ind)+shift]-biasy,1);
        hold off
        toc
    end
    Pupil.Left.intersectpupil{Trialnumber+1}=Intersection;
    Pupil.Left.intersectlight{Trialnumber+1}=Intersection2;
    Pupil.Left.DY{Trialnumber+1}=Dy;
    Pupil.Left.EYEhorizontalaxis{Trialnumber+1}=c;
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
