%%  LoadCVSfiles
for Trialnumber =180:264
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
plotthis=0;
tic
for ind = 1:100
ImageEye = readindex(vR,double(ind));
devider=485;
if TRight.lowerL(ind)<0.99
    continue
end

[stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider);
if isempty(D)
    continue
end
while s.MajorAxisLength>50||s.MajorAxisLength<30||s.MinorAxisLength<20
 devider=devider+0.5;   
 if devider>495
     break
 end
 [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TRight,plotthis,devider);
if isempty(D)
    break 
end
end
if isempty(D)
    continue
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
if plotthis

title(num2str(ind))
xlabel(num2str(round(s.MajorAxisLength)))
hold off
end
end
toc
% pupilcenter(ind,:)=s.Centroid;
% pupilmaxlenght (ind)= s.MajorAxisLength;
% pupilminlenght(ind)= s.MinorAxisLength;


Pupil.Right.distanceall2{Trialnumber+1}=distanceall2;
Pupil.Right.distanceall{Trialnumber+1}=distanceall;
Pupil.Right.pupilmaxlenght{Trialnumber+1}=pupilmaxlenght;
Pupil.Right.pupilminlenght{Trialnumber+1}=pupilminlenght;
Pupil.Right.pupilcenter{Trialnumber+1}=pupilcenter;
Pupil.Right.Light{Trialnumber+1}=thiscenter;

end