classdef PupilPlotter
   methods(Static)
       function plot_pupil_fit(ax,ImageEye,elipse,pupil,eye_dlc_output,framei)
            biasx= -4;
            biasy= -2;
            imshow(ImageEye*8,'Parent', ax)
            hold(ax,'on')
            plot(ax,elipse(1,:),elipse(2,:),'r','LineWidth',2)
            plot(ax,pupil.Centroid(1),pupil.Centroid(2),'g.','Markersize',25)
            plot(ax,eye_dlc_output.Ex1(framei)-biasx,eye_dlc_output.Ey1(framei)-biasy,'g.','Markersize',25)
            plot(ax,eye_dlc_output.Ex3(framei)-biasx,eye_dlc_output.Ey3(framei)-biasy,'m.','Markersize',25)
            plot(ax,(eye_dlc_output.Ex3(framei)+eye_dlc_output.Ex1(framei)-2*biasx)./2,(eye_dlc_output.Ey3(framei)+eye_dlc_output.Ey1(framei)-2*biasy)./2,'b.','Markersize',25)
            plot(ax,[eye_dlc_output.Ex1(framei)-biasx eye_dlc_output.Ex3(framei)-biasx],[eye_dlc_output.Ey1(framei)-biasy eye_dlc_output.Ey3(framei)-biasy],'g--','Markersize',25)
            plot(ax,eye_dlc_output.Px1(framei)-biasx,eye_dlc_output.Py1(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px2(framei)-biasx,eye_dlc_output.Py2(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px4(framei)-biasx,eye_dlc_output.Py4(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px6(framei)-biasx,eye_dlc_output.Py6(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px8(framei)-biasx,eye_dlc_output.Py8(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px5(framei)-biasx,eye_dlc_output.Py5(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px3(framei)-biasx,eye_dlc_output.Py3(framei)-biasy,'r.','Markersize',25)
            plot(ax,eye_dlc_output.Px7(framei)-biasx,eye_dlc_output.Py7(framei)-biasy,'r.','Markersize',25)
            hold(ax,'off')
            title(ax,['frame = ' num2str(framei)])
       end

       function plot_reflection_center(ax,reflection)
            Center=reflection.Centroid;
            Centersize=reflection.MajorAxisLength;
            Center(Centersize<3,:)=0;
            [~,maxid] = max(Center(:,2));
            hold on
            plot(ax,Center(maxid,1),Center(maxid,2),'b.','Markersize',25)
       end

       function plot_projection_lines(cornerx,cornery,eye_corner_line,perpendicular_line,Intersection,pupil_center)
            x = linspace(min(cornerx),max(cornerx),10);
            y = polyval([eye_corner_line(2) eye_corner_line(1)],x);
            plot(x,y ,'--g')
            plot(cornerx(1),cornery(1),'.r')
            plot(cornerx(2),cornery(2),'.r')
            plot((cornerx(2)+cornerx(1))./2,(cornery(2)+cornery(1))./2,'.g','markersize',20)
            plot(Intersection(1),Intersection(2),'.m','markersize',20)
            plot(pupil_center(1),pupil_center(2),'.g','markersize',20)
            x = linspace(min([pupil_center(1) Intersection(1) ]),max([pupil_center(1) Intersection(1)]),10);
            y = polyval([perpendicular_line(2) perpendicular_line(1)],x);
            plot(x,y ,'--b')
            axis square
       end
   end
end