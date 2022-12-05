figure
thiscondition= AlingedData.Trialype==0
ColorCode = 'r';
X =( 1:size(AlingedData.Headvelocity,2))-200;
AlingedData.Eyemovment(AlingedData.Eyemovment==0)=NaN;
% figure
subplot(5,1,1)
plot(X,nanmean(AlingedData.Headvelocity(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.Headvelocity(thiscondition,:))',ColorCode,'LineWidth',0.1)

subplot(5,1,2)
Y = nansum(AlingedData.Headangle(thiscondition,:))./sum(~isnan(AlingedData.Headangle(thiscondition,:)));
Y(sum(~isnan(AlingedData.Headangle(thiscondition,:)))<4)=NaN;
plot(X,Y,ColorCode,'LineWidth',4)

hold on
% plot(X,(AlingedData.Headangle(thiscondition,:))',ColorCode,'LineWidth',0.1)

subplot(5,1,3)
plot(X,nanmean(AlingedData.Eyemovment(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.Eyemovment(thiscondition,:))',ColorCode,'LineWidth',0.1)


subplot(5,1,4)
plot(X,nanmean(AlingedData.LeftWhisker(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.LeftWhisker(thiscondition,:)),ColorCode,'LineWidth',0.1)

subplot(5,1,5)
plot(X,nanmean(AlingedData.Rightwhisker(thiscondition,:))',ColorCode,'LineWidth',4)
hold on



thiscondition= AlingedData.Trialype==1
ColorCode = 'b';
X =( 1:size(AlingedData.Headvelocity,2))-200;
AlingedData.Eyemovment(AlingedData.Eyemovment==0)=NaN;
% figure
subplot(5,1,1)
plot(X,nanmean(AlingedData.Headvelocity(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.Headvelocity(thiscondition,:))',ColorCode,'LineWidth',0.1)

subplot(5,1,2)
Y = nansum(AlingedData.Headangle(thiscondition,:))./sum(~isnan(AlingedData.Headangle(thiscondition,:)));
Y(sum(~isnan(AlingedData.Headangle(thiscondition,:)))<4)=NaN;
plot(X,Y,ColorCode,'LineWidth',4)

hold on
% plot(X,(AlingedData.Headangle(thiscondition,:))',ColorCode,'LineWidth',0.1)

subplot(5,1,3)
plot(X,nanmean(AlingedData.Eyemovment(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.Eyemovment(thiscondition,:))',ColorCode,'LineWidth',0.1)


subplot(5,1,4)
plot(X,nanmean(AlingedData.LeftWhisker(thiscondition,:)),ColorCode,'LineWidth',4)
hold on
% plot(X,(AlingedData.LeftWhisker(thiscondition,:)),ColorCode,'LineWidth',0.1)

subplot(5,1,5)
plot(X,nanmean(AlingedData.Rightwhisker(thiscondition,:))',ColorCode,'LineWidth',4)
hold on

% plot(X,(AlingedData.Rightwhisker(thiscondition,:))',ColorCode,'LineWidth',0.1)
%%
for i=1:5
    subplot(5,1,i)
    xlim([-50 100])
    
    
end

%%

X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;

Y = nansum(AlingedData.Headangle(thiscondition,:))./sum(~isnan(AlingedData.Headangle(thiscondition,:)));
% Y(sum(~isnan(AlingedData.Headangle(thiscondition,:)))<4)=NaN;
plot(X,Y,ColorCode,'LineWidth',4)


%%
figure
trial =11
trials = find(thiscondition);
yyaxis left
plot(X,AlingedData.Eyemovment(trials(trial),:)+AlingedData.Headangle(trials(trial),:)-90,ColorCode,'LineWidth',4)
hold on

plot(X,AlingedData.Headangle(trials(trial),:)-90,'b--','LineWidth',4)

yyaxis right
plot(X,AlingedData.Eyemovment(trials(trial),:),'color',[0 0.2 0.7],'LineWidth',4)

%% for ar38 18 02 
% good trials 16  22 25
thiscondition= AlingedData.Trialype==1
ColorCode = 'r';
figure
trial =25
trials = find(thiscondition);
subplot (5,1,1)
yyaxis left
plot(X,+AlingedData.Headangle(trials(trial),:)-90,ColorCode,'LineWidth',4)
ylim([-20 70])


yyaxis right
plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-.b','LineWidth',4)
ylim([-100 500])

subplot (5,1,2)
yyaxis left

plot(X,+AlingedData.Eyemovment(trials(trial),:),ColorCode,'LineWidth',4)

ylim([-5 15])

yyaxis right
plot(X(2:end),diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),:),10)*400),ColorCode,'LineWidth',4)
ylim([-200 500])

subplot (5,1,3)

plot(X,+AlingedData.LeftWhisker(trials(trial),:),ColorCode,'LineWidth',4)
ylim([-50 60])

subplot (5,1,4)
plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',4)
ylim([-50 75])

subplot (5,1,5)
plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',4)

 
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',4)

 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','b','Markersize',20)
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',4)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color',colorcode)

%%



for i=1:4
    subplot (5,1,i)
    xlim([-0.2 0.5])
end

%%



for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01])

axis normal
end