%%  LoadCVSfiles

for Trialnumber =73
    % Main_Folder = 'F:\ar38\2022_02_08\';
    % Main_FolderLeft = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_08\'
    % thisfilename = ([Main_FolderLeft num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
    % optsL = detectImportOptions(thisfilename);
    % optsL.VariableNames={'frames', 'x1','y1','L1'...
    %     ,'x2','y2','L2','x3','y3','L3','x4','y4','L4','x5','y5','L5','x6','y6','L6','x7','y7','L7','x8','y8','L8','upeyex','upeyey','upeyeL','downeyex','downeyey','downeyeL','tearx','teary','tearl'...
    %     ,'upperx','uppery','upperL','lowerx','lowery','lowerL'};
    %  TLeft = readtable(thisfilename,optsL);
    %  vL = VideoReader([Main_FolderLeft,num2str(Trialnumber),'EYE.avi'] );
    % Main_Folder = 'F:\ar38\2022_02_08\';
    Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar30motor\2022_02_18\';
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
    
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_RightEye_4_4_2_pointsFeb28shuffle1_500000_filtered.CSV']);
%     9EYEDLC_resnet50_RightEye_4_4_2_pointsFeb28shuffle1_500000_filtered
%         thisfilename = ([Main_FolderRight ]);
% fullFileName = fullfile(Main_FolderRight, [num2str(Trialnumber) 'EYEDLC_resnet50_RightEye_4_4_2_pointsFeb28shuffle1_500000_filtered.CSV'])

    % 9EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered
    optsR = detectImportOptions(thisfilename);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    
    TLeft = readtable(thisfilename,optsR);
    
    vL = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );
    v = VideoWriter([Main_FolderRight,num2str(Trialnumber),'EYEtracked.avi'] );
    open(v);
    % thisfilename = (['\\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_08\' num2str(Trialnumber+1) 'videoDLC_resnet50_Topview3435_FEB22Feb6shuffle1_343000_filtered.CSV']);
    % optsL = detectImportOptions(thisfilename);
    % optsL.VariableNames={'frames', 'x1','y1','L1'...
    %     ,'x2','y2','L2'};
    % Ttop = readtable(thisfilename,optsL);
    % thisfilename = (['F:\ar38\2022_02_08\' num2str(Trialnumber) 'DLC_resnet50_Rightside_Feb2022_2Feb8shuffle1_100000_filtered.CSV']);
    %
    % optsR = detectImportOptions(thisfilename);
    % optsR.VariableNames={'frames', 'x1','y1','L1'...
    %     ,'x2','y2','L2','x3','y3','L3','x4','y4','L4','x5','y5','L5','x6','y6','L6','x7','y7','L7','x8','y8','L8','upeyex','upeyey','upeyeL','downeyex','downeyey','downeyeL','tearx','teary','tearl'...
    %     ,'upperx','uppery','upperL','lowerx','lowery','lowerL'};
    % TRight = readtable(thisfilename,optsL);
    %
    % videoFile = VideoReader([genfolder  vidname '.avi']);
    
    
    %%
    %%
    Gaussianlightsourceremoval =1.6;
    plotthis=1;
    tic
    thisminsize = 14
    Maxdevider=490;
    Mindevider = 460;
    thismaxsize = 36
    for ind = 1:150
        devider=475;
        
        ImageEye = readindex(vL,double(ind));
        if TLeft.LDOWNL1(ind)<0.99
            continue
        end
        
        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
        
        if isempty(D)
            continue
        end
        if ind>1
            Maxsize = pupilmaxlenght(ind-1)*1.15;
        minsize = pupilmaxlenght(ind-1)*0.85;

        else
            Maxsize=thismaxsize;
            minsize = thisminsize;

        end


         if Maxsize>thismaxsize||Maxsize<minsize
Maxsize=thismaxsize;
            minsize = thisminsize;
        end
        while s.MajorAxisLength>Maxsize
            
            devider=devider+1;
            if devider>Maxdevider
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                break
            end
        end
        if isempty(D)
            continue
        end
        
        while s.MajorAxisLength<minsize
            
            devider=devider-1;
            if devider<Mindevider
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                break
            end
            
        end
        
        while s.MajorAxisLength<minsize||s.MajorAxisLength>Maxsize
            
        devider=devider+1;
        if devider>Maxdevider
                            s.MinorAxisLength=1;

            break
        end
        [~,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
        if isempty(D)
           clear s
            s.MinorAxisLength=1;
            break
        end

        end
          while s.MinorAxisLength<minsize*0.9

            devider=devider+1;
            if devider>Maxdevider
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                break
            end

        end
        
        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,plotthis,devider,xybias,Gaussianlightsourceremoval);
        
        
        
        if isempty(D)
            continue
        end
        
        Center=stats.Centroid;
        Centersize=stats.MajorAxisLength;
        Center(Centersize<5,:)=0;
        [~,maxid] = max(Center(:,2));
        thiscenter(ind,:)=Center(maxid,:);
        pupilcenter(ind,:)=s.Centroid;
        pupilmaxlenght (ind)= s.MajorAxisLength;
        pupilminlenght(ind)= s.MinorAxisLength;
        X=[ thiscenter(ind,:); pupilcenter(ind,:)];
        distanceall(ind) = pdist(X,'euclidean');
        [~,ind2]=max(D(1,:));
        X=[ thiscenter(ind,:); [D(1,ind2),D(2,ind2)]];
        distanceall2(ind) = pdist(X,'euclidean');
        if plotthis
            title(num2str(ind))
            xlabel([num2str(round(s.MajorAxisLength)) 'div' num2str(devider)])
            hold on
            X = thiscenter(ind,:);
            plot(X(1),X(2),'.b','Markersize',20)
            X = pupilcenter(ind,:);
            plot(X(1),X(2),'.g','Markersize',20)
            hold off
            
            hold off
        end
        frame = getframe(gcf);
        writeVideo(v,frame);
        
        X = [TLeft.Px1(ind),TLeft.Px2(ind),TLeft.Px3(ind),TLeft.Px4(ind)];
        Y = [TLeft.Py1(ind),TLeft.Py2(ind),TLeft.Py3(ind),TLeft.Py4(ind)];
        X2 = [TLeft.Ex1(ind),TLeft.Ex2(ind),TLeft.Ex3(ind),TLeft.Ex4(ind)];
        Y2 = [TLeft.Ey1(ind),TLeft.Ey2(ind),TLeft.Ey3(ind),TLeft.Ey4(ind)];
        
        
        [xc,yc,Pupil.Left.R{Trialnumber+1}(ind),a] = circfit(X,Y);
        [xc,yc,Pupil.Left.R2{Trialnumber+1}(ind),a] = circfit(X2,Y2);
        X=[ [TLeft.Ex1(ind),TLeft.Ey1(ind)]; pupilcenter(ind,:)];
        distanceall3(ind) = pdist(X,'euclidean');
    end
    
    toc
    % pupilcenter(ind,:)=s.Centroid;
    % pupilmaxlenght (ind)= s.MajorAxisLength;
    % pupilminlenght(ind)= s.MinorAxisLength;
    
    Pupil.Left.distanceall3{Trialnumber+1}=distanceall3;
    Pupil.Left.distanceall2{Trialnumber+1}=distanceall2;
    Pupil.Left.distanceall{Trialnumber+1}=distanceall;
    Pupil.Left.pupilmaxlenght{Trialnumber+1}=pupilmaxlenght;
    Pupil.Left.pupilminlenght{Trialnumber+1}=pupilminlenght;
    Pupil.Left.pupilcenter{Trialnumber+1}=pupilcenter;
    Pupil.Left.Light{Trialnumber+1}=thiscenter;
    
    close(v)
end