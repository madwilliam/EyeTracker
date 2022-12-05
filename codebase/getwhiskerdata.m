
%     Mirror176videoR

THISx = ['trace ' 'I:\topview\ar38motor\2022_02_08\Mirror176videoR.whiskers'];
THISy = ['trace ' 'I:\topview\ar38motor\2022_02_08\Mask176videoL.whiskers'];
%     THISx2 = ['       measure --face right '  genfolder  vidname 'L.whiskers '  genfolder  vidname 'L.measurements               '];
THISY2 = ['       measure --face right '  'I:\topview\ar38motor\2022_02_08\Mask176videoL.whiskers'  '  I:\topview\ar38motor\2022_02_08\Mask176videoL.measurements               '];
 THISx2 = ['       measure --face right '  'I:\topview\ar38motor\2022_02_08\Mirror176videoR.whiskers'  '   I:\topview\ar38motor\2022_02_08\Mirror176videoR.measurements               '];

  status3 = system(THISx2);
   status4 = system(THISY2);

measurementsR = LoadMeasurements('I:\topview\ar38motor\2022_02_08\Mirror176videoR.measurements');
measurementsL = LoadMeasurements('I:\topview\ar38motor\2022_02_08\Mask176videoL.measurements');
% [whisker,whiskerformat] = LoadWhiskers(whiskerfile);
TMR = struct2table(measurementsR);
TML = struct2table(measurementsL);
% T2 = struct2table(whisker);
TWR = struct2table(LoadWhiskers('I:\topview\ar38motor\2022_02_08\Mirror176videoR.whiskers'));
TWL = struct2table(LoadWhiskers('I:\topview\ar38motor\2022_02_08\Mask176videoL.whiskers'));

%%

subplot(3,1,3)
hold off
plot(medfilt1(TMR.angle,5),'r')
hold on
plot(medfilt1(TML.angle,1),'g')
