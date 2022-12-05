%% for ar38 18 02 
thislinewidth=1
% good trials 16  22 25
figure
thismaxtime = 10
thesetrials = [1 2 3 6 9 10 11 18 19 20];
[~,thisid]=sort(thismax);


Colorcode = jet(100);
% Colorcode(thisid,:)=jet(100);
AnData=[]
for i=1:20
thiscondition= AlingedData.Trialype==1;
ColorCode = 'r-';
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
trial =i;

trials = find(thiscondition);
XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];

A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:500),20));
[SmoothEye,~]=fillmissingtrace (A,X(1:500));

thisdiff=getdiffmovment(diff(SmoothEye)*400,10);

[AnData.Eye.Maxv(i), AnData.Eye.Maxvtime(i)]= max(thisdiff(160:240));

AnData.Eye.minangle(i)= min(SmoothEye(160:230));
AnData.Eye.maxangle(i)= max(SmoothEye(160:230));


[thismax(i)]=A(230);

A = (getdiffmovment(AlingedData.Headangle(trials(trial),1:500),20));
[SmoothHead,~]=fillmissingtrace (A,X(1:500));

thisdiff=getdiffmovment(diff(SmoothHead)*400,10);
[AnData.Head.Maxv(i), AnData.Head.Maxvtime(i)]= max(thisdiff(160:240));
AnData.Head.initialangle(i) = mean(SmoothHead(find(abs(SmoothHead)>0,5,'first')));
AnData.Eye.initialangle(i) = mean(SmoothHead(find(abs(SmoothEye)>0,5,'first')));


AnData.Head.minangle(i)= min(SmoothHead(160:230));
AnData.Head.maxangle(i)= max(SmoothHead(160:230));



A = (getdiffmovment(AlingedData.LeftWhisker(trials(trial),:),20));
[thismax(i)]=A(215);

subplot (5,1,1)
plot(X,getdiffmovment(AlingedData.Headangle(trials(trial),:)-90,20),'color',Colorcode(i,:),'LineWidth',thislinewidth)

    
ylim([-20 70])

% yyaxis right
%  plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
% ylim([-100 500])

subplot (5,1,2)
  yyaxis left
plot(X(1:500),SmoothEye,'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
ylim([-20 20])

  yyaxis right
%  if  thismax(i)<thismaxtime
% 
 plot(X(2:500),getdiffmovment(diff(SmoothEye)*400,20),'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
%  else
%      
%  plot(X(2:300),diff(getdiffmovment(F(1:300),20)*400),'b-','LineWidth',thislinewidth)
% 
%  end
 
subplot (5,1,3)
A = getdiffmovment(AlingedData.LeftWhisker(trials(trial),:),10);
[F,~]=fillmissingtrace (A,X);
 plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
 [AnData.Leftwhisker(i,:)]=F(160:280);

 ylim([-50 60])
% plot(X(2:end),-getdiffmovment(diff(F),10),'color',Colorcode(i,:),'LineWidth',thislinewidth)


subplot (5,1,4)

A = getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),10);
[F,~]=fillmissingtrace (A,X);
 plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
[AnData.Rightwhisker(i,:)]=F(160:280);

% plot(X(2:end),-getdiffmovment(diff(F),10),'color',Colorcode(i,:),'LineWidth',thislinewidth)

 ylim([-50 75])

subplot (5,1,5)

  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','b','Markersize',5)
%   plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color','r')
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'d','color','r')
[AnData.theta(i),AnData.rho(i)] = cart2pol(XYtrajectory(1),XYtrajectory(2));

% AnData.

for j=1:4
    subplot (5,1,j)
    xlim([-0.2 0.6])
end


for j=1:5
    subplot (5,1,j)
    
figurecorrectionOPTO(gca,[0.01 0.01],12)
hold on

axis normal
end
end
%%


%  AllData.Rightturn.Front=AnData;
 AllData.Rightturn.Back=AnData;


%% plot Angle vs head max velocity
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;

plot(XX.Eye.Maxv,XX.Head.Maxv,'.b','markersize',20)
hold on
plot(YY.Eye.Maxv,YY.Head.Maxv,'.r','markersize',20)

XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;

