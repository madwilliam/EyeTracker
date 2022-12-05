function [Gaussianlightsourceremoval,devider]= getmaxfitDLC_Arashalgorithm(ImageEye,ind,TLeft,devider,xybias,Gaussianlightsourceremoval)

        [~,~,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
if ~isempty(D)
    


        mapxy = [TLeft.Px1(ind)-biasx,TLeft.Py1(ind)-biasy];
        [~,distance(1),~] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px2(ind)-biasx,TLeft.Py2(ind)-biasy];
        [~,distance(2),~] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px3(ind)-biasx,TLeft.Py3(ind)-biasy];
        [~,distance(3),~] = distance2curve(D(1:2,:)',mapxy);

        mapxy = [TLeft.Px4(ind)-biasx,TLeft.Py4(ind)-biasy];
        [~,distance(4),~] = distance2curve(D(1:2,:)',mapxy);
oldsum=[];
allgaus=[];
alldevider=[];
        counter= 0;
        if sqrt(sum(distance.^2))>7
            Gaussianlightsourceremoval = 2.2;
            devider= 501;
        while sqrt(sum(distance.^2))>7
            devider=devider*0.995;
            if devider<Mindevider
                devider = 501;
                break
            end
            while sqrt(sum(distance.^2))>7
                Gaussianlightsourceremoval=Gaussianlightsourceremoval*0.95;
                if Gaussianlightsourceremoval<minGaussianlightsourceremoval
                    Gaussianlightsourceremoval = 1.8;
                    break
                end
                %             devider=497;
                counter=counter+1;

                [~,~,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);
if isempty(D)
    continue
end

                mapxy = [TLeft.Px1(ind)-biasx,TLeft.Py1(ind)-biasy];
                [~,distance(1),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px2(ind)-biasx,TLeft.Py2(ind)-biasy];
                [~,distance(2),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px3(ind)-biasx,TLeft.Py3(ind)-biasy];
                [~,distance(3),t] = distance2curve(D(1:2,:)',mapxy);

                mapxy = [TLeft.Px4(ind)-biasx,TLeft.Py4(ind)-biasy];
                [~,distance(4),t] = distance2curve(D(1:2,:)',mapxy);
                oldsum(counter)=sqrt(sum(distance.^2));
                allgaus(counter)=Gaussianlightsourceremoval;
                                allgaus(counter)=Gaussianlightsourceremoval;
                                alldevider(counter)=devider;

            end
        end
        Gaussianlightsourceremoval=median(allgaus(oldsum==min(oldsum)));
        devider=median(alldevider(oldsum==min(oldsum)));
        end

        if Gaussianlightsourceremoval<minGaussianlightsourceremoval
Gaussianlightsourceremoval = minGaussianlightsourceremoval;
        end
end