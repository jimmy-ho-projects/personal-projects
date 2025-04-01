%This function is used by the ODE solver to determine reaction rates
%at each time step. This file must be save with the name of the equation.
%You can use this equation with the accompanying introtoODEs.m
%This is the example for a generic reaction:
% Enzyme + Substrate <- -> Complex -> Product

function ydot = tutorialfunction(t, y, k) %Function named example (hence example.m)
%Create an output array
ydot = zeros(4, 1); %Four rows, one per species (four in this case)

%Define variables based on input initial conditions array
%For example, if the array is y = [1 3 8 10], y(2) will call the value 3
Substrate = y(1);
Enzyme = y(2);
Complex = y(3);
Product = y(4);

%Define rate constants
k1 = k(1);
k2 = k(2);
k3 = k(3);

%Governing equations
ydot(1) = -k1 * Substrate * Enzyme + k2 * Complex; 
ydot(2) = -k1 * Substrate * Enzyme + k2 * Complex + k3 * Complex;
ydot(3) = k1 * Substrate * Enzyme - k2 * Complex - k3 * Complex;
ydot(4) = k3 * Complex;
end