%%  LoadCVSfiles
Trialnumber = 172;
% Main_Folder = 'F:\ar38\2022_02_08\';
Main_FolderLeft = '\\dk-server.dk.ucsd.edu\afassihizakeri\Leftsidemovies\ar38motor\2022_02_08'
thisfilename = ([Main_FolderLeft num2str(Trialnumber) 'EYEDLC_resnet50_Eyedata6Feb6shuffle1_300000_filtered.CSV']);
optsL = detectImportOptions(thisfilename);
optsL.VariableNames={'frames', 'x1','y1','L1'...
    ,'x2','y2','L2','x3','y3','L3','x4','y4','L4','x5','y5','L5','x6','y6','L6','x7','y7','L7','x8','y8','L8','upeyex','upeyey','upeyeL','downeyex','downeyey','downeyeL','tearx','teary','tearl'...
    ,'upperx','uppery','upperL','lowerx','lowery','lowerL'};

TLeft = readtable(thisfilename,optsL);
thisfilename = (['\\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_08\' num2str(Trialnumber+1) 'videoDLC_resnet50_Topview3435_FEB22Feb6shuffle1_343000_filtered.CSV']);
optsL = detectImportOptions(thisfilename);
optsL.VariableNames={'frames', 'x1','y1','L1'...
    ,'x2','y2','L2'};
Ttop = readtable(thisfilename,optsL);
thisfilename = (['F:\ar38\2022_02_08\' num2str(Trialnumber) 'DLC_resnet50_Rightside_Feb2022_2Feb8shuffle1_100000_filtered.CSV']);

optsR = detectImportOptions(thisfilename);
optsR.VariableNames={'frames', 'x1','y1','L1'...
    ,'x2','y2','L2','x3','y3','L3','x4','y4','L4','x5','y5','L5','x6','y6','L6','x7','y7','L7','x8','y8','L8','upeyex','upeyey','upeyeL','downeyex','downeyey','downeyeL','tearx','teary','tearl'...
    ,'upperx','uppery','upperL','lowerx','lowery','lowerL'};
TRight = readtable(thisfilename,optsL);
    
videoFile = VideoReader([genfolder  vidname '.avi']);

%% Get values for a frame

i=60;
hold off
ImageEye=x175EYE(i).cdata;
im2 = readindex(v1,double(Frames(i)));

X = [TLeft.x1(i),TLeft.x2(i),TLeft.x3(i),TLeft.x4(i),TLeft.x5(i),TLeft.x6(i),TLeft.x7(i),TLeft.x8(i)];
Y = [TLeft.y1(i),TLeft.y2(i),TLeft.y3(i),TLeft.y4(i),TLeft.y5(i),TLeft.y6(i),TLeft.y7(i),TLeft.y8(i)]
imagesc(ImageEye)
hold on
 scatter(X,Y,800,'.')
 scatter(TLeft.lowerx(i),TLeft.lowery(i),800,'.')
 axis image
 
 
 %%
 GuassFilterSize=9
 I = rgb2gray(newimage);

Thissize = size(I);
% Thissize(entd)=1;
% make a image the size of im2
thisim = zeros(Thissize);
% make whisker point white 
ind = sub2ind(Thissize,floor(Y),floor(X));
thisim(ind(~isnan(ind)))=1;
% use guassina filtering to expand the points 
B = imgaussfilt(thisim,GuassFilterSize);
BW = imbinarize(B);
% fined the bounderies 
newimage = uint8(BW).*ImageEye;
%%
% I = rgb2gray(newimage);

hold off
BW2 = imbinarize(newimage,0.032);
% BW2=BW2(:,:,3);
imagesc(newimage)


J = imcomplement(newimage);
Rmin = 15;
Rmax = 30;
 [centersDark, radiiDark] = imfindcircles(J,[Rmin Rmax],'ObjectPolarity','bright','Sensitivity',0.992,'EdgeThreshold',0.7);

 Rmin = 3;
Rmax = 1000;
 [centersBright, radiiBright] = imfindcircles(newimage,[Rmin Rmax],'ObjectPolarity','bright');

 viscircles(centersBright, radiiBright,'Color','b');
 viscircles(centersDark, radiiDark,'Color','r');
 
 %%
 for  i=1:150
 coeff = 11;
 
  ImageEye=x175EYE(i).cdata;
newimage = uint8(BW).*ImageEye;

 [D, s]=getpupil(newimage,coeff);
 X = [TLeft.x1(i),TLeft.x2(i),TLeft.x3(i),TLeft.x4(i),TLeft.x5(i),TLeft.x6(i),TLeft.x7(i),TLeft.x8(i)];
Y = [TLeft.y1(i),TLeft.y2(i),TLeft.y3(i),TLeft.y4(i),TLeft.y5(i),TLeft.y6(i),TLeft.y7(i),TLeft.y8(i)];
hold on
 scatter(X,Y,800,'.b');
 scatter(TLeft.lowerx(i),TLeft.lowery(i),800,'g.');
 axis image
 Rmax = 10;
 Rmin=2;
 [centersBright, radiiBright] = imfindcircles(newimage,[Rmin Rmax],'ObjectPolarity','bright','Sensitivity',0.992,'EdgeThreshold',0.4);
 d=[];
 for j=1:numel(radiiBright)
 X=[centersBright(j,1),centersBright(j,2);TLeft.lowerx(i),TLeft.lowery(i)];
 d(j) = pdist(X,'euclidean');
 end
 if sum(d<8)>1
     [~,ind]=min(d);
      thiscenter(i,:) =centersBright( ind,:);
 else
 thiscenter(i,:) =centersBright( d<8,:);
 end
 pupilcenter(i,:)=s.Centroid;
 pupilmaxlenght (i)= s.MajorAxisLength;
 pupilminlenght(i)= s.MinorAxisLength;

  X=[ thiscenter(i,:); pupilcenter(i,:)];
 distanceall(i) = pdist(X,'euclidean');
[~,ind]=max(D(1,:));
  X=[ thiscenter(i,:); [D(1,ind),D(2,ind)]];

 distanceall2(i) = pdist(X,'euclidean');


 viscircles(centersBright, radiiBright,'Color','b');
 hold off
 
 end
%%
D(1,:),D(2,:)



newimage = uint8(BW).*ImageEye;


%%
subplot (3,1,2)
distanceall (86:88)=NaN;
distanceall2 (86:88)=NaN;

plot(medfilt1(distanceall(1:140),5),'r')


hold on
plot(medfilt1(distanceall2(1:140),5),'b')

%%

subplot (3,1,1)
hold off
yyaxis left
 plot(Ttop.x1)
% hold on
% plot(Tside.x1)
% 
 yyaxis right
% hold off

plot(Ttop.y1)
hold on
plot(Tside.y1)

 %%
 subplot (3,1,3)

 %%
 
 GuassFilterSize=9
 I = rgb2gray(newimage);
 coeff=10

Thissize = size(I);
% Thissize(entd)=1;
% make a image the size of im2
thisim = zeros(Thissize);
% make whisker point white 
ind = sub2ind(Thissize,floor(Y),floor(X));
thisim(ind(~isnan(ind)))=1;
% use guassina filtering to expand the points 
B = imgaussfilt(thisim,GuassFilterSize);
BW = imbinarize(B);
% fined the bounderies 
newimage = uint8(BW).*ImageEye;
D=getpupil(newimage,coeff);

