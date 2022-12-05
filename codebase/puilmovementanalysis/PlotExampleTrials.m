%% for ar38 18 02 
% good trials 16  22 25
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;

thiscondition= AlingedData.Trialype==1;
ColorCode = '-r';
figure
trial =45
trials = find(thiscondition);
subplot (5,1,1)
yyaxis left
plot(X,+AlingedData.Headangle(trials(trial),:),ColorCode,'LineWidth',thislinewidth)
ylim([-20 70])


yyaxis right
plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
ylim([-100 800])

subplot (5,1,2)
yyaxis left

plot(X,+getdiffmovment(AlingedData.Eyemovment(trials(trial),:),20),ColorCode,'LineWidth',thislinewidth)

ylim([-15 20])

yyaxis right
plot(X(2:end),getdiffmovment(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),:),10)*400),10),ColorCode,'LineWidth',thislinewidth)
ylim([-200 500])

subplot (5,1,3)

A = +AlingedData.LeftWhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
plot(X,F,ColorCode,'LineWidth',thislinewidth)
ylim([-50 75])
subplot (5,1,4)

A = +AlingedData.Rightwhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
if AlingedData.Rightwhisker(trials(trial),201)>50
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
else
    plot(X,+F,'b-','LineWidth',thislinewidth)

end
ylim([-50 75])


subplot (5,1,5)
plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)

 
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)

 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','b','Markersize',8)
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)


                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color',colorcode)
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'d','color',colorcode)

%%
for i=1:4
    subplot (5,1,i)
    xlim([-0.2 0.6])
end


for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01],14)

axis normal
end
%%


%% for ar38 18 02 
% good trials 16  22 25
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;

thiscondition= AlingedData.Trialype==1
ColorCode = 'r';
figure
trial =2
trials = find(thiscondition);
subplot (5,1,1)
yyaxis left
plot(X,-AlingedData.Headangle(trials(trial),:)+90,ColorCode,'LineWidth',thislinewidth)
ylim([-20 70])


yyaxis right
% plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-','LineWidth',thislinewidth)
plot(X(2:end),(diff(getdiffmovment(-AlingedData.Headangle(trials(trial),:)+90,20)))*400,'-','LineWidth',thislinewidth)

% diff(getdiffmovment(
ylim([-100 1000])

subplot (5,1,2)
yyaxis left
A = -AlingedData.Eyemovment(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
plot(X,F,ColorCode,'LineWidth',thislinewidth)

ylim([-20 20])

yyaxis right
plot(X(2:end),diff(getdiffmovment(-AlingedData.Eyemovment(trials(trial),:),20)*400),ColorCode,'LineWidth',thislinewidth)
ylim([-200 500])

subplot (5,1,3)

A = +AlingedData.LeftWhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
plot(X,F,ColorCode,'LineWidth',thislinewidth)
ylim([-50 60])
subplot (5,1,4)

A = +AlingedData.Rightwhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
if AlingedData.Rightwhisker(trials(trial),201)>50
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
else
    plot(X,+F,'b-','LineWidth',thislinewidth)

end
ylim([-50 75])

subplot (5,1,5)

 
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)

 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','b','Markersize',8)
  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
%                 plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color',colorcode)
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'d','color',colorcode)




for i=1:4
    subplot (5,1,i)
    xlim([-0.3 0.8])
end


for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01],12)

axis normal
end
%%


%% for ar38 18 02 
clearvars -except X Data pupil AlingedData
thislinewidth=1
% good trials 16  22 25
figure
thismaxtime = 10
thesetrials = [1 2 3 6 9 10 11 18 19 20];

for i=1:50
thiscondition= AlingedData.Trialype==1;
ColorCode = 'r-';
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
trial =i;
trials = find(thiscondition);

XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];


[eyemovemntmax(i), eyemovemntonset(i)]= max(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20)*400));
A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20));
if XYtrajectory<760|XYtrajectory>860
    continue
end



[thismax(i)]=A(230);

A = (getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),20));
[thismax(i)]=A(235);
if A(245)<10
    continue
end
% thismax(i)=eyemovemntmax(i);
% X = X-eyemovemntonset(i)./400+0.5;
% X = X

subplot (5,1,1)
if  thismax(i)<thismaxtime
plot(X,+AlingedData.Headangle(trials(trial),:)-90,ColorCode,'LineWidth',thislinewidth)
else
plot(X,+AlingedData.Headangle(trials(trial),:)-90,'b','LineWidth',thislinewidth)
end
    
ylim([-20 70])

% yyaxis right
%  plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
% ylim([-100 500])

subplot (5,1,2)
%  yyaxis left
A = AlingedData.Eyemovment(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
if  thismax(i)<thismaxtime

plot(X,F,'r-','LineWidth',thislinewidth)
else
plot(X,F,'b-','LineWidth',thislinewidth)
  
end
ylim([-20 20])

%  yyaxis right
%  if  thismax(i)<thismaxtime
% 
%  plot(X(2:300),diff(getdiffmovment(F(1:300),20)*400),'r-','LineWidth',thislinewidth)
%  else
%      
%  plot(X(2:300),diff(getdiffmovment(F(1:300),20)*400),'b-','LineWidth',thislinewidth)
% 
%  end
 
subplot (5,1,3)
if  thismax(i)<thismaxtime

plot(X,+AlingedData.LeftWhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)
ylim([-50 60])
else
 plot(X,+AlingedData.LeftWhisker(trials(trial),:),'b','LineWidth',thislinewidth)
   
    
end

subplot (5,1,4)
if  thismax(i)<thismaxtime
plot(X,+AlingedData.Rightwhisker(trials(trial),:),'r','LineWidth',thislinewidth)
% trial
else
    plot(X,+AlingedData.Rightwhisker(trials(trial),:),'b-','LineWidth',thislinewidth)
end

ylim([-50 75])

subplot (5,1,5)
plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)

 if  thismax(i)<thismaxtime

  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','r','LineWidth',thislinewidth)
 else
     
      plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
 
 end
 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','b','Markersize',5)
%   plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'dr')
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'dr')




for i=1:4
    subplot (5,1,i)
    xlim([-0.2 0.6])
end


for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01],12)
hold on

axis normal
end
end