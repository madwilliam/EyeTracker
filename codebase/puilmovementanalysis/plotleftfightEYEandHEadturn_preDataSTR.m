Rpo= 2.63; %the average rat eye is 2.63 mm
Rpo= 3.83; %the average rat eye is 2.63 mm

Xconv = 10; % each pixel is 10 mm roughly
pupilall = Pupil;
RightorLeft = 0;
spoutposition =Data.Spout.LY>100;
figure
thetrialnumber= Data.Info.Trialnumber;
thetrialnumber= Data.Info.turntime;

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
goodtrialsr = [2 5 9 11 15 46 49 83 84 87 90 91 94 111 113 119 ];
%  goodtrialsr = goodtrialsr([     1   ])


goodtrialsb = [39 59 77 102 107 154 171 174 177 195 198 207];

blinktrials = [ 35 38 18];
goodtrialsb=goodtrialsb(7);
NewallpositionsA=Data.Head.Angle;
for trial=1:80
    %     trial
    if ismember(trial,blinktrials)
        continue
    end
    if isempty(pupilall.Right.Light{trial})
        continue
    end
    % y = pupilall.Left.pupilcenter{trial}(:,1)-pupilall.Left.Light{trial}(:,1);
    R = pupilall.Right.pupilcenter{trial}(:,1)./10-pupilall.Right.Light{trial}(:,1)./10;
    Ry = pupilall.Right.pupilcenter{trial}(:,2)./10-pupilall.Right.Light{trial}(:,2)./10;

    L = pupilall.Left.pupilcenter{trial}(:,1)./10-pupilall.Left.Light{trial}(:,1)./10;
    Ly = pupilall.Left.pupilcenter{trial}(:,2)./10-pupilall.Left.Light{trial}(:,2)./10;

    % x = (1:numel(y))./400+Newtime(trial+1)./400;
    if RightorLeft==0
        R=R(1:a(trial));
        x = (1:numel(R))-Newtime(trial);
        dX=medfilt1(R,5);
        dX=smooth(dX);
        A=pupilall.Right.pupilcenter{trial}(:,2);
        M = movvar(A,5);
        dX(M>20)=NaN;
        M = movvar(dX,5);
        dX(M>20)=NaN;



        Ry=Ry(1:a(trial));
        x = (1:numel(R))-Newtime(trial);
        Y=medfilt1(Ry,5);
        Y=smooth(Y);
        A=pupilall.Left.pupilcenter{trial}(:,2);
        M = movvar(A,5);
        Y(M>20)=NaN;
        M = movvar(Y,5);
        Y(M>20)=NaN;
        Y = asin(dX./(sqrt(Rpo.^2-Y.^2)));
    else
        L=L(1:a(trial));
        dX=medfilt1(L,5);
        dX=smooth(dX);
        A=pupilall.Left.pupilcenter{trial}(:,2);
        M = movvar(A,5);
        dX(M>20)=NaN;
        M = movvar(dX,5);
        dX(M>20)=NaN;



        Ly=Ly(1:a(trial));
        x = (1:numel(Ly))-Newtime(trial);
        Y=medfilt1(Ly,5);
        Y=smooth(Y);
        A=pupilall.Left.pupilcenter{trial}(:,2);
        M = movvar(A,5);
        Y(M>20)=NaN;
        M = movvar(Y,5);
        Y(M>20)=NaN;
        Y = (asin(dX./sqrt(Rpo.^2-Y.^2)));
        Y = (asin(-dX./sqrt(Rpo.^2-0)));

    end
    if NewLorR(trial)==RightorLeft
        if spoutposition(trial)
            colorcode= 'b';
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
        if inds<26
            continue
        end
        thisy=[220 250];
        thisx= [680 760];
        if Data.Head.Snoutx(trial,inds-25)<thisx(1)||Data.Head.Snoutx(trial,inds-25)>thisx(2)||Data.Head.Snouty(trial,inds-25)<thisy(1)||Data.Head.Snouty(trial,inds-25)>thisy(2)
            continue
        end

        %          plot(Data.Head.Nosex(trial,inds-25),Data.Head.Nosey(trial,inds-25),'.','color',colorcode,'markersize',20)

        %          thisx= [690 150];
        %          thisy=[110 140];
        %            [inds]=find(thisY>1.6,1,'first');
        x = (1:numel(NewallpositionsA(trial,:)))-inds;

        plot(x,rad2deg(medfilt1(NewallpositionsA(trial,:))),colorcode)
        hold on

        subplot (6,1,1)
        plot(x,[0 thisY],colorcode)


        hold on


        subplot (6,1,2)
        x = (1:numel(Y))-inds;
        %         Yangle = Y*10;
        plot(x(x<50),rad2deg(Y(x<50)),colorcode)
        hold on



        subplot (6,1,4)
        x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
        x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
        %         AA =movmean(-medfilt1(Data.RightWhikser.Angel(trial,:),3),5,'includenan');
        AA =-movmean(Data.RightWhikser.Angel(trial,:),10,'includenan');

        plot(x,AA,colorcode)
        hold on


        subplot (6,1,5)

        x = (1:numel(Data.LeftWhikser.Angel(trial,:)))-inds;
        %         AA =movmean(-medfilt1(Data.LeftWhikser.Angel(trial,:),3),5,'includenan');
        AA =-movmean(Data.LeftWhikser.Angel(trial,:),10,'includenan');

        plot(x,AA,colorcode)
        hold on


        subplot (6,1,6)

        %         plot(Data.Spout.LX(trial),Data.Spout.LY(trial),'dk')

        plot(Data.Spout.RX(trial),Data.Spout.RY(trial),'d','color',colorcode)

        hold on
        plot(Data.Head.Snoutx(trial,1:inds+25),Data.Head.Snouty(trial,1:inds+25),'.','color',colorcode,'markersize',10)
        plot(Data.Head.Snoutx(trial,:),Data.Head.Snouty(trial,:),'.','color',colorcode,'markersize',2)

        if inds-25>0
            %                 plot(Data.Head.Nosex(trial,inds-25),Data.Head.Nosey(trial,inds-25),'.','color',colorcode,'markersize',20)
            plot(Data.Head.Snoutx(trial,inds-25),Data.Head.Snouty(trial,inds-25),'.','color',colorcode,'markersize',20)

            thisx= [690 150];
            thisy=[110 140];
        end
        %         end
    end

end


for i=1:5
    subplot (6,1,i)
    xlim([-200 200])
end
