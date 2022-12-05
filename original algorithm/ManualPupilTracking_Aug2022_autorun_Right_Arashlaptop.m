% clear allvariables 
clear all

% load gong sound for the error 
load gong.mat;
gognsound=y;

%
biasx= -4;
biasy=-0;
xybias =1;
new8eye = 1;

ifload=0;
    
Main_FolderRight='\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar42motor\2022_11_04\';

cd (Main_FolderRight)




%%
if ifload == 1
load Pupil
load ALLpoint3d

emptyCells = find(cellfun(@isempty,Pupil.Right.EyeBack))-1;
   emptyCells=4:200 

% emptyCells(emptyCells==49)=[];
% emptyCells(emptyCells==124)=[];
% emptyCells(emptyCells==149)=[];
else
   emptyCells=1:200 
end

for Trialnumber =[ emptyCells];

    
   DLC_EYEextract_name = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eye 482_EPLMay24shuffle3_500000_filtered.CSV']);
   %DLC_Sideview_name = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle1_271000_filtered.CSV']);
   DLC_Sideview_name = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle2_500000_filtered.CSV']);

    
    
    optsR = detectImportOptions(DLC_EYEextract_name);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4','Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
  if   new8eye==1
   optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','Px5','Py5','PL5','Px6','Py6','PL6','Px7','Py7','PL7','Px8','Py8','PL8','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
%     Tright = readtable(DLC_EYEextract_name,optsR,'format','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
Tright = readtable(DLC_EYEextract_name,optsR);
% Tright.Px7 = str2double(Tright.Px7);
% Tright.Py7 = str2double(Tright.Py7);
% Tright.PL7 = str2double(Tright.PL7);
% Tright.Px8 = str2double(Tright.Px8);
% Tright.Py8 = str2double(Tright.Py8);
% Tright.PL8 = str2double(Tright.PL8);
% Tright.LUPx1 = str2double(Tright.LUPx1);
% Tright.LUPy1 = str2double(Tright.LUPy1);
% Tright.LUPl1 = str2double(Tright.LUPl1);
% Tright.LDOWNx1 = str2double(Tright.LDOWNx1);
% Tright.LDOWNy1 = str2double(Tright.LDOWNy1);
% Tright.LDOWNL1 = str2double(Tright.LDOWNL1);

Tright.Ey3=Tright.Ey3+5;




  else
      optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
      Tright = readtable(DLC_EYEextract_name,optsR);

Tright.Px7 = (Tright.Px3);
Tright.Py7 = (Tright.Py3);
Tright.PL7 = (Tright.PL3);
Tright.Px8 = (Tright.Px4);
Tright.Py8 = (Tright.Py4);
Tright.PL8 = (Tright.PL4);
Tright.Px5 = (Tright.Px1);
Tright.Py5 = (Tright.Py1);
Tright.PL5 = (Tright.PL1);
Tright.Px6 = (Tright.Px2);
Tright.Py6 = (Tright.Py2);
Tright.PL6 = (Tright.PL2);   
    
  end

    
    vL = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );
%     allT = [Tright.Ex1,Tright.Ey1];
%     mapxy =repmat(mean(allT(1:10,:)),size(allT,2),1);
%     DISTANCES = pdist2(mapxy,allT,'euclidean','smallest',1);
    
    %%
    
    allpupil = array2table(zeros(0,4));
    allpupil.Properties.VariableNames = {'Centroid','MajorAxisLength', ...
        'MinorAxisLength','Orientation'};
    plotthis = 1;
    txt='';
    Threshold = 103;
    Gaussianlightsourceremoval = 1.5;
    
     
        Intersection=[];
        cp=[];
        Dy=[];
        Intersection2=[];
        cp2=[];
        c=[];
        checkparam =1;
         sound(gognsound/10,1e4);

    for ind = 1:200
        tic
         if strcmp(txt,'p')
            continue
        end
        hold off
        
        ImageEye = readindex(vL,double(ind));
       if ind<4

       [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,Threshold,xybias,Gaussianlightsourceremoval,biasx,biasy);
       else
           
       [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,0,Threshold,xybias,Gaussianlightsourceremoval,biasx,biasy);
       imagesc(ImageEye*4)
       hold on
       plot(D(1,:),D(2,:),'r')
       end
       if ind>3
      pupilarea= ( pi.*(allpupil.MinorAxisLength.*allpupil.MajorAxisLength));
      pupilarea=mean(pupilarea(end-2:end));
      thisarea =  pi.*s.MajorAxisLength.*s.MinorAxisLength;
      
        Center=stats.Centroid;
        Centersize=stats.MajorAxisLength;
        Center(Centersize<5,:)=0;
        [~,maxid] = max(Center(:,2));
%         Center(maxid,:);
     [Intersection2(ind,:),cp2(ind,:),c(ind,:),~] = findprojectedvalues (Center(maxid,:),[Tright.Ex1(ind),Tright.Ex3(ind)]-biasx,[Tright.Ey1(ind),Tright.Ey3(ind)]-biasy,1);

       if thisarea>pupilarea*1.1||thisarea<pupilarea*0.9||c(ind,1)<mean(c(ind-3:ind-1,1))*0.9||c(ind,1)>mean(c(ind-3:ind-1,1))*1.1
       checkparam =1;
      [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,Threshold,xybias,Gaussianlightsourceremoval,biasx,biasy);

       sound(gognsound/10,1e4);
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
            Tright.Ex3(ind) = x+biasx;
            Tright.Ey3(ind) = y+biasy;
            
            [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,Threshold,xybias,Gaussianlightsourceremoval,biasx,biasy);
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
            
            
            prompt = ['Threshold ' num2str(Threshold) ' ?'];
            txt = input(prompt,"s");
            Threshold = str2num(txt);
            prompt =  ['Gaussianlight ' num2str(Gaussianlightsourceremoval) ' ?'];
            txt = input(prompt,"s");
            Gaussianlightsourceremoval = str2num(txt);
            
            [stats,s,D]=ExtractEYEinfo(ImageEye,ind,Tright,plotthis,Threshold,xybias,Gaussianlightsourceremoval,biasx,biasy);
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
   
        
        [Intersection(ind,:),cp(ind,:),~,Dy(ind)] = findprojectedvalues (s.Centroid,[Tright.Ex1(ind),Tright.Ex3(ind)]-biasx,[Tright.Ey1(ind),Tright.Ey3(ind)]-biasy,1);
        [Intersection2(ind,:),cp2(ind,:),c(ind,:),~] = findprojectedvalues (Center(maxid,:),[Tright.Ex1(ind),Tright.Ex3(ind)]-biasx,[Tright.Ey1(ind),Tright.Ey3(ind)]-biasy,1);
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
%     Trialnumber = Trialnumber + 1;
end
%%
hold off
trial =43;
 plot(Pupil.Right.intersectlight{trial}-Pupil.Right.intersectpupil{trial}-Pupil.Right.TearDuct{trial}(1:size(Pupil.Right.intersectpupil{trial},1),:))
