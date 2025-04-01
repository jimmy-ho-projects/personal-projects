
% -----
% YOU WILL NEED TO EDIT THESE LINES BEFORE THE SCRIPT WILL WORK
initialConditions =[5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0]; %ENCODE INITIAL CONDITIONS HERE
k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 0.3 1.15 8.2 32 1e5 24 44 0.001 70 0.02];
time = [0 250];
opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %This is REQUIRED for simulation
[t,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);

%Simulation 2 - "Does not include degradation of VIIIa-IXa"
%You start by just copying and pasting the code block from Simulation 1
%Edit k so that k20 is now zero, to prevent degradation of VIIIa-IXa
%Give a new output variables [t2, y2]
k(20) = 0
time = [0 250];
opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %This is REQUIRED for simulation
[t2,y2] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);


%Figure 2A - Thrombin formation
%Thrombin exists as both IIa and mIIa, which, as given here will be the 9th
%and 11th columns of the outputs y and y2. 

%The legend states:
%"the relative specific activity for alphaIIa = 1 and mIIa = 1.2. 100%
%formation corresponds to the complete formations of alphaIIa (1.4 uM)"
%You can create variables called thrombin for simulation 1 and thrombin2
%for simulation2

thrombin = (y(:,9) + 1.2 * y(:,11)) / 1.4e-6 * 100; %note the 1.2x scaling
thrombin2 = (y2(:,9) + 1.2 * y2(:,11)) / 1.4e-6 * 100; %note y2 is called

f2a = figure;
plot(t, thrombin); %plot t from the first simulation vs thrombin
hold on %A "hold on" command lets you add more data to a single plot
plot(t2, thrombin2); %plot t2, from the 2nd simulation, vs thrombin2
legend("Basic Model","Alternate Model"); %Legend
xlabel("time, s");
ylabel("% Thrombin formation");
saveas(f2a,"figure2a.png");
hold off



return


%Figure 2B - Factor Xa formation
%As described in the legend, Factor Xa exists as Xa, VaXa, and VaXaII, 
%which as given here will be the 16th, 8th and 10th columns of the 
%outputs. The legend states "100% formation corresponds to the complete 
%formation of Xa (170 nM)

factorXa = (y(:,16) + y(:,8) + y(:,10)) / 170e-9 * 100; %No scaling
factorXa2 = (y2(:,16) + y2(:,8) + y2(:,10)) / 170e-9 * 100;

f2b = figure;
plot(t, factorXa);
hold on ;
plot(t2, factorXa2);
legend("Basic Model","Alternate Model"); %Legend
xlabel("time, s");
ylabel("% Faxtor Xa formation"); %Note the change 
saveas(f2b,"figure2b.png");
hold off;

%Figure 2C - % Factor IXa formation
%As described in the legend, Factor IXa exists as IXa, VIIIaIXa and
%VIIIaIXaX. "100% formation corresponds to the complete 
%formation of IXa (90 nM). Here this corresponds to the 15th, 14th and 7th
%columns of the output arrays)

factorIXa = (y(:,15) + y(:,14) + y(:,7)) / 90e-9 * 100;
factorIXa2 = (y2(:,15) + y2(:,14) + y2(:,7)) / 90e-9 * 100;

f2c = figure;
plot(t, factorIXa); %selecting the second column, which is Enzyme
hold on %A "hold on" command lets you add more data to a single plot
plot(t2, factorIXa2); %selecting thte third column, which is Complex
legend("Basic Model","Alternate Model"); %Legend
xlabel("time, s");
ylabel("% Factor IXa formation");
saveas(f2c,"figure2c.png");
hold off


function ydot = coagulation(t, y, k)

% ydot = zeros(18,1);

k1= k(1);
k2= k(2);
k3= k(3);
k4= k(4);
k5= k(5);
k6= k(6);
k7= k(7);
k8= k(8);
k9= k(9);
k10= k(10);
k11= k(11);
k12= k(12);
k13= k(13);
k14= k(14);
k15= k(15);
k16= k(16);
k17= k(17);
k18= k(18);
k19= k(19);
k20= k(20);

