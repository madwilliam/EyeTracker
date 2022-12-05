
% function AlingedPupilwithhead(Pupil,Data)
Rpo= 2.63; %the average rat eye is 2.63 mm
Rpo= 3.83; %the average rat eye is 2.63 mm

Xconv = 10; % each pixel is 10 mm roughly
 load 'Y:\Topviewmovies\ar38motor\2022_02_16\Pupil.mat'
load 'Y:\Topviewmovies\ar38motor\2022_02_16\Data.mat'

pupilall =Pupil;
RightorLeft = 1;
spoutposition =Data.Spout.LY>100;

figure
thetrialnumber= Data.Info.Trialnumber;
thetrialnumber= Data.Info.turntime;

% Newtime(thetrialnumber(1:numel(thesetimes))+1)=thesetimes;
% NewLorR(thetrialnumber(1:numel(thesetimes))+1) =LorR;
NewLorR =Data.Info.AnimalActions;
Newtime= Data.Head.Turntime;
clear NewallpositionsA
AlingedData.Headvelocity=NaN(200,800);
AlingedData.Headangle=NaN(200,800);
AlingedData.Eyemovment=NaN(200,800);
AlingedData.Rightwhisker=NaN(200,800);
AlingedData.LeftWhisker=NaN(200,800);
AlingedData.Trialype=NaN(1,200);
a = ones(1,264)*150;
a(20)=94;
a(34)=90;
a(66)=54;
a(177)=79;
a(199)=110;
a(230)=68;
a(39)=72;
a(22)=86;
a(58)=100;
a(72)=100;

% AlingedData.s=NaN(1,400);

goodtrialsr = [2 5 9 11 15 46 49 83 84 87 90 91  94  111 113  119 ];
%  goodtrialsr = goodtrialsr([     1   ])
goodtrialsb = [39 59 77 102 107 154 171 174 177  195 198 207];
goodtrialsRF = [70 75 66 159];
halfturnss=[66 159];
Tcounter = 0;
%  blinktrials = [ 43 35 38 18 76 36];
blinktrialsorbadtrials = [ 180 62 18 47 140 173 209 159 66 190 191 74 106 108 120 91 97 185];
interestingtrial=[47 173 209 91 97];
goodtrialsb=goodtrialsb(7);
NewallpositionsA=Data.Head.Angle;
% period =
for trial=1:264
    thisjump=find(diff(Data.Head.goodframes(trial,:))>2,1,'first');
    if any(thisjump)
        NewallpositionsA(trial,thisjump:end)=NaN;
    end
    
%     if ismember(trial,blinktrialsorbadtrials)
%         continue
%     end
    if isempty(pupilall.Left.Light{trial})
        continue
    end
    R = pupilall.Right.pupilcenter{trial}(:,1)./10-pupilall.Right.Light{trial}(:,1)./10;
    Ry = pupilall.Right.pupilcenter{trial}(:,2)./10-pupilall.Right.Light{trial}(:,2)./10;
    L = pupilall.Left.pupilcenter{trial}(:,1)./10-pupilall.Left.Light{trial}(:,1)./10;
    Ly = pupilall.Left.pupilcenter{trial}(:,2)./10-pupilall.Left.Light{trial}(:,2)./10;
    L([false ;abs(diff(L))>0.3])=NaN;
    R([false ;abs(diff(R))>0.3])=NaN;

    % x = (1:numel(y))./400+Newtime(trial+1)./400;
    if RightorLeft==1
        R=R(1:a(trial));
        x = (1:numel(R))-Newtime(trial);
        dX=medfilt1(R,5);
        dX=smooth(dX);
        A=pupilall.Right.pupilcenter{trial}(1:a(trial),2);
        M = movvar(A,5);
        dX(M>20)=NaN;
        M = movvar(dX,5);
        dX(M>20)=NaN;
        
        
        
        Ry=Ry(1:a(trial));
        x = (1:numel(R))-Newtime(trial);
        Y=medfilt1(Ry,5);
        Y=smooth(Y);
        A=pupilall.Left.pupilcenter{trial}(1:a(trial),2);
        M = movvar(A,5);
        Y(M>20)=NaN;
        M = movvar(Y,5);
        Y(M>20)=NaN;
        %     Y = asin(dX./(sqrt(Rpo.^2-Y.^2)));
        Y = (asin(-dX./sqrt(Rpo.^2-0)));
                Y(M>20)=NaN;

    else
        L=L(1:a(trial));
