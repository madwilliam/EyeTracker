classdef ExperimentProcessor
   methods(Static)
       function trials = get_trials(folder_path)
            files = dir(folder_path);
            files = {files.name};
            trials = [];
            for file = files
                pat = digitsPattern+wildcardPattern;
                trial_number = extract(file,pat);
                if numel(trial_number)==0
                    continue
                end
                if numel(trial_number) > 1
                    trials = [trials str2num(trial_number{1})];
                end
            end
            trials = unique(trials);
            trials = sort(trials);
       end
   end
end