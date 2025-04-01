clc
close all
clearvars

cube = zeros(5,5,5);
    cube(2:4,2:4,:) = 1;

bleg = zeros(5,5,5);
    bleg(1,1,:) = 1;

[r, c, Z] = ind2sub([5,5,5],cube);
    