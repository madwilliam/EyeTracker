cameraParams = load ('\\dk-server.dk.ucsd.edu\afassihizakeri\cameracalibration\cameraParamsLeftCamera.mat')
Trialnumber =14
Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_16\';
Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
Main_FolderRight = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar30motor\2022_02_18\';
    %     thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);

    thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_LeftEye_MarchMar3shuffle1_895000_filtered.CSV']);

    thisfilename2 = ([Main_FolderRight num2str(Trialnumber) 'DLC_resnet50_SideviewLeft_Feb2022Feb8shuffle2_500000_filtered.CSV']);


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
    allT = [TLeft.Ex1,TLeft.Ey1];
 mapxy =repmat(mean(allT(1:10,:)),size(allT,2),1);
DISTANCES = pdist2(mapxy,allT,'euclidean','smallest',1);

%%
plotthis = 1;
for ind = 1:100
    
hold off
devider = 495;
Gaussianlightsourceremoval = 1.6;

ImageEye = readindex(vL,double(ind));
% [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider,xybias,Gaussianlightsourceremoval);
% worldPoints1 = pointsToWorld(cameraParams, cameraParams.RotationMatrices, t, imagePoints1);





[stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,plotthis,devider,xybias,Gaussianlightsourceremoval);
 
prompt = "is eye edge position correct? Y/N [Y]: ";
txt = input(prompt,"s");
if strcmp(txt,'n')

[x, y] = ginput(1);  
TLeft.Ex3(ind) = x;
TLeft.Ey3(ind) = y;

[stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,plotthis,devider,xybias,Gaussianlightsourceremoval);
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
if strcmp(txt,'n')

    
prompt = "devider 495?: ";
txt = input(prompt,"s");
devider = txt;
prompt = "Gaussianlight 1.6?: ";
txt = input(prompt,"s");
Gaussianlightsourceremoval = txt;



[stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,plotthis,devider,xybias,Gaussianlightsourceremoval);
end  
  
  



end

