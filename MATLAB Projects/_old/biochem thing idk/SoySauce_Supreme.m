clearvars
close all
clc

% E = [96.05, 0; ...
%      0    , 23.95];

% M = dog(28.15) * E * cat(28.15);
%     disp("Matrix of R * (eigenthing) * R^T ")
%     disp(M)
%     disp(" ")
% K = dog(28.15) * E * dog(28.15);
%     disp("Matrix of R * (eigenthing) * R ")
%     disp(K)
%     disp(" ")
% 
% function ul = dog(angle)
%     ul = [ cosd(angle), -sind(angle) ; ...
%          sind(angle), cosd(angle)   ];
% end
% 
% function ol = cat(angle)
%     ol = [ cosd(angle), sind(angle) ; ...
%           -sind(angle), cosd(angle)   ];
% end

M = [30 80; 40 30];

[V,D] = eig(M)