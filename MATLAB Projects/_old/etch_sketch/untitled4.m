clc
clearvars
close all

global tt
tt=1;

tt
tt = tt + 1
ttIncrease(tt)
tt

function bonk = ttIncrease(top)
    global tt
    bonk = top+1
    tt = bonk;
end