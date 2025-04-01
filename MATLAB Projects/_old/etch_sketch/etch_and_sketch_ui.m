%movement based on uicontrol function
%declaring position and iVar as global variables bc Callback funct do NOT
%return values. 
%https://www.mathworks.com/matlabcentral/answers/1302-how-do-i-get-variables-from-callback-functions-in-matlab
%consider each iVar as a timestep that records a single movement per iVar

clc
close all
clearvars
clear global position
clear global iVar

%array: [original X, original Y, new X, new Y]
global position
    position{1} = [5,5, 5,5]; 
listCursor = 1;
global iVar; %dont use variable i, that complex numbers :(
    iVar = 1;

screenWidth = 600;
screenHeight = 450;

%generating screen with ui controls
mainScreen = figure('Name','Main Screen','Position',[300 400 screenWidth screenHeight]);
subplot(1,1,1)

movementUI = uipanel('Title', 'Movement', 'Units', 'pixels', ...
    'Position', ... %position [left bottom width right]
        [.1*screenWidth, .1*screenHeight, .3*screenWidth, .5*screenHeight]); 
    %Position default [20 20 60 20] 
    a = uicontrol(movementUI, 'Style','pushbutton');
        a.String = 'Up';
        a.Position =  [60 120 60 20];
    b = uicontrol(movementUI, 'Style','pushbutton');
        b.String = 'Down';
        b.Position = [60 70 60 20];
    c = uicontrol(movementUI, 'Style','pushbutton');
        c.String = 'Left';
        c.Position = [20 95 60 20];
    d =  uicontrol(movementUI, 'Style','pushbutton', ...
        'String', 'Right', ...
        'Position', [100 95 60 20]);

%%

%Main Loop
while true 
    %response when button pressed
    a.Callback = @(src,event) move(position, mainScreen, iVar, 'up');
    b.Callback = @(src,event) move(position, mainScreen, iVar, 'down');
    c.Callback = @(src,event) move(position, mainScreen, iVar, 'left');
    d.Callback = @(src,event) move(position, mainScreen, iVar, 'right');   

    uiwait(mainScreen);
% position
end

%%
function [iVar, position] = move(positionVar, mainScreen, iVar2, direction)
    %this function will update current position and start array for next
    %set of movement using embedded function array "arrayNextPosition".
    %Update screen function will plot CURRENT position and line tracing
    %history of movements
    
    global position;
    global iVar;
    % Updating new position values

    switch direction
        case 'up'
            disp("You chose to move Up");
            positionVar{iVar2}(4) = positionVar{iVar2}(2) + 1;
            positionVar{iVar2+1} = arrayNextPosition(positionVar, iVar2);
            position{iVar} = positionVar{iVar};
            position{iVar2+1} = positionVar{iVar2+1};
            iVar = updateScreen(positionVar, iVar2);
        case 'down'
            disp("You chose to move Down")
            positionVar{iVar2}(4) = positionVar{iVar2}(2) - 1;
            positionVar{iVar2+1} = arrayNextPosition(positionVar, iVar2);
            position{iVar2+1} = positionVar{iVar2+1};
            position{iVar} = positionVar{iVar};
            iVar = updateScreen(positionVar, iVar2);
        case 'left'
            disp("You chose to move Left")
            positionVar{iVar2}(3) = positionVar{iVar2}(1) - 1;
            positionVar{iVar2+1} = arrayNextPosition(positionVar, iVar2);
            position{iVar2+1} = positionVar{iVar2+1};
            position{iVar} = positionVar{iVar};
            iVar = updateScreen(positionVar, iVar2);
        case 'right'
            disp("You chose to move Right")
            positionVar{iVar2}(3) = positionVar{iVar2}(1) + 1;
            positionVar{iVar2+1} = arrayNextPosition(positionVar, iVar2);
            position{iVar2+1} = positionVar{iVar2+1};
            position{iVar} = positionVar{iVar};
            iVar = updateScreen(positionVar, iVar2);
    end
    uiresume(mainScreen) %unpauses WHILE TRUE loop

    function nextPos = arrayNextPosition(positionVar, iVar2)
        %array i+1 storing next movements, updating original coords
        positionVar{iVar2+1} = positionVar{iVar2}; 
        positionVar{iVar2+1}(1) = positionVar{iVar2+1}(3);
        positionVar{iVar2+1}(2) = positionVar{iVar2+1}(4);
        nextPos = positionVar{iVar2+1}; %returning values
    end

end

function iVar = updateScreen(positionVar, iVar2)
    %CURRENT: updates screen in response to user movement
    %TODO: also update movement or drawing of other objects in screen
    global iVar;
    subplot(1,2,2)
    plot(positionVar{iVar2}(3), positionVar{iVar2}(4), 'or'); hold on %current position 
        graphMoveHistory(positionVar, iVar2); hold off;
        axis([0 10 0 10]);
    
    iVar = iVar2 + 1; %increment global iVar w dummy iVar2 

    function graphMoveHistory(positionHist, iVar2)
        j = 1;
        %iVar2
        % positionHist
        while j <= iVar2 %loop, graph history of all movement lines
            line([positionHist{j}(1),positionHist{j}(3)], [positionHist{j}(2),positionHist{j}(4)]);
            hold on;
            j=j+1;
        end
    end

end