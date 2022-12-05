function  [Gaussianlightsourceremoval ] =Checkiflightsourceisinsiedthepupil(ImageEye,ind,TLeft,devider,xybias,Gaussianlightsourceremoval);

        [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);

 if (size(stats.Centroid,1))>1
                    tf = checkifinROI(s,stats,Ratio);
                while tf==1

                    Gaussianlightsourceremoval=Gaussianlightsourceremoval*0.95;
                    if Gaussianlightsourceremoval<minGaussianlightsourceremoval
                        Gaussianlightsourceremoval = 1.8;
                        break
                    end
                    [stats,s,D]=ExtractEYEinfo(ImageEye,ind,TLeft,0,devider,xybias,Gaussianlightsourceremoval);

                    tf = checkifinROI(s,stats,Ratio);

                    if isempty(D)
                        break
                    end
                end
 end