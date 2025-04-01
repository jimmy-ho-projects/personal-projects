% INSTRUCTIONS FOR USE
% --------------------
% This function will be numerically integrated by ode23s. It takes
% concentrations (y) and rate constants (k) at a defined time and calculates
% changes in concentration at that moment (ydot).
% To make it easier to write the governing equations, the function takes
% the input rate array and assigns each entry to unique variables (k1, k2, etc.)
% Then, the function takes the starting concentrations in y and assigns them
% names that match Jones1994. THE ORDER MATCHES THE ORDER THAT THE RATE
% EQUATIONS ARE PRESENTED IN THE PAPER.
% 
% We have provided two governing equations.
% 
% You will need to encode the
% remaining 16.

function ydot = coagulation(t, y, k)
% This constructs matrix for output values to be stored. There will be 
% 18 dependent variables.
ydot = zeros(18,1);

% Unpacking the rate constants
k1=k(1);
k2=k(2);
k3=k(3);
k4=k(4);
k5=k(5);
k6=k(6);
k7=k(7);
k8=k(8);
k9=k(9);
k10=k(10);
k11=k(11);
k12=k(12);
k13=k(13);
k14=k(14);
k15=k(15);
k16=k(16);
k17=k(17);
k18=k(18);
k19=k(19);
k20=k(20);

% Defining Concentrations
TFVIIa = y(1); %
IX = y(2); % 90 nM
X = y(3); % 170 nM
V = y(4); % 20 nM
VIII = y(5);% 0.7 nM
II = y(6); 
VIIIaIXa = y(7); 
VaXa = y(8); 
IIa = y(9); %1.4 microM
VaXaII = y(10); 
mIIa = y(11); 
TFVIIaIX = y(12); 
TFVIIaX = y(13); 
VIIIaIXaX = y(14); 
IXa = y(15); 
Xa = y(16); 
Va = y(17); 
VIIIa = y(18); 


% Governing equations
% Long lines can be broken with ...
ydot(1)=k11 * TFVIIaIX - k6 * TFVIIa * IX + k16 * TFVIIaIX + k12 ...
    * TFVIIaX - k6 * TFVIIa * X + k17 * TFVIIaX;
ydot(2)= k12 * TFVIIaIX - k6 * TFVIIa * IX - k15 * IX * Xa - k15 ...
    * IX * VaXa; %begin completing the remaining equations here.
ydot(3)= k17 * TFVIIaX - k6 * TFVIIa * X -k6 * VIIIaIXa * X + k18 ...
    * VIIIaIXaX;
ydot(4)= -k1 * V * Xa - k2 * V * IIa - k2 * V * mIIa;
ydot(5)= -k3 * VIII * Xa - k4 * VIII * IIa - k4 * VIII * mIIa;
ydot(6)= k19 * VaXaII - k6 * VaXa * II;
ydot(7)= k7 * VIIIa * IXa - k9 * VIIIaIXa - k6 * VIIIaIXa * X + k18 ...
    * VIIIaIXaX + k13 * VIIIaIXaX - k20 * VIIIaIXa;
ydot(8)= k8 * Xa * Va - k10 * VaXa + k19 * VaXaII - k6 * VaXa * II ...
    + k14 * VaXaII;
ydot(9)= k5 * VaXa * mIIa;
ydot(10)= k6 * VaXa * II - k19 * VaXaII - k14 * VaXaII;
ydot(11)= k14 * VaXaII - k5 * VaXa * mIIa;
ydot(12)= k6 * TFVIIa * IX - k16 * TFVIIaIX - k11 * TFVIIaIX;
ydot(13)= k6 * TFVIIa * X - k17 * TFVIIaX - k12 * TFVIIaX;
ydot(14)= k6 * VIIIaIXa * X - k18 * VIIIaIXaX - k13 * VIIIaIXaX;
ydot(15)= k9 * VIIIaIXa - k7 * VIIIa * IXa + k11 * TFVIIaIX + k15 ...
    * IX * Xa + k15 * IX * VaXa;
ydot(16)= k10 * VaXa - k8 * Xa * Va + k12 * TFVIIaX + k13 * VIIIaIXaX;
ydot(17)= k10 * VaXa - k8 * Xa * Va + k1 * V * Xa + k2 * V * IIa ...
    + k2 * V * mIIa;
ydot(18)= k9 * VIIIaIXa - k7 * VIIIa * IXa + k3 * VIII * Xa + k4 ...
    * VIII * IIa + k4 * VIII * mIIa;
end

