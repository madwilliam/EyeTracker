%%
function [mask]= get_light_reflection_mask(i,ImageEye,eye_dlc_output,xybias)
    threshold = adaptthresh(ImageEye);
    BW = imbinarize(ImageEye,threshold);
    CC = bwconncomp(BW);
    image_size = size(ImageEye);
    lower_spot = [floor(eye_dlc_output.LDOWNy1(i))+xybias,floor(eye_dlc_output.LDOWNx1(i))+xybias];
    lower_index = sub2ind(image_size,lower_spot(1),lower_spot(2));
    upper_spot = [floor(eye_dlc_output.LUPy1(i))+xybias,floor(eye_dlc_output.LUPx1(i))+xybias];
    upper_index = sub2ind(image_size,upper_spot(1),upper_spot(2));
    is_lower_components = cellfun(@(x) any(lower_index==x) ,CC.PixelIdxList);
    is_upper_components = cellfun(@(x) any(upper_index==x) ,CC.PixelIdxList);
    assert(sum(is_lower_components)==1)
    assert(sum(is_upper_components)==1)
    lower_components = CC.PixelIdxList{is_lower_components};
    upper_components = CC.PixelIdxList{is_upper_components};
    mask = zeros(size(ImageEye));
    mask(lower_components)=1;
    mask(upper_components)=1;
    mask = imdilate(mask, strel('disk', 2));
end

