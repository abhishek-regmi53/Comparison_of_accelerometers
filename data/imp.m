function [data]= imp(fname)
%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [24, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["LabVIEWMeasurement", "VarName2", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Import the data
Continuousdata2 = readtable(fname, opts);

%% Convert to output type
Continuousdata2 = table2array(Continuousdata2);
data=Continuousdata2;
%% Clear temporary variables
clear opts