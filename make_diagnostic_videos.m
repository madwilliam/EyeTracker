Pupil = load(fullfile('Z:\william\test pupil','pupil.mat'),'Pupil').Pupil;
arash_Pupil = load(fullfile('Z:\afassihizakeri\rightsidemovies\ar42motor\2022_11_04','Pupil.mat'),'Pupil').Pupil;
Main_FolderRight='Z:\afassihizakeri\rightsidemovies\ar42motor\2022_11_04';
trials = ExperimentProcessor.get_trials(Main_FolderRight);
Threshold = 103;
Gaussianlightsourceremoval = 1.5;
biasx= -4;
biasy=-0;
xybias =1;
tracker = PupilTracker(Main_FolderRight);
allpupil = [];
for Trialnumber =[1,2]
        disp(Trialnumber)
        v = VideoWriter(fullfile('Z:\william\comparison',strcat(num2str(Trialnumber),'pupil_check_','.m')),'Uncompressed AVI');
        open(v)
        pupils = Pupil.Right.Pupil{Trialnumber+1};
        arashpupils = arash_Pupil.Right.Pupil{Trialnumber+1};
        if isempty(pupils) ||isempty(arashpupils)
            continue
        end
        vL = VideoReader(fullfile(Main_FolderRight,strcat(num2str(Trialnumber),'EYE.avi')));
        for framei = 1:min([numel(pupils),size(arashpupils,1)])
            pupil = pupils(framei,:);
            arash_pupil = arashpupils(framei,:);
            ImageEye = PupilTracker.readindex(vL,double(framei));
%             elipse = PupilTracker.pupil_to_elipse(pupil);
            elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
            arash_elipse = PupilTracker.get_elipse_from_fit_parameter(arash_pupil.MajorAxisLength/2,arash_pupil.MinorAxisLength/2,arash_pupil.Centroid',arash_pupil.Orientation);
            diagnostic = insertShape(ImageEye,'polygon',reshape(elipse(1:2,:),1,[]),'Color','red');
            diagnostic = insertShape(diagnostic,'polygon',reshape(arash_elipse(1:2,:) ,1,[]),'Color','green');
            writeVideo(v,diagnostic)
        end
        close(v)
end
%%