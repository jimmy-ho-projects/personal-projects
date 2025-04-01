clearvars; close all; clc

% uploaded 9 May 2023

% https://www.mathworks.com/help/matlab/import_export/read-streaming-data-from-arduino.html
% serialportlist("available")` use to find available ports
% MATLAB documentation look up serialport

% https://www.mathworks.com/help/matlab/import_export/read-streaming-data-from-arduino.html

arduinoObj = serialport("COM3", 9600);
    configureTerminator(arduinoObj, "CR/LF");
    flush(arduinoObj); %flush serialport of old data

%Prepare the UserData property to store the Arduino data. The Data field of the struct saves the sine wave value and the Count field saves the x-axis value of the sine wave.
arduinoObj.UserData = struct("Data", [], "Count", 1);

% Set the BytesAvailableFcnMode property to "terminator" and the BytesAvailableFcn property to @readSineWaveData. The callback function readSineWaveData is triggered when a new sine wave data (with the terminator) is available to be read from the Arduino.
configureCallback(arduinoObj,"terminator",@readData);



%Create a callback function readSineWaveData that reads the first 1000 ASCII terminated sine wave data points and plots the result.
function readData(src, ~)

%     fid = fopen( 'readings%d.txt', 'wt' );
    % Read the ASCII data from the serialport object.
    data = readline(src);
    disp(data);
%     fprintf(data);

    % Convert the string data to numeric type and save it in the UserData
    % property of the serialport object.
    


    src.UserData.Data(end+1) = str2double(data);


        %nonumerical value, export data to text
    if isnan(str2double(data))
        configureCallback(src, "off");        
        fid = fopen( sprintf('readings %d.txt', src.UserData.Count), 'wt' );
        disp(src.UserData.Data);
    % Update the Count value of the serialport object.
    src.UserData.Count = src.UserData.Count + 1;
        for pp = 1:numel(src.UserData.Data)
            fprintf(fid, '%d', src.UserData.Data(pp));
            fprintf(fid, '\n');
        end
        fclose(fid);
    end


end