%         L=L(1:end);
        
        dX=medfilt1(L,5);
        dX=smooth(dX);
        A=pupilall.Left.pupilcenter{trial}(1:a(trial),2);
        M = movvar(A,5);
        dX(M>20)=NaN;
        M = movvar(dX,5);
        dX(M>20)=NaN;
        
        
        
        Ly=Ly(1:a(trial));
        x = (1:numel(Ly))-Newtime(trial);
        Y=medfilt1(Ly,5);
        Y=smooth(Y);
        A=pupilall.Left.pupilcenter{trial}(1:a(trial),2);
        M = movvar(A,5);
        Y(M>20)=NaN;
        M = movvar(Y,5);
        Y(M>20)=NaN;
        %     Y = (asin(dX./sqrt(Rpo.^2-Y.^2)));
        Y = (asin(-dX./sqrt(Rpo.^2-0)));
        
    end
    thisjump=find(diff(Y)>0.1,1,'first');
    if any(thisjump)
        
    Y(thisjump:end)=NaN;
    end
    
    if NewLorR(trial)==RightorLeft
        if spoutposition(trial)
            colorcode= 'b';
            %             continue
        else
            %             continue
            colorcode= 'r';
        end
        
        subplot (6,1,3)
        if Newtime(trial)>200
            continue
        end
        inds =  Newtime(trial);
        if RightorLeft==0
            
            thisY = diff(nanfastsmooth(-NewallpositionsA(trial,:),20));
        else
            thisY = diff(nanfastsmooth(NewallpositionsA(trial,:),20));
            
        end
        [~,inds]=max(thisY);
        if inds<22||inds>199
            continue
        end
        thisy=[190 250];
        thisx= [650 760];
        %           if Data.Head.Snoutx(trial,inds-25)<thisx(1)||Data.Head.Snoutx(trial,inds-25)>thisx(2)||Data.Head.Snouty(trial,inds-25)<thisy(1)||Data.Head.Snouty(trial,inds-25)>thisy(2)
%          if Data.Head.Snoutx(trial,1)<thisx(1)||Data.Head.Snoutx(trial,1)>thisx(2)||Data.Head.Snouty(trial,1)<thisy(1)||Data.Head.Snouty(trial,1)>thisy(2)
%             
%              continue
%         end
        
        Tcounter = Tcounter+1;
        AlingedData.Turntime (Tcounter) = inds;
        AlingedData.Trialype(Tcounter)=spoutposition(trial);
        %         fr
        x = (1:numel(NewallpositionsA(trial,:)))-inds;
                if RightorLeft

        plot(x,rad2deg(medfilt1(NewallpositionsA(trial,:))),colorcode)
                else
                         plot(x,90-rad2deg(medfilt1(NewallpositionsA(trial,:))),colorcode)
   
                end
        hold on
        
%         [eyemovemntmax(Tcounter), eyemovemntonset(Tcounter)]= max(diff(getdiffmovment(NewallpositionsA(trial,1:300),20))*400);

%         
        if RightorLeft
        AlingedData.Headangle(Tcounter,x+200) = rad2deg(medfilt1(NewallpositionsA(trial,:)));
        else
                             AlingedData.Headangle(Tcounter,x+200) = 90-rad2deg(medfilt1(NewallpositionsA(trial,:)));
   
        end
        subplot (6,1,1)
        plot(x,[0 thisY],colorcode)
        AlingedData.Headvelocity(Tcounter,x+200) = [0 thisY];
        AlingedData.Trial(Tcounter) = trial;

        hold on
        
        
        subplot (6,1,2)
        x = (1:numel(Y))-inds;
        %         Yangle = Y*10;
        
                if RightorLeft

              AlingedData.Eyemovment (Tcounter,x(x<100)+200) = rad2deg(Y(x<100));
        plot(x(x<100),rad2deg(Y(x<100)),colorcode)
        hold on
                else
             AlingedData.Eyemovment (Tcounter,x(x<100)+200) = -rad2deg(Y(x<100));
  plot(x(x<100),-rad2deg(Y(x<100)),colorcode)
        hold on
                end
        subplot (6,1,4)
        x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
        x = (1:numel(Data.LeftWhikser.Angel2(trial,:)))-inds;
        %         AA =movmean(-medfilt1(Data.RightWhikser.Angel(trial,:),3),5,'includenan');
        AA =-movmean(Data.RightWhikser.Angel(trial,:),10,'includenan');
        plot(x,AA,colorcode)
        hold on
        AlingedData.Rightwhisker(Tcounter,x+200) = AA;
        
        
        subplot (6,1,5)
        
        x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
        %         AA =movmean(-medfilt1(Data.LeftWhikser.Angel(trial,:),3),5,'includenan');
        AA =-movmean(Data.LeftWhikser.Angel(trial,:),10,'includenan');
        
        plot(x,AA,colorcode)
        hold on
        AlingedData.LeftWhisker (Tcounter,x+200) = AA;
        
        
        subplot (6,1,6)
        
        %         plot(Data.Spout.LX(trial),Data.Spout.LY(trial),'dk')
        
        %                 plot(Data.Spout.RX(trial),Data.Spout.RY(trial),'d','color',colorcode)
%         plot(Data.Spout.LX(trial),Data.Spout.LY(trial),'d','color',colorcode)
                plot(Data.Spout.RX(trial),Data.Spout.RY(trial),'d','color',colorcode)

        hold on
        plot(Data.Head.Snoutx(trial,1:inds+25),Data.Head.Snouty(trial,1:inds+25),'.','color',colorcode,'markersize',10)
        plot(Data.Head.Snoutx(trial,:),Data.Head.Snouty(trial,:),'.','color',colorcode,'markersize',2)
        
        if inds-25>0
            %                 plot(Data.Head.Nosex(trial,inds-25),Data.Head.Nosey(trial,inds-25),'.','color',colorcode,'markersize',20)
            plot(Data.Head.Snoutx(trial,inds-25),Data.Head.Snouty(trial,inds-25),'.','color',colorcode,'markersize',10)
            plot(Data.Head.Snoutx(trial,1),Data.Head.Snouty(trial,1),'.','color',colorcode,'markersize',40)
            
            thisx= [690 150];
            thisy=[110 140];
        end
        %         end
    end
    
end


for i=1:5
    subplot (6,1,i)
    xlim([-200 400])
end
% end