TFVIIa = y(1);
IX = y(2);
X = y(3);
V = y(4);
VIII = y(5);
II = y(6);
VIIIaIXa = y(7);
VaXa = y(8);
IIa = y(9);
VaXaII = y(10);
mIIa = y(11);
TFVIIaIX = y(12);
TFVIIaX = y(13);
VIIIaIXaX = y(14);
IXa = y(15);
Xa = y(16);
Va = y(17);
VIIIa = y(18);
diff = zeros(18,1);

    diff(1)= ( k11 * (TFVIIaIX) ) - ( k6 * (TFVIIa) * (IX) ) + ...
            (k16 * (TFVIIaIX) ) + ( k12 * (TFVIIaX) ) - ...
            (k6 * (TFVIIa) * (X) ) + (k17 * (TFVIIaX) );

    diff(2)= (k16*(TFVIIaIX)) - (k6*(TFVIIa)*(IX)) - (k15*(IX)*(Xa)) ...
            - (k15*(IX)*(VaXa));

    diff(3)= (k17*(TFVIIaX)) - (k6*(TFVIIa)*(X)) - ...
            (k6*(VIIIaIXa)*X) +(k18*(VIIIaIXaX));

    diff(4)= (-k1*(V)*Xa) - (k2*V*IIa) - (k2*V*mIIa);

    diff(5)= (-k3*VIII*Xa) - (k4*VIII*IIa) - (k4*VIII*mIIa);

    diff(6)= (k19*VaXaII) - (k6*VaXa*II);

    diff(7)= (k7*VIIIa*IXa) - (k9*VIIIaIXa) - (k6*VIIIaIXa*X) + ...
            (k18*VIIIaIXaX) + (k13*VIIIaIXaX) - ...
            - (k20 * VIIIaIXa);

    diff(8)= (k8*Xa*Va) - (k10*VaXa) + (k19*VaXaII) - ...
            (k6*VaXa*II) + (k14 * VaXaII);

    diff(9)= k5*VaXa*mIIa;

    diff(10)= (k6*VaXa*II) - (k19*VaXaII) - (k14*VaXaII);

    diff(11)= (k14*VaXaII) - (k5*VaXa*mIIa);

    diff(12)= (k6*TFVIIa*IX) - (k16*TFVIIaIX) - (k11*TFVIIaIX);

    diff(13)= (k6*TFVIIa*X) - (k17*TFVIIaX) - (k12*TFVIIaX);

    diff(14)= (k6*VIIIaIXa*X) - (k18*VIIIaIXaX) - (k13*VIIIaIXaX);

    diff(15)= (k9*VIIIaIXa) - (k7*VIIIa*IXa) + (k11*TFVIIaIX) + ...
                (k15*IX*Xa) + (k15*IX*VaXa);

    diff(16)= (k10*VaXa) - (k8*Xa*Va) + (k12*TFVIIaX) + (k13*VIIIaIXaX);
    
    diff(17)= (k10*VaXa) - (k8*Xa*Va) + (k1*V*Xa) + (k2*V*IIa) + (k2*V*mIIa);

    diff(18)= (k9*VIIIaIXa) - (k7*VIIIa*IXa) + (k3*VIII*Xa) + ...
                (k4*VIII*IIa)+(k4*VIII*mIIa);
% ydot(1)=k11 * TFVIIaIX - k6 * TFVIIa * IX + k16 * TFVIIaIX + k12 ...
%     * TFVIIaX - k6 * TFVIIa * X + k17 * TFVIIaX;
% ydot(2)=k16 * TFVIIaIX - k6 * TFVIIa * IX - k15 * IX * Xa - k15 * IX * VaXa;
% ydot(3)=k17 * TFVIIaX - k6 * TFVIIa * X - k6 * VIIIaIXa * X + k18 * ...
%     VIIIaIXaX;
% ydot(4)= -k1 * V * Xa - k2 * V * IIa * - k2 * V * mIIa;
% ydot(5)= -k3 * VIII * Xa - k4 * VIII * IIa - k4 * VIII * mIIa;
% ydot(6)= k19 * VaXaII - k6 * VaXa * II;
% ydot(7)= k7 * VIIIa * IXa - k9 * VIIIaIXa - k6 * VIIIaIXa * X + k18 ...
%     * VIIIaIXaX + k13 * VIIIaIXaX - k20 * VIIIaIXa;
% ydot(8)= k8 * Xa * Va - k10 * VaXa + k19 * VaXaII - k6 * VaXa * II ...
%     + k14 * VaXaII;
% ydot(9)= k5 * VaXa * mIIa;
% ydot(10)= k6 * VaXa * II - k19 * VaXaII - k14 * VaXaII;
% ydot(11)= k14 * VaXaII - k5 * VaXa * mIIa;
% ydot(12)= k6 * TFVIIa * IX - k16 * TFVIIaIX - k11 * TFVIIaIX;
% ydot(13)= k6 * TFVIIa * X - k17 * TFVIIaX - k12 * TFVIIaX;
% ydot(14)= k6 * VIIIaIXa * X - k18 * VIIIaIXaX - k13 * VIIIaIXaX;
% ydot(15)= k9 * VIIIaIXa - k7 * VIIIa * IXa + k11 * TFVIIaIX + k15 * IX * Xa ...
%     + k15 * IX * VaXa;
% ydot(16)= k10 * VaXa - k8 * Xa * Va + k12 * TFVIIaX + k13 * VIIIaIXaX;
% ydot(17)= k10 * VaXa - k8 * Xa * Va + k1 * V * Xa + k2 * V * IIa + k2 * ...
%     V * mIIa;
% ydot(18)= k9 * VIIIaIXa - k7 * VIIIaIXa + k3 * VIII * Xa + k4 * VIII ...
%     * IIa + k4 * VIII * mIIa;
end