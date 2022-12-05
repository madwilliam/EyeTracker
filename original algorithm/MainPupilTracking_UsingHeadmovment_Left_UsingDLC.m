%%  LoadCVSfiles
plotthis=1;
xybias=4;
for Trialnumber =1:113
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
    Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_16\';


     Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
    %     thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);

    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_LeftEye_MarchMar3shuffle1_895000_filtered.CSV']);

    thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle1_271000_filtered.CSV']);
if ~isfile(thisfilename)
    continue
end

    optsR = detectImportOptions(thisfilename);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4','Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};

    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};

    TLeft = readtable(thisfilename,optsR);
    %     TLeft2 = readtable(thisfilename);




    optsR2 = detectImportOptions(thisfilename2);
    optsR2.VariableNames={'frames','X1','Y1','P1','X2','Y2','P2','X3','Y3','P3'};
    TLeftHeadandEye = readtable(thisfilename2,optsR2);


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
    % TLeft = readtable(thisfilename,optsL);
    %
    % videoFile = VideoReader([genfolder  vidname '.avi']);


    %%

    allT = [TLeft.Ex1,TLeft.Ey1];
 mapxy =repmat(mean(allT(1:10,:)),size(allT,2),1);
DISTANCES = pdist2(mapxy,allT,'euclidean','smallest',1);

    %%
    Gaussianlightsourceremoval =2.2;
    Gaussianlightsourceremoval =1.4;
    minGaussianlightsourceremoval = 1.1;
    tic
    thisminsize = 28;
    Maxdevider=476;
    Maxdevider=210;

    Mindevider = 480;
    thismaxsize = 54;

    for ind = 1:160
                    Gaussianlightsourceremoval=1.3;
devider=494;

        if DISTANCES(ind)>50
            continue
        end


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
        if TLeft.LDOWNL1(ind)<0.99
            continue
        end
%         devider=496;

        if Maxsize>thismaxsize||Maxsize<minsize
            Maxsize=thismaxsize;
            minsize = thisminsize;
        end
                    [~,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
if ~(isempty(s))
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
end

        %             Center=stats.Centroid;
        %         Centersize=stats.MajorAxisLength;
        %         Center(Centersize<5,:)=0;
        %         [~,maxid] = max(Center(:,2));

        if ind==1
            Threshold =mean(TLeftHeadandEye.X3(1:5));
        end

        % if TLeftHeadandEye.X3(ind)<Threshold*0.95
        %   Gaussianlightsourceremoval =1.4;
        %   devider=501;
        %
        % elseif  TLeftHeadandEye.X3(ind)>Threshold*1.15
        %
        %   Gaussianlightsourceremoval =2.5;
        %     devider=501;
        % else
        %
        %
        %   Gaussianlightsourceremoval =2.5;
        %     devider=497;
        % end



        %         [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
        Ratio =  0.5250;
        Ratio =  0.48;

        %  if (size(stats.Centroid,1))>1
        %                     tf = checkifinROI(s,stats,Ratio);
        %                 while tf==1
        %
        %                     Gaussianlightsourceremoval=Gaussianlightsourceremoval*0.95;
        %                     if Gaussianlightsourceremoval<minGaussianlightsourceremoval
        %                         Gaussianlightsourceremoval = 1.8;
        %                         break
        %                     end
        %                     [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
        %
        %                     tf = checkifinROI(s,stats,Ratio);
        %
        %                     if isempty(D)
        %                         break
        %                     end
        %                 end
        %  end


        biasy = -5;
        biasx = -3;


        [~,~,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
if isempty(D)
    continue
end

        mapxy = [TLeft.Px1(ind)-biasx,TLeft.Py1(ind)-biasy];
        [~,distance(1),t] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px2(ind)-biasx,TLeft.Py2(ind)-biasy];
        [~,distance(2),t] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px3(ind)-biasx,TLeft.Py3(ind)-biasy];
        [~,distance(3),t] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px4(ind)-biasx,TLeft.Py4(ind)-biasy];
        [~,distance(4),t] = distance2curve(D(1:2,:)',mapxy);
oldsum=[];
allgaus=[];
alldevider=[];
        counter= 0;
        if sqrt(sum(distance.^2))>7
            Gaussianlightsourceremoval = 2.2;
            devider= 501;
        while sqrt(sum(distance.^2))>7
            devider=devider*0.995;
            if devider<Mindevider
                devider = 501;
                break
            end
            while sqrt(sum(distance.^2))>7
                Gaussianlightsourceremoval=Gaussianlightsourceremoval*0.95;
                if Gaussianlightsourceremoval<minGaussianlightsourceremoval
                    Gaussianlightsourceremoval = 1.8;
                    break
                end
                %             devider=497;
                counter=counter+1;

                [~,~,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
if isempty(D)
    continue
end

                mapxy = [TLeft.Px1(ind)-biasx,TLeft.Py1(ind)-biasy];
                [~,distance(1),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px2(ind)-biasx,TLeft.Py2(ind)-biasy];
                [~,distance(2),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px3(ind)-biasx,TLeft.Py3(ind)-biasy];
                [~,distance(3),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px4(ind)-biasx,TLeft.Py4(ind)-biasy];
                [~,distance(4),t] = distance2curve(D(1:2,:)',mapxy);
                oldsum(counter)=sqrt(sum(distance.^2));
                allgaus(counter)=Gaussianlightsourceremoval;
                                allgaus(counter)=Gaussianlightsourceremoval;
                                alldevider(counter)=devider;

            end
        end
        Gaussianlightsourceremoval=median(allgaus(oldsum==min(oldsum)));
        devider=median(alldevider(oldsum==min(oldsum)));
        end

        if Gaussianlightsourceremoval<minGaussianlightsourceremoval
Gaussianlightsourceremoval = minGaussianlightsourceremoval;
        end


        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,plotthis,devider,xybias,Gaussianlightsourceremoval);


        %  [Dist,I] = pdist2(repmat(mapxy,size(D(1:2,:),2),1),D(1:2,:)','euclidean','Smallest',1)

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
            title([num2str(ind) 'Distance' num2str(sum(distance.^2))] )
            xlabel([num2str(round(s.MajorAxisLength)) 'div' num2str(devider)  ' Maxgaussian =' num2str(Gaussianlightsourceremoval)])
            hold on
            X = thiscenter(ind,:);
            plot(X(1),X(2),'.b','Markersize',20)
            X = pupilcenter(ind,:);
            plot(X(1),X(2),'.g','Markersize',20)
            hold off
            frame = getframe(gcf);
            writeVideo(v,frame);
        end

        X = [TLeft.Px1(ind),TLeft.Px2(ind),TLeft.Px3(ind),TLeft.Px4(ind)];
        Y = [TLeft.Py1(ind),TLeft.Py2(ind),TLeft.Py3(ind),TLeft.Py4(ind)];
        X2 = [TLeft.Ex1(ind),TLeft.Ex2(ind),TLeft.Ex3(ind),TLeft.Ex4(ind)];
        Y2 = [TLeft.Ey1(ind),TLeft.Ey2(ind),TLeft.Ey3(ind),TLeft.Ey4(ind)];
        alldistances(ind) = sum(distance.^2);
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
    Pupil.Left.TearDuct{Trpialnumber+1}=[TLeft.Ex1,TLeft.Ey1];
    Pupil.Left.EyeBack{Trialnumber+1}=[TLeft.Ex3,TLeft.Ey3];



    close(v)
end


cd \\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_16