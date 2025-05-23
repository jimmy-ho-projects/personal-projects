clearvars
close all
clc
primes = [2	3	5	7	11	13	17	19	23	29 31	37	41	43	47	53	59	61	67	71 ...
73	79	83	89	97	101	103	107	109	113 ...
127	131	137	139	149	151	157	163	167	173 ...
179	181	191	193	197	199	211	223	227	229 ...
233	239	241	251	257	263	269	271	277	281 ...
283	293];

%User specifies how many degrees to rotate per prime number hit
disp("How many degrees should the vectors rotate for every prime it hits?");
userRotate = input("> ");

x=0; y=0; u=1; v=0;
    quiver(x,y,u,v); hold on %hard code first vector
        xNext = x + u;
        yNext = y + v;
primeCounter = 1; %incrememnt to index through primes list
rotationDeg = 0; %increments through rotation degrees (hypotenuse length = 1)

%simple rotating vectors
for i = 2:primes(length(primes)) %iterate until reach value at last index of "primes"    

    %update u,v in terms of current degree
    u = cosd(rotationDeg);
    v = sind(rotationDeg);
        quiver(xNext,yNext,u,v); hold on

    %move to new (x,y) coord AFTER graph, BEFORE changing rotation
    xNext = xNext + cosd(rotationDeg);
    yNext = yNext + sind(rotationDeg);

    if i >= primes(primeCounter) 
        primeCounter = primeCounter + 1;
        rotationDeg = rotationDeg + userRotate;        
    end

    pause(.005);
end


