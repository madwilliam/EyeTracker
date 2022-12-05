function boundaries = star_burst(image,center,prominance)
    [xsize,ysize,~] =size(image);
    nsteps = 10;
    angles = linspace(0,pi,nsteps);
    offset = nsteps;
    slopes = tan(angles);
    i=1;
    boundaries = zeros(2*numel(slopes),2);
    flipped = false;
    to_flip = false;
    for slopei = slopes
        last_flipped = flipped;
        flipped = false;
        xis = 1:xsize;
        line_equation = @(x) slopei*x-slopei*center(1)+center(2);
        yis = line_equation(xis);
        yis = floor(yis);
        isvalid = arrayfun(@(x) x>0 && x <xsize,yis);
        if ~all(isvalid)
            yis = 1:ysize;
            line_equation = @(y) (y+slopei*center(1)-center(2))/slopei;
            xis = floor(line_equation(yis));
            flipped = true;
        end
        if (last_flipped==true && flipped ==false)||to_flip==true
            to_flip=true;
        else
            to_flip = false;
        end
        trace = [yis',xis'];
        inds = sub2ind([xsize,ysize],trace(:,1),trace(:,2));
        line = double(image(inds));
        dif = abs(line(2:end)-line(1:end-1));
        [~,locs] = findpeaks(dif,1:numel(dif),'MinPeakProminence',prominance);
        x_points = trace(:,2);
        y_points = trace(:,1);
        peak_to_center_difference = locs-(center(1));
        peak_id = find(diff(sign(peak_to_center_difference)));
        start_point = locs(peak_id);
        end_point = locs(peak_id+1);
        if i==8
            disp('')
        end
        if to_flip
            boundaries(i,:) = [x_points(start_point),y_points(start_point)];
            boundaries(i+offset,:) = [x_points(end_point),y_points(end_point)];
        else
            boundaries(i,:) = [x_points(end_point),y_points(end_point)];
            boundaries(i+offset,:) = [x_points(start_point),y_points(start_point)];
        end
        i=i+1;
    end
end