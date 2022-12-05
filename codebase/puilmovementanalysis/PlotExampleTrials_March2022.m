%% for ar38 18 02 
% good trials 16  22 25


% blinktrialsorbadtrials = [ 180 62 18 47 140 173 209 159 66 190 191 74 106 108 120 91 97 185]; % blink trial for ar38
Thisturn =0
 blinktrialsorbadtrials = 10000;
%  load 'Y:\Topviewmovies\ar38motor\2022_02_16\Data.mat'
%  load 'Y:\Topviewmovies\ar38motor\2022_02_16\Pupil.mat'
 load 'Y:\Topviewmovies\ar30motor\2022_02_18\Data.mat'
  load 'Y:\Topviewmovies\ar30motor\2022_02_18\Pupil.mat'
AlingedData=AlingedPupilwithhead(Pupil,Data,Thisturn,blinktrialsorbadtrials);
%%

X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;

thiscondition= AlingedData.Trialype==0;
ColorCode = '-r';
figure
trial =7
trials = find(thiscondition);
subplot (5,1,1)
yyaxis left
plot(X,+AlingedData.Headangle(trials(trial),:)-90,ColorCode,'LineWidth',thislinewidth)
ylim([-20 70])


yyaxis right
plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
ylim([-100 800])

subplot (5,1,2)
yyaxis left

plot(X,+getdiffmovment(AlingedData.Eyemovment(trials(trial),:),20),ColorCode,'LineWidth',thislinewidth)

ylim([-25 25])

yyaxis right
plot(X(2:end),getdiffmovment(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),:),10)*400),10),ColorCode,'LineWidth',thislinewidth)
ylim([-200 600])

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
    xlim([-0.2 0.8])
end


for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01],14)

axis normal
end
%%
    subplot (5,1,5)
axis image
xlim([200 1200])
ylim([0 500])
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

for i=1:20
thiscondition= AlingedData.Trialype==1;
ColorCode = 'r-';
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
trial =i;
trials = find(thiscondition);

XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];


[eyemovemntmax(i), eyemovemntonset(i)]= max(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20)*400));
A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20));
% if XYtrajectory<760|XYtrajectory>860
%     continue
% end



[thismax(i)]=A(230);

A = (getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),20));
[thismax(i)]=A(235);
 if A(245)<0
     continue
 end
% thismax(i)=eyemovemntmax(i);
% X = X-eyemovemntonset(i)./400+0.5;
% X = X

subplot (5,1,1)
if  thismax(i)<thismaxtime
   A = AlingedData.Headangle(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,20)); 
    
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
else
% plot(X,+AlingedData.Headangle(trials(trial),:)-90,'b','LineWidth',thislinewidth)
end
    
ylim([-20 70])

% yyaxis right
%  plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
% ylim([-100 500])

subplot (5,1,2)
%  yyaxis left
A = AlingedData.Eyemovment(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,10));
if  thismax(i)<thismaxtime

plot(X,F,'r-','LineWidth',thislinewidth)
else
% plot(X,F,'b-','LineWidth',thislinewidth)
  
end
ylim([-20 20])

 
subplot (5,1,3)
if  thismax(i)<thismaxtime
A = AlingedData.LeftWhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,5));
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
ylim([-50 60])
else
%  plot(X,+AlingedData.LeftWhisker(trials(trial),:),'b','LineWidth',thislinewidth)
   
    
end

subplot (5,1,4)
if  thismax(i)<thismaxtime
    
    A = AlingedData.Rightwhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
 F = (getdiffmovment(F,5));

plot(X,+F,'r','LineWidth',thislinewidth)
else
%     plot(X,+AlingedData.Rightwhisker(trials(trial),:),'b-','LineWidth',thislinewidth)
end

ylim([-50 75])

subplot (5,1,5)
% plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)

 if  thismax(i)<thismaxtime

  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','r','LineWidth',thislinewidth)
 
     
%       plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
 
 
 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','r','Markersize',5)
%   plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'.r')
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'.r')

 end


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
%5

%%
for i=1:4
    subplot (5,1,i)
    xlim([-0.2 0.8])
end


for i=1:5
    subplot (5,1,i)
    
figurecorrectionOPTO(gca,[0.01 0.01],14)

axis normal
end 

    subplot (5,1,5)
axis image
xlim([200 1200])
ylim([0 500])
%%

%% for ar38 18 02 
clearvars -except X Data pupil AlingedData
thislinewidth=1
% good trials 16  22 25
figure
thismaxtime = 10
thesetrials = [1 2 3 6 9 10 11 18 19 20];

for i=1:100
thiscondition= AlingedData.Trialype==1;
ColorCode = 'r-';
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
trial =i;
trials = find(thiscondition);

XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];


[eyemovemntmax(i), eyemovemntonset(i)]= max(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20)*400));
A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20));
% if XYtrajectory<760|XYtrajectory>860
%     continue
% end



