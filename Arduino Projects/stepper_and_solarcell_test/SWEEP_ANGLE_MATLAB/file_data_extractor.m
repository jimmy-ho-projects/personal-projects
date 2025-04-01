clear
clc
close all

file = load("readings 19.txt");

% readings 19.txt has all the solar cell readings from every trial appended
% to each pther and separated by NaN characters
% Every trial 1201 data points including NaN character
%  Thus every trial 1200 datapoints

for ii = 1:19
    
    trial{ii} = file( (1 + 1201*(ii-1) ) : (1201 + 1201*(ii-1) ) );

end
clear file

% Convert voltage to current (V=IR) for R=1K ohms
for ii = 1:19
    
    trial{ii}(1:end) = trial{ii}(1:end)./1000; 

end