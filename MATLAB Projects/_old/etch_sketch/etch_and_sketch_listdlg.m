%movement based on listdlg() function

clc
close all
clearvars

%array: [original X, original Y, new X, new Y]
position{1} = [5,5, 5,5]; 
listCursor = 1;
i = 1;

while true
    
    %array i+1 storing next movements, updating original coords
    position{i+1} = position{i}; 
        position{i+1}(1) = position{i+1}(3);
        position{i+1}(2) = position{i+1}(4);  


    f = plot(position{i+1}(3), position{i+1}(4), 'or'); hold on %current position
        j = 1;
        while j <= i %loop to graph history of all movement lines
            line([position{j}(1),position{j}(3)], [position{j}(2),position{j}(4)]); hold on
            j=j+1;
        end
    axis([0 10 0 10]); 
        movegui(f,[300 400])
    
        hold off;

    %Question List Selection Box listdlg() 
    dlgResponse = listdlg( ...
        'PromptString',{'Which direction ', 'do you want to move?'}, ...
        'SelectionMode','single', ...
        'ListString', ...
        {'Up', 'Left', 'Right', 'Down'}, ...
        'CancelString', 'Exit Movement', ...
        'InitialValue', listCursor);
    
    %Check for CANCEL, ESC, or closing dialogue box; 
    %above function returns empty array
    if isempty(dlgResponse) == 1
        break
    end

    switch dlgResponse 
        case 1 %'Up'
            disp("You chose to move Up")
            position{i+1}(4) = position{i+1}(2) + 1;
            listCursor = 1; %defaults next list selection to currently selected
        case 2 %'Left'
            disp("You chose to move Left")
            position{i+1}(3) = position{i+1}(1) - 1;
            listCursor = 2; 
        case 3 %'Right'
            disp("You chose to move Right")
            position{i+1}(3) = position{i+1}(1) + 1;
            listCursor = 3; 
        case 4 %'Down'
            disp("You chose to move Down")
            position{i+1}(4) = position{i+1}(2) - 1;
            listCursor = 4; 
    end

    i = i+1;

end





