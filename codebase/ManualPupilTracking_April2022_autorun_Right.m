
clear allpupil
load gong.mat;
gognsound=y;
% biasx= 2;
%     biasy= +1;
    
    
    biasx= -1;
    biasy= -1;
Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar30motor\2022_04_21\';
cd (Main_FolderRight)
 load Pupil
xybias= 0;
for Trialnumber = [ 21:127]
%     cameraParams = load ('\\dk-server.dk.ucsd.edu\afassihizakeri\cameracalibration\cameraParamsLeftCamera.mat')
    % Trialnumber =14
%     Main_FolderRight = '\\dk-sesarver.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_16\';
%     Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
%     Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
    %     thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
    
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_LeftEye_MarchMar3shuffle1_895000_filtered.CSV']);
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_482_EyeApr26shuffle1_500000_filtered.CSV']);

%     
%     
% 
%     
%     thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle2_500000_filtered.CSV']);
%     thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_Rightside_Feb2022_2Feb8shuffle1_100000_filtered.CSV']);

    

    
    optsR = detectImportOptions(thisfilename);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4','Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};


    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','Px5','Py5','PL5','Px6','Py6','PL6','Px7','Py7','PL7','Px8','Py8','PL8','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    Tright = readtable(thisfilename,optsR);
    %     Tright2 = readtable(thisfilename);
%         Tright.Px7 = str2double(Tright.Px7);
%     Tright.Py7 = str2double(Tright.Py7);
%     Tright.PL7 = str2double(Tright.PL7);
%     Tright.Px8 = str2double(Tright.Px8);
%     Tright.Py8 = str2double(Tright.Py8);
%     Tright.PL8 = str2double(Tright.PL8);
%     Tright.LUPx1 = str2double(Tright.LUPx1);
%     Tright.LUPy1 = str2double(Tright.LUPy1);
%     Tright.LUPl1 = str2double(Tright.LUPl1);
%     Tright.LDOWNx1 = str2double(Tright.LDOWNx1);
%     Tright.LDOWNy1 = str2double(Tright.LDOWNy1);
%     Tright.LDOWNL1 = str2double(Tright.LDOWNL1);
    
    
    
%     optsR2 = detectImportOptions(thisfilename2);
%     optsR2.VariableNames={'frames','X1','Y1','P1','X2','Y2','P2','X3','Y3','P3'};
%     TrightHeadandEye = readtable(thisfilename2,optsR2);
    
    
    vL = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );
    allT = [Tright.Ex1,Tright.Ey1];
    mapxy =repmat(mean(allT(1:10,:)),size(allT,2),1);
    DISTANCES = pdist2(mapxy,allT,'euclidean','smallest',1);
    
    %%
    
    allpupil = array2table(zeros(0,4));
    allpupil.Properties.VariableNames = {'Centroid','MajorAxisLength', ...
        'MinorAxisLength','Orientation'};
    plotthis = 1;
    txt='';
    devider = 96;
    Gaussianlightsourceremoval = 1.2;
    
     
        Intersection=[];
        cp=[];
        Dy=[];
        Intersection2=[];
        cp2=[];
        c=[];
        checkparam =1;
%          sound(gognsound/2,1e4);

    for ind = 1:150
        tic
         if strcmp(txt,'p')
            continue
        end
        hold off
        
        ImageEye = readindex(vL,double(ind));
        imagesc(ImageEye)
hold on
       if ind<3

       [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
       else
           
         [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,0,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
       imagesc(ImageEye*4)
       hold on
       plot(D(1,:),D(2,:),'r')
       end
       if ind>3
      pupilarea= ( pi.*(allpupil.MinorAxisLength.*allpupil.MajorAxisLength));
      pupilarea=mean(pupilarea(end-2:end));
      thisarea =  pi.*s.MajorAxisLength.*s.MinorAxisLength;
       if thisarea>pupilarea*1.1||thisarea<pupilarea*0.9
       checkparam =1;
      [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);

%        sound(gognsound/2,1e4);
       else
       checkparam =0;

       end
       end
       if checkparam
       prompt = "is eye edge position correct? Y/N [Y]: ";
        txt = input(prompt,"s");
        if strcmp(txt,'p')
            continue
        end
        if strcmp(txt,'n')
            
        
            [x, y] = ginput(1);
            Tright.Ex3(ind) = x+biasx+2;
            Tright.Ey3(ind) = y+biasy-10;
        
            
            
            [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);
        end
        Center=stats.Centroid;
        Centersize=stats.MajorAxisLength;
        Center(Centersize<5,:)=0;
        [~,maxid] = max(Center(:,2));
        Center(maxid,:);
        hold on
        plot(Center(maxid,1),Center(maxid,2),'b.','Markersize',25)
        
        prompt = "is pupil fine: ";
        txt = input(prompt,"s");
        while strcmp(txt,'n')
            
            
            prompt = ['devider ' num2str(devider) ' ?'];
            txt = input(prompt,"s");
            devider = str2num(txt);
            prompt =  ['Gaussianlight ' num2str(Gaussianlightsourceremoval) ' ?'];
            txt = input(prompt,"s");
            Gaussianlightsourceremoval = str2num(txt);
            [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,devider,xybias,Gaussianlightsourceremoval,biasx,biasy);

            title(num2str(ind))
            prompt = "better? [n/p(to exsit) /else] ";
            txt = input(prompt,"s");
            if strcmp(txt,'p')
                break
            end
        end
        if strcmp(txt,'p')
            txt = '';
            continue
        end
        
       end
        Center=stats.Centroid;
        Centersize=stats.MajorAxisLength;
        Center(Centersize<5,:)=0;
        [~,maxid] = max(Center(:,2));
        pupilcenter(ind,:)=s.Centroid;
        thiscenter(ind,:)=Center(maxid,:);
        allpupil = [allpupil;struct2table(s)];
        
        hold on
   
        
        [Intersection(ind,:),cp(ind,:),~,Dy(ind)] = findprojectedvalues (s.Centroid,[Tright.Ex1(ind),Tright.Ex3(ind)-2]-biasx,[Tright.Ey1(ind),Tright.Ey3(ind)+10]-biasy,1);
        [Intersection2(ind,:),cp2(ind,:),c(ind,:),~] = findprojectedvalues (Center(maxid,:),[Tright.Ex1(ind),Tright.Ex3(ind)-2]-biasx,[Tright.Ey1(ind),Tright.Ey3(ind)+10]-biasy,1);
        hold off
        
       toc 
    end
    Pupil.Right.intersectpupil{Trialnumber+1}=Intersection;
    Pupil.Right.intersectlight{Trialnumber+1}=Intersection2;
    Pupil.Right.DY{Trialnumber+1}=Dy;
    Pupil.Right.EYEhorizontalaxis{Trialnumber+1}=c;
    Pupil.Right.Pupil{Trialnumber+1}=allpupil;
    Pupil.Right.pupilcenter{Trialnumber+1}=pupilcenter;
    Pupil.Right.Light{Trialnumber+1}=thiscenter;
    Pupil.Right.TearDuct{Trialnumber+1}=[Tright.Ex3,Tright.Ey3];
    Pupil.Right.EyeBack{Trialnumber+1}=[Tright.Ex1,Tright.Ey1];
    save Pupil Pupil
    
end
%%
hold off
trial =94;
 plot(Pupil.Left.intersectlight{trial}-Pupil.Left.intersectpupil{trial}-Pupil.Left.TearDuct{trial}(1:size(Pupil.Left.intersectpupil{trial},1),:))
