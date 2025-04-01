%button response using anonymous function
clc
    close all
    clearvars

 i = 1

f = figure;
ax = axes(f);
ax.Units = 'pixels';
ax.Position = [75 75 325 280];
c = uicontrol;
c.String = 'Plot Data';
c.Callback = @(src, event) disp(5); %@plotButtonPushed;
i

    function plotButtonPushed(src,event)
        bar(randn(1,5));
    end