[thismax(i)]=A(230);

A = (getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),20));
[thismax(i)]=A(235);
%  if A(245)<-10
%      continue
%  end
% thismax(i)=eyemovemntmax(i);
% X = X-eyemovemntonset(i)./400+0.5;
% X = X

subplot (5,1,1)
if  thismax(i)<thismaxtime
   A = AlingedData.Headangle(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,20)); 
    
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
else
% plot(X,+AlingedData.Headangle(trials(trial),:)-90,'b','LineWidth',thislinewidth)
end
    
ylim([-20 70])

% yyaxis right
%  plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
% ylim([-100 500])

subplot (5,1,2)
%  yyaxis left
A = AlingedData.Eyemovment(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,10));
if  thismax(i)<thismaxtime

plot(X,F,'r-','LineWidth',thislinewidth)
else
% plot(X,F,'b-','LineWidth',thislinewidth)
  
end
ylim([-20 20])

 
subplot (5,1,3)
if  thismax(i)<thismaxtime
A = AlingedData.LeftWhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,5));
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
ylim([-50 60])
else
%  plot(X,+AlingedData.LeftWhisker(trials(trial),:),'b','LineWidth',thislinewidth)
   
    
end

subplot (5,1,4)
if  thismax(i)<thismaxtime
    
    A = AlingedData.Rightwhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
 F = (getdiffmovment(F,5));

plot(X,+F,'r','LineWidth',thislinewidth)
else
%     plot(X,+AlingedData.Rightwhisker(trials(trial),:),'b-','LineWidth',thislinewidth)
end

ylim([-50 75])

subplot (5,1,5)
% plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)

 if  thismax(i)<thismaxtime

  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','r','LineWidth',thislinewidth)
 
     
%       plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
 
 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','g','Markersize',4,'LineWidth',4)
%   plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'.r')
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'.r')

 end



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

%%
clearvars -except X Data pupil AlingedData
thislinewidth=1
% good trials 16  22 25

thismaxtime = 10
thesetrials = [1 2 3 6 9 10 11 18 19 20];
for i=1:100
thiscondition= AlingedData.Trialype==0;
ColorCode = 'r-';
X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
trial =i;
trials = find(thiscondition);

XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];


[eyemovemntmax(i), eyemovemntonset(i)]= max(diff(getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20)*400));
A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:300),20));
% if XYtrajectory<760|XYtrajectory>860
%     continue
% end



[thismax(i)]=A(230);

A = (getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),20));
[thismax(i)]=A(235);
%  if A(245)<-10
%      continue
%  end
% thismax(i)=eyemovemntmax(i);
% X = X-eyemovemntonset(i)./400+0.5;
% X = X

subplot (5,1,1)
if  thismax(i)<thismaxtime
   A = AlingedData.Headangle(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,20)); 
    
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
else
% plot(X,+AlingedData.Headangle(trials(trial),:)-90,'b','LineWidth',thislinewidth)
end
    
ylim([-20 70])

% yyaxis right
%  plot(X,rad2deg(AlingedData.Headvelocity(trials(trial),:))*400,'-b','LineWidth',thislinewidth)
% ylim([-100 500])

subplot (5,1,2)
%  yyaxis left
A = AlingedData.Eyemovment(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,10));
if  thismax(i)<thismaxtime

plot(X,F,'r-','LineWidth',thislinewidth)
else
% plot(X,F,'b-','LineWidth',thislinewidth)
  
end
ylim([-20 20])

 
subplot (5,1,3)
if  thismax(i)<thismaxtime
A = AlingedData.LeftWhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);

 F = (getdiffmovment(F,5));
plot(X,+F,ColorCode,'LineWidth',thislinewidth)
ylim([-50 60])
else
%  plot(X,+AlingedData.LeftWhisker(trials(trial),:),'b','LineWidth',thislinewidth)
   
    
end

subplot (5,1,4)
if  thismax(i)<thismaxtime
    
    A = AlingedData.Rightwhisker(trials(trial),:);
[F,~]=fillmissingtrace (A,X);
 F = (getdiffmovment(F,5));

plot(X,+F,'r','LineWidth',thislinewidth)
else
%     plot(X,+AlingedData.Rightwhisker(trials(trial),:),'b-','LineWidth',thislinewidth)
end

ylim([-50 75])

subplot (5,1,5)
% plot(X,+AlingedData.Rightwhisker(trials(trial),:),ColorCode,'LineWidth',thislinewidth)

 if  thismax(i)<thismaxtime

  plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','r','LineWidth',thislinewidth)
 
     
%       plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
 
 hold on 
 plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))...
     ,'d','color','g','Markersize',4,'LineWidth',4)
%   plot(Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:),Data.Head.Snouty(AlingedData.Trial(trials(trial)),:),'-','color','b','LineWidth',thislinewidth)
                plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'.r')
                plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'.r')

 end



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