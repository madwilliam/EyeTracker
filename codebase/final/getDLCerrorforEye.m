
clear allpupil
load gong.mat;
gognsound=y;
biasx= -1;
biasy= -2;

Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar38motor\2022_04_21\';
Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_04_21\';

cd (Main_FolderRight)

for Trialnumber = 7
    %     cameraParams = load ('\\dk-server.dk.ucsd.edu\afassihizakeri\cameracalibration\cameraParamsLeftCamera.mat')
    % Trialnumber =14
    %     Main_FolderRight = '\\dk-sesarver.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_16\';
    %     Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
    %     Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
    %     thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
    
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_LeftEye_MarchMar3shuffle1_895000_filtered.CSV']);
    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_482_EyeApr26shuffle1_500000_filtered.CSV']);
    
    %     9EYEDLC_resnet50_482_EyeApr26shuffle1_500000_filtered
    
    
    
    thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle2_500000_filtered.CSV']);
    thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle1_271000_filtered.CSV']);
    
    
    
    optsR = detectImportOptions(thisfilename);
    optsR.VariableNames={'frames','Ex3','Ey3','El3','Ex2','Ey2','El2','Ex1','Ey1','El1','Ex4','Ey4','El4','Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    
    
    optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','Px5','Py5','PL5','Px6','Py6','PL6','Px7','Py7','PL7','Px8','Py8','PL8','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    %     Tright = readtable(thisfilename,optsR,'format','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
    Tright = readtable(thisfilename,optsR);
    Tright.Px7 = str2double(Tright.Px7);
    Tright.Py7 = str2double(Tright.Py7);
    Tright.PL7 = str2double(Tright.PL7);
    Tright.Px8 = str2double(Tright.Px8);
    Tright.Py8 = str2double(Tright.Py8);
    Tright.PL8 = str2double(Tright.PL8);
    Tright.LUPx1 = str2double(Tright.LUPx1);
    Tright.LUPy1 = str2double(Tright.LUPy1);
    Tright.LUPl1 = str2double(Tright.LUPl1);
    Tright.LDOWNx1 = str2double(Tright.LDOWNx1);
    Tright.LDOWNy1 = str2double(Tright.LDOWNy1);
    Tright.LDOWNL1 = str2double(Tright.LDOWNL1);
    
    T = Tright;
    %     TLeft2 = readtable(thisfilename);
    
    
    
    
    optsR2 = detectImportOptions(thisfilename2);
    optsR2.VariableNames={'frames','X1','Y1','P1','X2','Y2','P2','X3','Y3','P3'};
    TLeftHeadandEye = readtable(thisfilename2,optsR2);
    
    
    vL = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );
    allT = [TLeft.Ex1,TLeft.Ey1];
    mapxy =repmat(mean(allT(1:10,:)),size(allT,2),1);
    DISTANCES = pdist2(mapxy,allT,'euclidean','smallest',1);
    
    %%
    NewX1=[];
    ALLY1=[];

  for ind = 1:100
        tic
     
        hold off
        
        ImageEye = readindex(vL,double(ind));
        
        imagesc(ImageEye*8)
        hold on
        plot(T.Ex1(ind)-biasx,T.Ey1(ind)-biasy,'g.','Markersize',10)
        plot(T.Ex3(ind)-biasx,T.Ey3(ind)-biasy,'m.','Markersize',10)
        
        plot([T.Ex1(ind)-biasx T.Ex3(ind)-biasx],[T.Ey1(ind)-biasy T.Ey3(ind)+10],'g--','Markersize',25)
        
        axis image
        
        
            [x, y] = ginput(1);
            NewX1(ind) = x;
            NewY1(ind) = y;
            
%            [x, y] = ginput(1);
% 
%             NewX2(ind) = x;
%             NewY2(ind) = y;
    end
    
    
   ALLY{Trialnumber} = NewY1;
   ALLX{Trialnumber} = NewX1;
end


%%
counter = 0
for trial=[ 1 2 3 7 8 9]
    counter=counter+1



NewY1=ALLY{trial} ;
NewX1=ALLX{trial} ;
    thisfilename = ([Main_FolderRight num2str(trial) 'EYEDLC_resnet50_482_EyeApr26shuffle1_500000_filtered.CSV']);

  optsR.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
        ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','Px5','Py5','PL5','Px6','Py6','PL6','Px7','Py7','PL7','Px8','Py8','PL8','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
    %     Tright = readtable(thisfilename,optsR,'format','%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f');
    Tright = readtable(thisfilename,optsR);
    Tright.Px7 = str2double(Tright.Px7);
    Tright.Py7 = str2double(Tright.Py7);
    Tright.PL7 = str2double(Tright.PL7);
    Tright.Px8 = str2double(Tright.Px8);
    Tright.Py8 = str2double(Tright.Py8);
    Tright.PL8 = str2double(Tright.PL8);
    Tright.LUPx1 = str2double(Tright.LUPx1);
    Tright.LUPy1 = str2double(Tright.LUPy1);
    Tright.LUPl1 = str2double(Tright.LUPl1);
    Tright.LDOWNx1 = str2double(Tright.LDOWNx1);
    Tright.LDOWNy1 = str2double(Tright.LDOWNy1);
    Tright.LDOWNL1 = str2double(Tright.LDOWNL1);
    
    T = Tright;


biasx=-4;
figure
subplot 211
plot(NewX1)
hold on
plot(T.Ex1(1:100)-biasx)
subplot 212

plot((T.Ex1(1:100)-biasx-NewX1').^2)




biasy=-4
figure
subplot 211

plot(NewY1)
hold on
plot(T.Ey1(1:100)-biasy)

subplot 212

plot((T.Ey1(1:100)-biasy-NewY1').^2)


Lacrimal_caruncle.DLC.X(counter,:)=NewX1;
Lacrimal_caruncle.DLC.Y(counter,:)=NewY1;
Lacrimal_caruncle.Manual.X(counter,:)=T.Ex1(1:100)-biasx;
Lacrimal_caruncle.Manual.Y(counter,:)=T.Ey1(1:100)-biasy;


end