plot(-XX.Eye.Maxv,-XX.Head.Maxv,'.b','markersize',20)
hold on
plot(-YY.Eye.Maxv,-YY.Head.Maxv,'.r','markersize',20)
xlim([-800 800])
ylim([-800 800])
plot([-800 800],[0  0],'k')
plot([0  0],[-800 800],'k')
xlabel('Eye Maxi velocity °/s')
ylabel('Head Maxi velocity °/s')
figurecorrectionOPTO(gca,[0.01 0.01],12)



%%
figure
plot(XX.Eye.Maxvtime-XX.Head.Maxvtime,'.b')
hold on
plot(YY.Eye.Maxvtime-YY.Head.Maxvtime,'.r')
%% plot onset of head turn vs eye movemnt
figure
% XX=catstruct(AllData.Rightturn.Back ,AllData.LeftTurn.Back);
% YY=catstruct(AllData.Rightturn.Front ,AllData.LeftTurn.Front);
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thisxtimebin=-26:3:26;
thisdiff=XX.Eye.Maxvtime-XX.Head.Maxvtime;
thisdiff(abs(thisdiff)>25)=NaN;
meanback=nanmean(thisdiff);
histback=hist(thisdiff,thisxtimebin);
histback=histback./sum(histback);
thisdiff=YY.Eye.Maxvtime-YY.Head.Maxvtime;
thisdiff(abs(thisdiff)>25)=NaN;
meanfront=nanmean(thisdiff);

histfront=hist(thisdiff,thisxtimebin);
histfront=histfront./sum(histfront);
h=stairs([thisxtimebin;(thisxtimebin)+0.2]'./400*1000,[histback;histfront]');
hold on
h(1).Color= [0 0.1 0.8];
h(2).Color= [0.9 0.1 0.1];

plot([meanback meanback],[0 0.55],'color',h(1).Color)
hold on
plot([meanfront meanfront],[0 0.55],'color',h(2).Color)
%% hist velocty max
XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
figure
% XX=catstruct(AllData.Rightturn.Back ,AllData.LeftTurn.Back);
% YY=catstruct(AllData.Rightturn.Front ,AllData.LeftTurn.Front);
%  XX2 = AllData.Rightturn.Back;
%  YY = AllData.Rightturn.Front;


thisxtimebin = 1:5:100;
thisdiff = XX.Head.maxangle-10;
thisdiff(abs(thisdiff)>800)=NaN;
meanback = nanmean(thisdiff);
histback = hist(thisdiff,thisxtimebin);
histback = histback./sum(histback);
thisdiff = YY.Head.maxangle-10;
thisdiff(abs(thisdiff)>500) = NaN;
meanfront = nanmean(thisdiff);

histfront = hist(thisdiff,thisxtimebin);
histfront = histfront./sum(histfront);

% h=stairs([thisxtimebin;(thisxtimebin)+0.2]'./400*1000,[histback;histfront]');
h = stairs([thisxtimebin;(thisxtimebin)+0.2]',[histback;histfront]');

hold on
h(1).Color= [0 0.1 0.8];
h(2).Color= [0.9 0.1 0.1];
%% hist angle eye max
XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
figure
title ('Left Turn Eye angle')
% XX=catstruct(AllData.Rightturn.Back ,AllData.LeftTurn.Back);
% YY=catstruct(AllData.Rightturn.Front ,AllData.LeftTurn.Front);
  XX = AllData.Rightturn.Back;
  YY = AllData.Rightturn.Front;


thisxtimebin = -10:4:50;
thisdiff = XX.Eye.maxangle-XX.Eye.minangle;
thisdiff((thisdiff)<0)=NaN;
meanback = nanmean(thisdiff);
histback = hist(thisdiff,thisxtimebin);
histback = histback./sum(histback);
thisdiff = YY.Eye.maxangle-YY.Eye.minangle;
thisdiff((thisdiff)<0) = NaN;
meanfront = nanmean(thisdiff);

histfront = hist(thisdiff,thisxtimebin);
histfront = histfront./sum(histfront);

% h=stairs([thisxtimebin;(thisxtimebin)+0.2]'./400*1000,[histback;histfront]');
h = stairs([thisxtimebin;(thisxtimebin)+0.2]',[histback;histfront]');

hold on
h(1).Color= [0 0.1 0.8];
h(2).Color= [0.9 0.1 0.1];

