clearvars
close all
clc

S = [640360 479520; ...
    479520 360640]  ;
[Eig_Vectors, Eig_Values] = eig(S);

oig = [ 1000000 0; 0 1000];
Oa= dog(36.86989765) * oig * cat(36.86989765);

fentanyl = dog(-45) * oig * cat(-45)


function y = dog(angle)
    y = [cosd(angle) -sind(angle); sind(angle) cosd(angle)];
end
function y = cat(angle)
    y = [cosd(angle) sind(angle); -sind(angle) cosd(angle)];
end