% (thetrialnumber) = thesetimes;
%
%
%     T = readtable(['\\dk-server.dk.ucsd.edu\afassihizakeri\rightsidemovies\ar38motor\2022_02_16\Lighttime.XLSX']);
% T2 =T{:,:};

% LighttimeLR2=T2([1:400, 500+500:500+400+499],1:end-1);


spoutposition =Data.Spout.LX>360;
figure
Newtime(thetrialnumber(1:numel(thesetimes))+1)=thesetimes;
NewLorR(thetrialnumber(1:numel(thesetimes))+1) =LorR;
for i=1:size(allpositionsA,1)
    %  NewallpositionsA(thetrialnumber(i)+1,:) =allpositionsA(i,:);
    NewallpositionsA(thetrialnumber(i)+1,:) =allpositionsX{1} (i,:);
    
end
for trial=1:111
    if isempty(Pupil38.Right.Light{trial})
        continue
    end
    % y = Pupil38.Left.pupilcenter{trial}(:,1)-Pupil38.Left.Light{trial}(:,1);
    y = Pupil38.Right.distanceall2{trial};
    y = Pupil38.Left.pupilcenter{trial}(:,1)-Pupil38.Left.Light{trial}(:,1);
    % x = (1:numel(y))./400+Newtime(trial+1)./400;
    y=y(1:a(trial));
    x = (1:numel(y))-Newtime(trial);
    
    
    % x = (1:numel(y));
    
    Y=medfilt1(y,5);
%     Y=smooth(Y);
    A=Pupil38.Left.pupilcenter{trial}(:,2);
M = movvar(A,5);
Y(M>20)=NaN;
M = movvar(Y,5);
Y(M>20)=NaN;
    if NewLorR(trial)==0
        if spoutposition(trial)
            colorcode= 'r';
        else
            colorcode= 'b';
            
        end
        
      
        subplot (2,1,2)
        x = (1:numel(NewallpositionsA(trial,:)))-Newtime(trial);
        if NewallpositionsA(trial,(x==100))<600&&NewallpositionsA(trial,(x==100))>200
                plot(x,NewallpositionsA(trial,:),colorcode)
        hold on
        
            subplot (2,1,1)

            x = (1:numel(Y))-Newtime(trial);

          plot(x,Y,colorcode)
              hold on
        end
    end
    % % plot(Pupil38.Left.pupilcenter{trial}(:,2))
    % hold on
end
xlim([-300 300])