plot([meanback meanback],[0 0.55],'color',h(1).Color)
hold on
plot([meanfront meanfront],[0 0.55],'color',h(2).Color)


xlabel('Head angle °')
ylabel('Probability ')
plot([meanback meanback],[0 0.55],'color',h(1).Color)
hold on
plot([meanfront meanfront],[0 0.55],'color',h(2).Color)


xlabel('Head angle °')
ylabel('Probability ')


%% plot Eye Angle vs head  Angle
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thesetrial = XX.Eye.maxangle>0;

plot(XX.Eye.maxangle(thesetrial),XX.Head.maxangle(thesetrial)-90,'.b','markersize',20)
hold on


thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial),YY.Head.maxangle(thesetrial)-90,'.r','markersize',20)

XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
thesetrial = XX.Eye.maxangle>0;
plot(XX.Eye.maxangle(thesetrial),XX.Head.maxangle(thesetrial)-10,'.b','markersize',20)
hold on
thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial),YY.Head.maxangle(thesetrial)-10,'.r','markersize',20)
xlim([-100 100])
ylim([-100 100])
plot([-100 100],[0  0],'k')
plot([0  0],[-50 100],'k')
xlabel('Eye Maxi velocity °/s')
ylabel('Head Maxi velocity °/s')
figurecorrectionOPTO(gca,[0.01 0.01],12)

%% amplidue eye vs head
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thesetrial = XX.Eye.maxangle>0;

plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on


thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)

XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
thesetrial = XX.Eye.maxangle>0;
plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on
thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)
% xlim([-100 100])
% ylim([-100 100])
% plot([-100 100],[0  0],'k')
% plot([0  0],[-50 100],'k')
xlabel('Eye movement amplitude  °')
ylabel('Head movement amplitude °')
figurecorrectionOPTO(gca,[0.01 0.01],12)


%%%%
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thesetrial = XX.Eye.maxangle>0;

plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on


thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)

XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
thesetrial = XX.Eye.maxangle>0;
plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on
thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)
% xlim([-100 100])
% ylim([-100 100])
% plot([-100 100],[0  0],'k')
% plot([0  0],[-50 100],'k')
xlabel('Eye movement amplitude  °')
ylabel('Head movement amplitude °')
figurecorrectionOPTO(gca,[0.01 0.01],12)
%%


%% whisker retraction vs eye or head
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thesetrial = XX.Eye.maxangle>0;

plot(XX.Eye.maxangle(thesetrial),XX.Leftwhisker(thesetrial,40),'.b','markersize',20)
hold on


thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial),YY.Leftwhisker(thesetrial,40),'.b','markersize',20)



%%
figure
XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
thesetrial = XX.Eye.maxangle>0;


plot(XX.Eye.maxangle(thesetrial),XX.Leftwhisker(thesetrial,40),'.b','markersize',20)
hold on
thesetrial = YY.Eye.maxangle>0;
plot(YY.Eye.maxangle(thesetrial),YY.Leftwhisker(thesetrial,40),'.r','markersize',20)
% xlim([-100 100])
% ylim([-100 100])
% plot([-100 100],[0  0],'k')
% plot([0  0],[-50 100],'k')
xlabel('Eye movement amplitude  °')
ylabel('Head movement amplitude °')
figurecorrectionOPTO(gca,[0.01 0.01],12)


%%
figure
XX=AllData.Rightturn.Back;
YY=AllData.Rightturn.Front;
thesetrial = XX.Eye.maxangle>0;

plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on


thesetrial = YY.Eye.maxangle>0;

plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)
XX=AllData.LeftTurn.Back;
YY=AllData.LeftTurn.Front;
thesetrial = XX.Eye.maxangle>0;
plot(XX.Eye.maxangle(thesetrial)-XX.Eye.minangle(thesetrial),XX.Head.maxangle(thesetrial)-XX.Head.minangle(thesetrial),'.b','markersize',20)
hold on
thesetrial = YY.Eye.maxangle>0;
plot(YY.Eye.maxangle(thesetrial)-YY.Eye.minangle(thesetrial),YY.Head.maxangle(thesetrial)-YY.Head.minangle(thesetrial),'.r','markersize',20)

xlabel('Eye movement amplitude  °')
ylabel('Head movement amplitude °')
figurecorrectionOPTO(gca,[0.01 0.01],12)