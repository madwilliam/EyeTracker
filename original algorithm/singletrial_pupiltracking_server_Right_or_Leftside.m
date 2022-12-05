%%  LoadCVSfiles
Trialnumber = 105;
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
thisfilename = ([Main_FolderRight num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
optsR = detectImportOptions(thisfilename);
optsR.VariableNames={'frames', 'x1','y1','L1'...
    ,'x2','y2','L2','x3','y3','L3','x4','y4','L4','x5','y5','L5','x6','y6','L6','x7','y7','L7','x8','y8','L8','upeyex','upeyey','upeyeL','downeyex','downeyey','downeyeL','tearx','teary','tearl'...
    ,'upperx','uppery','upperL','lowerx','lowery','lowerL'};

 TRight = readtable(thisfilename,optsR);
 
  vR = VideoReader([Main_FolderRight,num2str(Trialnumber),'EYE.avi'] );

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
plotthis=1;

for ind = 1:200
ImageEye = readindex(vR,double(ind));
devider=490;


[stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider);

while s.MajorAxisLength>44||s.MajorAxisLength<30
 devider=devider+0.5;   
 [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider);
   
end
Center=stats.Centroid;
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
title(num2str(ind))
xlabel(num2str(round(s.MajorAxisLength)))

 end