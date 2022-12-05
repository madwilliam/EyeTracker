function [F,TF]=fillmissingtrace (A,X)


% A = +AlingedData.LeftWhisker(trials(trial),:);
% [F,TF] = fillmissing(A,'linear','SamplePoints',X);

[F,TF] = fillmissing(A,'spline','SamplePoints',X);
this_start = find(~isnan(A),1,'first');
this_end = find(~isnan(A),1,'last');
thesenans = isnan(A);
thesenans(this_start:this_end-1)=0;

F(thesenans)=NaN;

thesemissingx = smooth([0 abs(diff(F))>4],15);
F(logical(ceil(thesemissingx)))=NaN;
this_end = find(~isnan(F),1,'last');
thesenans = isnan(F);
thesenans(this_start:this_end-1)=0;
%  [F,TF] = fillmissing(F,'linear','SamplePoints',X);
 [F,TF] = fillmissing(F,'spline','SamplePoints',X);
this_end = find(~isnan(A),1,'last');

F(thesenans)=NaN;

