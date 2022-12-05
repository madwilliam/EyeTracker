%% for ar38 18 02
 blinktrialsorbadtrials = [ 180 62 18 47 140 173 209 159 66 190 191 74 106 108 120 91 97 185]; % blink trial for ar38

% blinktrialsorbadtrials = 10000;
%   load '\\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_16\Data.mat'
%   load '\\dk-server.dk.ucsd.edu\afassihizakeri\Topviewmovies\ar38motor\2022_02_16\Pupil.mat'
    Whiskingperiod = 100:600;

Thisturn = 1;
% AlingedData=AlingedPupilwithhead(Pupil,Data,Thisturn,blinktrialsorbadtrials);

thislinewidth=1;
% good trials 16  22 25
figure
thismaxtime = 10;
thesetrials = [1 2 3 6 9 10 11 18 19 20];
% [~,thisid]=sort(thismax);
Colorcode = jet(100);
AnData=[];
    thiscondition= AlingedData.Trialype==1; % back is 1 and front is 0
    trials = find(thiscondition);
for i=1:numel(trials)
    ColorCode = 'r-';
    X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
    trial =i;
    XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];
        A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:500),20));
                        Normalization =(getdiffmovment(AlingedData.Eyelenght(trials(trial),1:500),20))*0.9524*10;

    [SmoothEye,~]=fillmissingtrace (A./Normalization,X(1:500));
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
    subplot (5,1,2)
    yyaxis left
    plot(X(1:500),SmoothEye,'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
    ylim([-20 20])
    yyaxis right
    plot(X(2:500),getdiffmovment(diff(SmoothEye)*400,20),'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
    subplot (5,1,3)
    A = getdiffmovment(AlingedData.LeftWhisker(trials(trial),:),2);
    [F,~]=fillmissingtrace (A,X);
    plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
   AnData.Leftwhisker(i,:) = NaN(1,800);
[AnData.Leftwhisker(i,Whiskingperiod)]=F(Whiskingperiod);
    ylim([-50 60])
    subplot (5,1,4)
    A = getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),2);
    [F,~]=fillmissingtrace (A,X);
    plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
AnData.Rightwhisker(i,:) = NaN(1,800);
[AnData.Rightwhisker(i,Whiskingperiod)]=F(Whiskingperiod);
        subplot (5,1,5)

    plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color','r')
    hold on
    plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'d','color','r')
    [AnData.theta(i),AnData.rho(i)] = cart2pol(XYtrajectory(1),XYtrajectory(2));
    
    
       XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];
       
       Thisheadx = Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:);
       alingesx = NaN(1,800);
       alingesx(200-AlingedData.Turntime(trials(trial)):200-AlingedData.Turntime(trials(trial))+numel(Thisheadx)-1)=Thisheadx;
       AnData.HeadX(i,:) = alingesx;
       
       
       Thisheadx = Data.Head.Snouty(AlingedData.Trial(trials(trial)),:);
       alingesx = NaN(1,800);
       alingesx(200-AlingedData.Turntime(trials(trial)):200-AlingedData.Turntime(trials(trial))+numel(Thisheadx)-1)=Thisheadx;
       AnData.HeadY(i,:) = alingesx;
    
    
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


if Thisturn
AllData.Rightturn.Back=AnData;
else 
        AllData.LeftTurn.Back=AnData;
end

AnData=[];
    thiscondition= AlingedData.Trialype==0; % back is 1 and front is 0
    trials = find(thiscondition);
for i=1:numel(trials)
    ColorCode = 'r-';
    X =(( 1:size(AlingedData.Headvelocity,2))-200)./400;
    trial =i;
    XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];
        A = (getdiffmovment(AlingedData.Eyemovment(trials(trial),1:500),20));
                Normalization =(getdiffmovment(AlingedData.Eyelenght(trials(trial),1:500),20))*0.9524*10;

        
    [SmoothEye,~]=fillmissingtrace (A./Normalization,X(1:500));
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
    subplot (5,1,2)
    yyaxis left
    plot(X(1:500),SmoothEye,'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
    ylim([-20 20])
    yyaxis right
    plot(X(2:500),getdiffmovment(diff(SmoothEye)*400,20),'-','color',Colorcode(i,:),'LineWidth',thislinewidth)
    subplot (5,1,3)
    A = getdiffmovment(AlingedData.LeftWhisker(trials(trial),:),2);
    [F,~]=fillmissingtrace (A,X);
    plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
AnData.Leftwhisker(i,:) = NaN(1,800);
[AnData.Leftwhisker(i,Whiskingperiod)]=F(Whiskingperiod);
    ylim([-50 60])
    subplot (5,1,4)
    A = getdiffmovment(AlingedData.Rightwhisker(trials(trial),:),2);
    [F,~]=fillmissingtrace (A,X);
    plot(X,+F,'color',Colorcode(i,:),'LineWidth',thislinewidth)
AnData.Rightwhisker(i,:) = NaN(1,800);
[AnData.Rightwhisker(i,Whiskingperiod)]=F(Whiskingperiod);
    subplot (5,1,5)

    plot(Data.Spout.RX(AlingedData.Trial(trials(trial))),Data.Spout.RY(AlingedData.Trial(trials(trial))),'d','color','r')
    hold on
    plot(Data.Spout.LX(AlingedData.Trial(trials(trial))),Data.Spout.LY(AlingedData.Trial(trials(trial))),'d','color','r')
    [AnData.theta(i),AnData.rho(i)] = cart2pol(XYtrajectory(1),XYtrajectory(2));
   %%
   
   
       XYtrajectory= [Data.Head.Snoutx(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial))),Data.Head.Snouty(AlingedData.Trial(trials(trial)),AlingedData.Turntime(trials(trial)))];
       
       Thisheadx = Data.Head.Snoutx(AlingedData.Trial(trials(trial)),:);
       alingesx = NaN(1,800);
       alingesx(200-AlingedData.Turntime(trials(trial)):200-AlingedData.Turntime(trials(trial))+numel(Thisheadx)-1)=Thisheadx;
       AnData.HeadX(i,:) = alingesx;
       
       
       Thisheadx = Data.Head.Snouty(AlingedData.Trial(trials(trial)),:);
       alingesx = NaN(1,800);
       alingesx(200-AlingedData.Turntime(trials(trial)):200-AlingedData.Turntime(trials(trial))+numel(Thisheadx)-1)=Thisheadx;
       AnData.HeadY(i,:) = alingesx;
       
    
    
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
if Thisturn
AllData.Rightturn.Front=AnData;
else 
        AllData.LeftTurn.Front=AnData;
end


