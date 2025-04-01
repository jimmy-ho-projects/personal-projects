clc
close all
clearvars

a = [1,1,1,1;
     1,3,5,7]; %red channel
b = [2,0,2,0;
     0,1,0,1]; %green channel
c = ones(2,4);

d=cat(3,a,b,c);

figure; imagesc(a)
figure; imagesc(b)
figure; imagesc(c)
figure; imagesc(d); 