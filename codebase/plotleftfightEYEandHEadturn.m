
pupilall =Pupil;
Rpo= 2.63; %the average rat eye is 2.63 mm
Xconv = 10; % each pixel is 10 mm roughly
spoutposition =Data.Spout.LY<100;
figure
thetrialnumber= Data.Info.Trialnumber;
thetrialnumber= Data.Info.turntime

% Newtime(thetrialnumber(1:numel(thesetimes))+1)=thesetimes;
% NewLorR(thetrialnumber(1:numel(thesetimes))+1) =LorR;
NewLorR =Data.Info.AnimalActions;
Newtime= Data.Head.Turntime;
clear NewallpositionsA
% for i=1:size(allpositionsA,1)
%     %  NewallpositionsA(thetrialnumber(i)+1,:) =allpositionsA(i,:);
%     NewallpositionsA(thetrialnumber(i)+1,:) =Data.Head.Angle(i,:);
%
% end
goodtrialsr = [2 5 9 11 15 46 49 83 84 87 90 91  94  111 113  119  ]
%  goodtrialsr = goodtrialsr([     1   ])


 goodtrialsb = [39 59 77 102 107 154 171 174 177  195 198 207];
goodtrialsb=goodtrialsb(7);
NewallpositionsA=Data.Head.Angle;
for trial=1:111
    %     trial
    if trial==18
        continue
    end
    if isempty(pupilall.Right.Light{trial})
        continue
    end
    % y = pupilall.Left.pupilcenter{trial}(:,1)-pupilall.Left.Light{trial}(:,1);
    R = pupilall.Right.pupilcenter{trial}(:,1)-pupilall.Right.Light{trial}(:,1);
    L = pupilall.Left.pupilcenter{trial}(:,1)-pupilall.Left.Light{trial}(:,1);
    
    % x = (1:numel(y))./400+Newtime(trial+1)./400;
    R=R(1:a(trial));
    x = (1:numel(R))-Newtime(trial);
    Y=medfilt1(R,5);
    Y=smooth(Y);
    A=pupilall.Left.pupilcenter{trial}(:,2);
    M = movvar(A,5);
    Y(M>20)=NaN;
    M = movvar(Y,5);
    Y(M>20)=NaN;
    Y2=Y;
    Y=medfilt1(L,5);
    Y=smooth(Y);
    A=pupilall.Left.pupilcenter{trial}(:,2);
    M = movvar(A,5);
    Y(M>20)=NaN;
    M = movvar(Y,5);
    Y(M>20)=NaN;
    if NewLorR(trial)==1
        if spoutposition(trial)
            colorcode= 'r';
        else
            continue
            colorcode= 'b';
        end
        
        
        subplot (6,1,3)
        if Newtime(trial)>200
            continue
        end
        inds =  Newtime(trial);
                           x = (1:numel(NewallpositionsA(trial,:)))-inds;

        %         if NewallpositionsA(trial,(x==100))<600&&NewallpositionsA(trial,(x==100))>200
%         if NewallpositionsA(trial,(x==0))<2.4&&NewallpositionsA(trial,(x==0))>1.8
            
            thisY = medfilt1(NewallpositionsA(trial,:));
            
%            [inds]=find(thisY>1.6,1,'first');

            plot(x,medfilt1(NewallpositionsA(trial,:)),colorcode)
            hold on
            
%             subplot (6,1,1)
%              x = (1:numel(Y))-inds;
%             
%               Y(x>-30&Y>-15)=NaN;

%             plot(x(x<0),Y(x<0),colorcode)
%             hold on
            
            subplot (6,1,2)
            x = (1:numel(Y))-inds;
            plot(x(x<40),Y(x<40),colorcode)
            hold on
            
             subplot (6,1,4)
             x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
                  x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
            AA =movmean(-medfilt1(Data.RightWhikser.Angel(trial,:),3),5,'includenan');

            plot(x,AA,colorcode)
            hold on
            
            
            subplot (6,1,5)
            
            x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
            AA =movmean(-medfilt1(Data.LeftWhikser.Angel(trial,:),3),5,'includenan');

            plot(x,AA,colorcode)
            hold on
            
            
                        subplot (6,1,6)

%             plot(Data.Spout.RX(trial),Data.Spout.RY(trial),'dk')
            plot(Data.Spout.LX(trial),Data.Spout.LY(trial),'dk')

            hold on
                        plot(Data.Head.Nosex(trial,:),Data.Head.Nosey(trial,:),'.b')

%         end
    end
    
end


for i=1:5
                subplot (6,1,i)

    xlim([-200 200])
end
