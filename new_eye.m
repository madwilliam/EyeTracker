ImageEye_grey = rgb2gray(histeq(ImageEye));
[mask] = get_light_reflection_mask(framei,ImageEye_grey,eye_dlc_output,xybias);
[X_avg,Y_avg] = PupilTracker.get_pupil_center(eye_dlc_output,framei);
pupil_center_intensity = ImageEye_grey(floor(X_avg),floor(Y_avg));
ImageEye_grey(find(mask))=pupil_center_intensity;
image = imgaussfilt(ImageEye_grey,1);
boundaries = star_burst(image,[X_avg, Y_avg],3);
[xsize,ysize] = size(ImageEye_grey);
pupil_mask = poly2mask(boundaries(:,1),boundaries(:,2),xsize,ysize);
pupil = PupilTracker.fit_pupil_from_pupil_mask(pupil_mask);
elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
[~,reflection,~] = findlightreflection(framei,ImageEye,eye_dlc_output);
%%
[reflection,pupil,elipse,pupil_mask] = PupilTracker.get_eye_info_starburst(ImageEye,eye_dlc_output,framei);
PupilPlotter.plot_pupil_fit(gca,ImageEye,elipse,pupil,eye_dlc_output,framei)
%%
[xsize,ysize] = size(ImageEye_grey);
mask = poly2mask(boundaries(:,1),boundaries(:,2),xsize,ysize);
se = strel('disk',10);
closeBW = imclose(mask,se);
windowSize=5; 
kernel=ones(windowSize)/windowSize^2;
result=conv2(single(closeBW),kernel,'same');

%%
boundaries = star_burst(image,[X_avg, Y_avg],2);
figure
hold on
imagesc(ImageEye_grey)
scatter(boundaries(:,1),boundaries(:,2),500,'r.')
hold off
%%
distance = sum(diff(boundaries).^2,2).^0.5;
%%
% tracei = 3;
% trace = traces{tracei};
figure
hold on
imagesc(ImageEye_grey)
scatter(trace(:,1),trace(:,2),500,'r.')
hold off
%%
figure
% trace = traces{tracei};
inds = sub2ind([xsize,ysize],trace(:,1),trace(:,2));
line = double(image(inds));
dif = line(2:end)-line(1:end-1);
clf
hold on 
plot(trace(:,1),line)
plot(trace(1:end-1,1),abs(dif)*10)
hold off
%%
hold on 
plot(line)
plot(dif*10)
hold off

%%
figure
hold on
i=1;
imagesc(ImageEye_grey)
for pointi = boundaries'
    scatter(pointi(1),pointi(2),500,'r.')
    text(pointi(1),pointi(2),num2str(i),'FontSize',30)
    i=i+1;
end
hold off
%%
mask = poly2mask(boundaries(:,1),boundaries(:,2),xsize,ysize);
%%

hold on
imagesc(result>0.5)
scatter(boundaries(:,1),boundaries(:,2),500,'r.')
hold off
% result=result>0.5;
