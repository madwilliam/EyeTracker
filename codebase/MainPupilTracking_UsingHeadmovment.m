%%  LoadCVSfiles
    plotthis=1;
xybias=4
for Trialnumber =263:264
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
    Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar38motor\2022_02_16\';
%     thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);

        thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_RightEye_4_4_2_pointsFeb28shuffle1_500000_filtered.CSV']);

    thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_Rightside_Feb2022_2Feb8shuffle1_100000_filtered.CSV']);


    optsR = detectImportOptions(thisfilename);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4','Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    TRight = readtable(thisfilename,optsR);
    TRight2 = readtable(thisfilename);




    optsR2 = detectImportOptions(thisfilename2);
    optsR2.VariableNames={'frames','X1','Y1','P1','X2','Y2','P2','X3','Y3','P3'};
    TRightHeadandEye = readtable(thisfilename2,optsR2);


    vL = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );
    if plotthis
    v = VideoWriter([Main_FolderRight,num2str(Trialnumber),'EYEtracked.avi'] );
    open(v);
    end
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
    Gaussianlightsourceremoval =2.2;
    Gaussianlightsourceremoval =1.4;
minGaussianlightsourceremoval = 1.1;
    tic
    thisminsize = 28;
    Maxdevider=476;
    Maxdevider=505;

    Mindevider = 465;
    thismaxsize = 54;
    for ind = 1:160
            Gaussianlightsourceremoval =1.25;



        
%         devider=496;
%         devider = 491;
devider=497;

        if ind>1
            Maxsize = pupilmaxlenght(ind-1)*1.2;
            minsize = pupilminlenght(ind-1)*0.8;

        else
            Maxsize=thismaxsize;
            minsize = thisminsize;

        end


        if Maxsize>thismaxsize||Maxsize<thisminsize
            Maxsize=thismaxsize;
            minsize = thisminsize;
        end


        ImageEye = readindex(vL,double(ind));
        if TRight.LDOWNL1(ind)<0.99
            continue
        end

%             Center=stats.Centroid;
%         Centersize=stats.MajorAxisLength;
%         Center(Centersize<5,:)=0;
%         [~,maxid] = max(Center(:,2));
       
if ind==1
Threshold =mean(TRightHeadandEye.X3(1:5));
end

if TRightHeadandEye.X3(ind)<Threshold*0.95
  Gaussianlightsourceremoval =1.4;
  devider=497;

elseif  TRightHeadandEye.X3(ind)>Threshold*1.15

  Gaussianlightsourceremoval =2.5;
    devider=497;
else


  Gaussianlightsourceremoval =2.5;
    devider=493;
end
        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);

        if isempty(D)
            continue
        end



        if minsize<thisminsize
            Maxsize=thismaxsize;
            minsize = thisminsize;
        end
        while s.MajorAxisLength>Maxsize

            devider=devider+1;
            if devider>Maxdevider
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
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
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                break
            end

        end

        while s.MajorAxisLength<minsize||s.MajorAxisLength>Maxsize

            devider=devider+1;
            if devider>Maxdevider
                s.MinorAxisLength=1;
devider = Mindevider;
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                clear s
                s.MinorAxisLength=1;
                s.MajorAxisLength=1;
                break
            end

        end
        while s.MajorAxisLength<minsize

            devider=devider-1;
            if devider<Mindevider
                break
            end
            [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
            if isempty(D)
                break
            end

        end
                while s.MinorAxisLength<minsize
        
                    devider=devider-1;
                    if devider<Mindevider
                        break
                    end
                    [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
                    if isempty(D)
                        break
                    end
        
                end
Ratio =0.525;

                while s.MajorAxisLength>Maxsize

                    devider=devider+1;
                    if devider>Maxdevider
                        break
                    end
                    [~,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
                    if isempty(D)
                        break
                    end
                end
                                    [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);
 if (size(stats.Centroid,1))>1
                    tf = checkifinROI(s,stats,Ratio);
                while tf==1
                    
                    Gaussianlightsourceremoval=Gaussianlightsourceremoval*0.95;
                    if Gaussianlightsourceremoval<minGaussianlightsourceremoval
                        Gaussianlightsourceremoval = 1.6;
                        break
                    end
                    [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,0,devider,xybias,Gaussianlightsourceremoval);

                    tf = checkifinROI(s,stats,Ratio);

                    if isempty(D)
                        break
                    end
                end
 end

        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider,xybias,Gaussianlightsourceremoval);



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
            xlabel([num2str(round(s.MajorAxisLength)) 'div' num2str(devider)  ' Maxgaussian =' num2str(Gaussianlightsourceremoval)])
            hold on
            X = thiscenter(ind,:);
            plot(X(1),X(2),'.b','Markersize',20)
            X = pupilcenter(ind,:);
            plot(X(1),X(2),'.g','Markersize',20)
            hold off

            hold off
        
        frame = getframe(gcf);
        writeVideo(v,frame);
        end
        X = [TRight.Px1(ind),TRight.Px2(ind),TRight.Px3(ind),TRight.Px4(ind)];
        Y = [TRight.Py1(ind),TRight.Py2(ind),TRight.Py3(ind),TRight.Py4(ind)];
        X2 = [TRight.Ex1(ind),TRight.Ex2(ind),TRight.Ex3(ind),TRight.Ex4(ind)];
        Y2 = [TRight.Ey1(ind),TRight.Ey2(ind),TRight.Ey3(ind),TRight.Ey4(ind)];


        [xc,yc,Pupil.Right.R{Trialnumber+1}(ind),a] = circfit(X,Y);
        [xc,yc,Pupil.Right.R2{Trialnumber+1}(ind),a] = circfit(X2,Y2);
        X=[ [TRight.Ex1(ind),TRight.Ey1(ind)]; pupilcenter(ind,:)];
        distanceall3(ind) = pdist(X,'euclidean');


       end

    toc
    % pupilcenter(ind,:)=s.Centroid;
    % pupilmaxlenght (ind)= s.MajorAxisLength;
    % pupilminlenght(ind)= s.MinorAxisLength;

    Pupil.Right.distanceall3{Trialnumber+1}=distanceall3;
    Pupil.Right.distanceall2{Trialnumber+1}=distanceall2;
    Pupil.Right.distanceall{Trialnumber+1}=distanceall;
    Pupil.Right.pupilmaxlenght{Trialnumber+1}=pupilmaxlenght;
    Pupil.Right.pupilminlenght{Trialnumber+1}=pupilminlenght;
    Pupil.Right.pupilcenter{Trialnumber+1}=pupilcenter;
    Pupil.Right.Light{Trialnumber+1}=thiscenter;
 Pupil.Right.TearDuct{Trialnumber+1}=[TRight.Ex1,TRight.Ey1];
    Pupil.Right.EyeBack{Trialnumber+1}=[TRight.Ex3,TRight.Ey3];

    

    close(v)
end


cd \\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_16