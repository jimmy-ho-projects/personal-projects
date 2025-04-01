%CODE BASED ON ETCH % SKETCH
    %TODO: update movement or drawing of other objects in screen
    %TODO: sector-based axis
    %TODO: ONLY draw what is within a sector
    %TODO: modular map.txt file containing coordinates of various objects
    %that can exist within screen (ex: walls you cannot pass)

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
clear global sectors

%% Global Variable Initialization

%array: [original X, original Y, new X, new Y]
global position;
    position{1} = [5,5, 5,5]; %<- initial position, both should be same

global iVar; %dont use variable i, its complex numbers :(
    iVar = 1;

%generating Sectors (do once); sector{index}(border) 
global sectors;
    % Sectors should be decimal value (ex: 0.5) more than integer to prevent 
    % edge-cases/sector conflicts. 
    maxBorders = [0 100 0 100]; %[min X, max X, min Y, max Y]
    sectorSize = [10 10]; %size of each Sector [x axis, y axis]
        horizSectNum = abs(maxBorders(1)+maxBorders(2))/sectorSize(1); 
        vertSectNum = abs(maxBorders(3)+maxBorders(4))/sectorSize(2);
        numSect = horizSectNum * vertSectNum; %rectangular grid
    for pig = 1 : horizSectNum
        for cow = 1:vertSectNum
            ind = sub2ind([vertSectNum,horizSectNum],pig,cow);
            sectors{ind} = [ ...
                maxBorders(1) + (pig-1)*(sectorSize(1)), ...   %minX
                maxBorders(1) + (pig)*sectorSize(1), ...       %maxX
                maxBorders(3) + (cow-1)*(sectorSize(2)), ...   %minY
                maxBorders(3) + (cow)*sectorSize(2), ...       %maxY
                0, ...
                0];
                sectors{ind}(5) = (sectors{ind}(2)+sectors{ind}(1))/2; %centerX 
                sectors{ind}(6) = (sectors{ind}(4)+sectors{ind}(3))/2; %centerY
        end           
    end

    %Determine Starting Sector from starting position
    currentSector(position,1,numSect);
    



%% Screen Initialization

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

    global iVar;
    subplot(1,2,2)
    plot(positionVar{iVar2}(3), positionVar{iVar2}(4), 'or'); hold on %current position 
        graphMoveHistory(positionVar, iVar2); hold off;
    axis([0 10 0 10]);
        %------>        %axis(currentSector(positionVar, iVar));
    
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

function poloko = currentSector(positionVar, iVar, numSect)
    global sectors
    % checks radius 10 units around current position to check if within 
    % a specific sector's borders by comparing to position to sector center. 
    % Closest center corresponds to that sector; shift sector to that axis. 
    % Returns "currentSector" as array to determine axis of plot
    %EX: sector 1: [-0.5, 10.5, -0.5, 10.5]
        %sector 1 center: [x,y] = [(9+5.5)/2 , (9+5.5)/2], 
        %center are 11 units away from each other
    
    currentPos = [positionVar{iVar}(1), positionVar{iVar}(2)]; %[x,y]
    for ii = 1:numSect
        ff(ii) = abs(currentPos(1) - sectors{ii}(5));
        gg(ii) = abs(currentPos(2) - sectors{ii}(6));
    end
    %find index of where minimum value located in ff (for x axis) or gg (for y axis) 
        indMinDistanceX = find(ff == min(ff)); 
        indMinDistanceY = find(gg == min(gg));
        for jk = 1:numel(indMinDistanceX)
            find(indMinDistanceX(jk) == indMinDistanceY)
        end
    






    %TODO
%             [row, column] = find( ...
%                 sectors(:, 5) > currentPos(1)-10  & sectors(:, 5) < currentPos(1)+10 & ...
%                 sectors(:, 6) > currentPos(2)-10  & sectors(:, 6) < currentPos(2)+10)
        
end