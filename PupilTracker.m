classdef PupilTracker
    properties
        data_path
        files
        names
        dlcs
        trial_numbers
        eye_dlcs
        eye_trial_numbers
    end

    methods
        function self = PupilTracker(data_path)
            self.data_path = data_path;
            self.files = dir(data_path);
            self.names = {self.files.name};
            dlc_pattern = digitsPattern+"DLC";
            is_dlc = cellfun(@(x) contains(x,dlc_pattern)&&contains(x,'filtered.csv'),self.names);
            self.dlcs = self.names(is_dlc);
            self.trial_numbers = cellfun(@(x) PupilTracker.extract_trial_number(x,dlc_pattern,3),self.dlcs);
            eye_dlc_pattern = digitsPattern+"EYEDLC";
            is_eye_dlc = cellfun(@(x) contains(x,eye_dlc_pattern)&&contains(x,'filtered.csv'),self.names);
            self.eye_dlcs = self.names(is_eye_dlc);
            self.eye_trial_numbers = cellfun(@(x) PupilTracker.extract_trial_number(x,eye_dlc_pattern,6),self.eye_dlcs);
        end

        function trial_dlc = get_triali_dlc_path(self,Trialnumber)
            is_trial = self.trial_numbers==Trialnumber;
            trial_dlc = self.dlcs(is_trial);
            trial_dlc = trial_dlc{1};
            trial_dlc = ([self.data_path trial_dlc]);
        end

        function eye_dlc = get_eye_dlc_path(self,Trialnumber)
            is_trial = self.eye_trial_numbers==Trialnumber;
            eye_dlc = self.eye_dlcs(is_trial);
            eye_dlc = eye_dlc{1};
            eye_dlc = fullfile(self.data_path,eye_dlc);
        end

        function eye_dlc_output = get_eye_dlc_output(self,Trialnumber)
            eye_dlc = self.get_eye_dlc_path(Trialnumber);
            eye_dlc_info = detectImportOptions(eye_dlc);
            eye_dlc_info.VariableNames={'frames','Ex1','Ey1','El1','Ex2','Ey2','El2','Ex3','Ey3','El3','Ex4','Ey4','El4' 'Px1','Py1','PL1'...
                ,'Px2','Py2','PL2','Px3','Py3','PL3','Px4','Py4','PL4','Px5','Py5','PL5','Px6','Py6','PL6','Px7','Py7','PL7','Px8','Py8','PL8','LUPx1','LUPy1','LUPl1','LDOWNx1','LDOWNy1','LDOWNL1'};
            eye_dlc_output = readtable(eye_dlc,eye_dlc_info);
        end
    end
    methods(Static)
        function result  = extract_trial_number(x,pat,nskip)
            substring = extract(x,pat);
            result = str2num(substring{1}(1:end-nskip));
        end

        function elipse = get_elipse(X,Y)
            [Z, A, B, alpha] = fitellipse( [X',Y']);
            elipse = PupilTracker.get_elipse_from_fit_parameter(A,B,Z,alpha);
        end

        function elipse = get_elipse_from_fit_parameter(A,B,Z,alpha)
            Ratio=1;
            theta = linspace(0,2*pi);
            col = (A*Ratio)*cos(theta);
            row = (B*Ratio)*sin(theta);
            M = makehgtform('translate',[Z', 0],'zrotate',deg2rad(-1*alpha));
            elipse = M*[col;row;zeros(1,numel(row));ones(1,numel(row))];
        end

        function rotated_ellipse = pupil_to_elipse(pupil)
            theta_r         = linspace(0,2*pi);
            ellipse_x_r     = pupil.Centroid(1) + pupil.MajorAxisLength*cos( theta_r );
            ellipse_y_r     = pupil.Centroid(2) + pupil.MinorAxisLength*sin( theta_r );
            rotated_ellipse = pupil.R * [ellipse_x_r;ellipse_y_r];
        end

        function pupil_mask = get_pupil_mask_from_elipse(ImageEye,elipse)
            [xq,yq]= find(ones(size(ImageEye)));
            pupil_mask = zeros(size(ImageEye));
            in = inpolygon(xq,yq,elipse(2,:),elipse(1,:));
            pupil_mask(in)=1;
            pupil_mask = rgb2gray(pupil_mask);
        end

        function reflection_mask = get_reflection_mask(ImageEye,reflection,GuassFilterSize)
            image_size = size(ImageEye);
            image_size(end)=[];
            reflection_mask = zeros(image_size);
            thisind = sub2ind(image_size,round(reflection.Centroid(:,2)),round(reflection.Centroid(:,1)));
            reflection_mask(thisind)=1;
            reflection_mask = imgaussfilt(reflection_mask,GuassFilterSize);
        end

        function outputFrame=readindex(videoSource,frameNumber)
            info=get(videoSource);
            videoSource.CurrentTime=(frameNumber-1)./info.FrameRate;
            outputFrame=readFrame(videoSource);
        end
        function lower_spot = get_lower_spot(eye_dlc_output,i)
            xybias=4;
            lower_spot = [floor(eye_dlc_output.LDOWNy1(i))+xybias,floor(eye_dlc_output.LDOWNx1(i))+xybias];
        end

        function upper_spot = get_upper_spot(eye_dlc_output,i)
            xybias=4;
            upper_spot = [floor(eye_dlc_output.LUPy1(i))+xybias,floor(eye_dlc_output.LUPx1(i))+xybias];
        end

        function [X,Y] = get_pupil_outline(eye_dlc_output,ind)
            biasx= -4;
            biasy= -2;
            X = [eye_dlc_output.Px1(ind),eye_dlc_output.Px2(ind),eye_dlc_output.Px3(ind),eye_dlc_output.Px4(ind),eye_dlc_output.Px5(ind),eye_dlc_output.Px6(ind),eye_dlc_output.Px7(ind),eye_dlc_output.Px8(ind)]-biasx-2;
            Y = [eye_dlc_output.Py1(ind),eye_dlc_output.Py2(ind),eye_dlc_output.Py3(ind),eye_dlc_output.Py4(ind),eye_dlc_output.Py5(ind),eye_dlc_output.Py6(ind),eye_dlc_output.Py7(ind),eye_dlc_output.Py8(ind)]-biasy+2;
        end

        function [x_avg,y_avg] = get_pupil_center(eye_dlc_output,ind)
            [X,Y] = PupilTracker.get_pupil_outline(eye_dlc_output,ind);
            x_avg = mean(X);
            y_avg = mean(Y);
        end

        function [pupil,outputs] = fit_pupil(reflection_removed_image,Threshold,pupil_mask)
            reflection_removed_image = imcomplement(reflection_removed_image);
            Iblur1 = imgaussfilt(reflection_removed_image,1);
            pupil_mask= bwareafilt(imbinarize(imbinarize(Iblur1/Threshold,'adaptive').*imbinarize(pupil_mask)),1,'largest',4);
            [pupil,outputs] = PupilTracker.fit_pupil_from_pupil_mask(pupil_mask);
        end

        function mask = find_local_region(pupil_mask,center)
            %             CC = bwconncomp(BW);
            %             image_size = size(BW);
            %             center_index = sub2ind(image_size,region_center(1),region_center(2));
            %             is_center_components = cellfun(@(x)  any(abs(x-center_index)<=5) ,CC.PixelIdxList);
            %             is_center_components = cellfun(@(x)  any(abs(x-center_index)<=25) ,CC.PixelIdxList);
            %
            %             assert(sum(is_center_components)==1)
            %             center_components = CC.PixelIdxList{is_center_components};
            %             mask = zeros(size(BW));
            %             mask(center_components)=1;
            CC = bwconncomp(pupil_mask);
            empties = cellfun(@numel,CC.PixelIdxList);
            CC.PixelIdxList(empties<100)=[];
            image_size = size(pupil_mask);
%             center_index = sub2ind(image_size,center(1),center(2));
            for jj=1:numel(CC.PixelIdxList)
                [a, b]=ind2sub(image_size,CC.PixelIdxList{jj});
                thisdist(jj)= min((center(1)-a).^2+(center(2)-b).^2);
            end
[~,thisminind]=min(thisdist);
            center_components = CC.PixelIdxList{thisminind};
            mask = zeros(size(pupil_mask));
            mask(center_components)=1;
        end

        function mask = get_pupil_mask(ImageEye,framei,eye_dlc_output,Threshold,GuassFilterSize)
           EYEGray = rgb2gray(histeq(ImageEye));
%             EYEGray = rgb2gray((ImageEye));
             edgeThreshold = 0.2;
             amount = 0.1;
             EYEGray = localcontrast(EYEGray,edgeThreshold,amount);
            pupil_mask = EYEGray<Threshold;
            pupil_mask = imfill(pupil_mask,'holes');
            [X,Y] = PupilTracker.get_pupil_outline(eye_dlc_output,framei);
            center = round(mean([X',Y']));
            mask = PupilTracker.find_local_region(pupil_mask,center);
            se = strel('disk',GuassFilterSize);
            mask = imclose(mask,se);
        end

        function [pupil,outputs] = fit_pupil_from_pupil_mask(pupil_mask)
            pupil_edge=edge(pupil_mask,'canny');
            pupil_edge = bwmorph(pupil_edge, 'bridge');
            outputs = imfill(pupil_edge,'holes');
            outputs= bwareafilt(outputs,1,'largest',4);
            pupil = regionprops(outputs,{'Centroid','Orientation','MajorAxisLength','MinorAxisLength'});
        end

        function reflection_removed_image = remove_reflection(ImageEye,reflection,GuassFilterSize,edgeThreshold,amount)
            reflection_mask = PupilTracker.get_reflection_mask(ImageEye,reflection,GuassFilterSize);
            ImageEye2=(localcontrast(ImageEye ,edgeThreshold, amount));
            reflection_removed_image =imcomplement((ImageEye2-uint8(reflection_mask*10000))*20);
        end

        function [reflection,pupil,elipse,pupil_mask] = get_eye_info_starburst(ImageEye,eye_dlc_output,framei,threshold)
%             xybias=4;
            ImageEye_grey = rgb2gray(histeq(ImageEye));
            [mask] = get_light_reflection_mask(framei,ImageEye_grey,eye_dlc_output);
            [X_avg,Y_avg] = PupilTracker.get_pupil_center(eye_dlc_output,framei);
            pupil_center_intensity = ImageEye_grey(floor(X_avg),floor(Y_avg));
            ImageEye_grey(find(mask))=pupil_center_intensity;
            image = imgaussfilt(ImageEye_grey,1);
            boundaries = star_burst(image,[X_avg, Y_avg],threshold);
            [xsize,ysize] = size(ImageEye_grey);
            pupil_mask = poly2mask(boundaries(:,1),boundaries(:,2),xsize,ysize);
            pupil = PupilTracker.fit_pupil_from_pupil_mask(pupil_mask);
            elipse = PupilTracker.get_elipse_from_fit_parameter(pupil.MajorAxisLength/2,pupil.MinorAxisLength/2,pupil.Centroid',pupil.Orientation);
            [~,reflection,~] = findlightreflection(framei,ImageEye,eye_dlc_output);
        end
        function [B]=findlightreflection_mask(i,ImageEye,eye_dlc_output)
            GuassFilterSize=6;
            I = rgb2gray(ImageEye*2);
            image_size = size(I);
            reflection_mask = zeros(image_size);
            ind = PupilTracker.get_lower_spot(eye_dlc_output,i);
            if ~ all(isnan(ind))
                reflection_mask(ind(1),ind(2))=1;
            end
            ind = PupilTracker.get_upper_spot(eye_dlc_output,i);
            if ~ all(isnan(ind))
                reflection_mask(ind(1),ind(2))=1;
            end
            B = imgaussfilt(reflection_mask,GuassFilterSize);
            B = B>0;
        end
    end
end