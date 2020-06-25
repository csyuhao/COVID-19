function [tableConfirmed,tableDeaths,tableRecovered,time] = load_data()
% The function [tableConfirmed,tableDeaths,tableRecovered,time] = getDataCOVID
% collect the updated data from the COVID-19 epidemy
% from 2020-01-23 to 2020-06-13 in HuBei Province
% see also fit_SEIQRDP.m SEIQRDP.m
%% Options and names
Ndays = datenum(2020, 06, 13) - datenum(2020, 01, 23) + 1;  % from 2020-01-23 to 2020-06-13
opts = delimitedTextImportOptions("NumVariables", 22);
opts.VariableNames = ["date_time", "newly_confirmed", "newly_recovered", "newly_dead", "aboard", "cur_confirmed", "cur_severe_confirmed", "cur_critical_confirmed", "cur_suspected", "newly_suspected", "useless_1", "useless_2", "confirmed", "recovered", "dead", "useless_3", "useless_4", "useless_5", "useless_6", "useless_7", "useless_8", "URL"];
opts.VariableTypes = ["string", repmat("double", 1, 20), "string"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
%% Import the data
filename = 'data\Hubei.csv';
table =readtable(filename, opts);
%% clean the data
T = standardizeMissing(table, -99);
table = fillmissing(T, 'previous');
tableConfirmed = table.confirmed;
tableDeaths = table.dead;
tableRecovered = table.recovered;
time = datetime(2020,01,23):days(1):datetime(2020, 06, 13);
end