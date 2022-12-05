function result  = extract_trial_number(x,pat,nskip)
    substring = extract(x,pat);
    result = str2num(substring{1}(1:end-nskip));
end