function [Intersection,perpendicular_line,eye_corner_line,center_to_line_distance] = findprojectedvalues (pupil_center,cornerx,cornery)
    % it calculated the projection of z to xy line and finds the values of
    % projected z point into xy line and its distance from the line
    % find the equation for the line between two points x1 y1
    eye_corner_line = [[1; 1]  cornerx(:)]\cornery(:);                        % Calculate Parameter Vector
    slope_m = eye_corner_line(2);
    intercept_b = eye_corner_line(1);
    % find the equation for the Perpendicular line that passes the z
    perpendicular_line(2) = -1./slope_m;
    perpendicular_line(1)= pupil_center(2)-(pupil_center(1).*perpendicular_line(2));
    % find the intersect of two lines
    Intersection(1) = (perpendicular_line(1)-eye_corner_line(1))./(eye_corner_line(2)-perpendicular_line(2));
    Intersection(2) = Intersection(1)*slope_m+intercept_b;
    center_to_line_distance = sqrt(abs(Intersection(2)-pupil_center(2)).^2+abs(Intersection(1)-pupil_center(1)).^2);
end