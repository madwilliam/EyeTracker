function [stats,s,D]=ExtractEYEinfo(ImageEye,ind,eye_dlc_output,plotthis,Threshold,xybias,GuassFilterSize2,biasx,biasy)
    Ratio=1.4;
    ImageEye= PupilTracker.remove_reflection(ImageEye,eye_dlc_output,ind);
    ImageEye = rgb2gray(ImageEye);
    [X,Y] = PupilTracker.get_pupil_outline(eye_dlc_output,ind);
    X_avg = mean(X);
    Y_avg = mean(Y);
    % fit ellisoid around on pulil DLC points
    [zg, ag, bg, alphag] = fitellipse( [X',Y']);
    theta = linspace(0,2*pi);
    col = (ag*Ratio)*cos(theta);
    row = (bg*Ratio)*sin(theta);
    M = makehgtform('translate',[zg', 0],'zrotate',deg2rad(-1*alphag));
    D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
    [xq,yq]= find(ones(size(ImageEye)));
    thismask = zeros(size(ImageEye));
    in = inpolygon(xq,yq,D(2,:),D(1,:));
    thismask(in)=1;
    I =imcomplement(ImageEye);
    % Binarize
    Iblur1 = imgaussfilt(I,1);
    BW2= bwareafilt(imbinarize(imbinarize(Iblur1/Threshold,'adaptive').*imbinarize(thismask)),1,'largest',4);
    test=edge(BW2,'canny');
    test = bwmorph(test, 'bridge'); % Use this to connect the pixels
    outputs = imfill(test,'holes');
    outputs= bwareafilt(outputs,1,'largest',4);
    s = regionprops(outputs,{'Centroid','Orientation','MajorAxisLength','MinorAxisLength'});
    if ~isempty(s)
        theta = linspace(0,2*pi);
        col = (s.MajorAxisLength/2)*cos(theta);
        row = (s.MinorAxisLength/2)*sin(theta);
        M = makehgtform('translate',[s.Centroid, 0],'zrotate',deg2rad(-1*s.Orientation));
        D = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
        if plotthis
            imshow(ImageEye*8)
            hold on
            plot(D(1,:),D(2,:),'r','LineWidth',2)
            plot( s.Centroid(1),s.Centroid(2),'g.','Markersize',25)
            plot(eye_dlc_output.Ex1(ind)-biasx,eye_dlc_output.Ey1(ind)-biasy,'g.','Markersize',25)
            plot(eye_dlc_output.Ex3(ind)-biasx,eye_dlc_output.Ey3(ind)-biasy,'m.','Markersize',25)
            plot((eye_dlc_output.Ex3(ind)+eye_dlc_output.Ex1(ind)-2*biasx)./2,(eye_dlc_output.Ey3(ind)+eye_dlc_output.Ey1(ind)-2*biasy)./2,'b.','Markersize',25)
            plot([eye_dlc_output.Ex1(ind)-biasx eye_dlc_output.Ex3(ind)-biasx],[eye_dlc_output.Ey1(ind)-biasy eye_dlc_output.Ey3(ind)-biasy],'g--','Markersize',25)
            plot(eye_dlc_output.Px1(ind)-biasx,eye_dlc_output.Py1(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px2(ind)-biasx,eye_dlc_output.Py2(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px4(ind)-biasx,eye_dlc_output.Py4(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px6(ind)-biasx,eye_dlc_output.Py6(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px8(ind)-biasx,eye_dlc_output.Py8(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px5(ind)-biasx,eye_dlc_output.Py5(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px3(ind)-biasx,eye_dlc_output.Py3(ind)-biasy,'r.','Markersize',25)
            plot(eye_dlc_output.Px7(ind)-biasx,eye_dlc_output.Py7(ind)-biasy,'r.','Markersize',25)
            hold off
            title(['frame = ' num2str(ind)])
        end
    else
        D = [];
    end
end