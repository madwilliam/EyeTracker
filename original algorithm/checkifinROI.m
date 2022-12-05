function tf = checkifinROI(s,stats,Ratio)


%  roi = images.roi.Ellipse(gca,'Center',s.Centroid,'Semiaxes',[s.MinorAxisLength s.MajorAxisLength],'RotationAngle',deg2rad(s.Orientation));
 roi = images.roi.Ellipse(gca,'Center',s.Centroid,'Semiaxes',[s.MajorAxisLength s.MinorAxisLength] *Ratio,'RotationAngle',mod(s.Orientation, 360));
Center=stats.Centroid;
Centersize=stats.MajorAxisLength;
Center(Centersize<5,:)=0;
[~,maxid] = min(Center(:,2));
Theoutercenter=Center(maxid,:);% tf = inROI(ROI,x,y)
tf = inROI(roi,Theoutercenter(1),Theoutercenter(2));
hold off