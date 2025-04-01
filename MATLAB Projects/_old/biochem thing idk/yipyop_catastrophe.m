clc
close all
clearvars

%used code from McKee (sample .mat files), and initial conditions
%formatting from Madre Juhaina

%%%%%%%%%%%%
%==SIM 1==%
%%%%%%%%%%%%
%RATE CONSTANTS
k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
initialConditions = ...
    [5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0]
time = [0 250];

opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
[t,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);



%%%%%%%%%%%%
%==SIM 2==%
%%%%%%%%%%%%
k(20) = 0;  %"Does not include degradation of VIIIa-IXa"
time = [0 250];

opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %This is REQUIRED for simulation
[t2,y2] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 1A - Thrombin formation
thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1.4e-6 * 100;
figure('Name', "Figure 1A - Thrombin formation")
    plot(t,thrombin); 
    xlabel('% Thrombin formation'); ylabel('Time (seconds)');

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 1B - Thrombin formation (microM)
thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1.4e-6;
figure('Name', "Figure 1B - Thrombin formation")
    plot(t,thrombin); hold on

    %%%%%%%%%%%%
    %==SIM 3==%
    %%%%%%%%%%%%
    %RATE CONSTANTS
    k = [2e7 2e7 1e7 2e6 1e7 1e8 1e6 4e8 0.0005 0.4 ...
         0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
    initialConditions = ...
        [5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0];
    time = [0 250];    
        opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
        [t3,y3] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);

thrombin2  = ( y3(:,9) + 1.2 * y3(:,11) ) / 1.4e-6;
    plot(t3,thrombin2, '.-m'); hold on
    
    %%%%%%%%%%%%
    %==SIM 4==%
    %%%%%%%%%%%%
    %RATE CONSTANTS
    k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e7 0.005 0.04 ...
         0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
    initialConditions = ...
        [5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0];
    time = [0 250];    
        opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
        [t4,y4] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);

thrombin3  = ( y4(:,9) + 1.2 * y4(:,11) ) / 1.4e-6;
    plot(t4,thrombin3,'--'); 

    xlabel('Thrombin formation (microM)'); ylabel('Time (seconds)');
    legend('Initial Model', 'K7 = 1e6, k9 = 0.0005', 'k8 = 4e7, k10=0.04 (switched???)' )

    %--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 2A - Thrombin formation
%   Thrombin exists as both IIa and mIIa, which, 
%   given as 9nd and 11th columns of the outputs y and y2 
%The legend states:
%   "the relative specific activity for alphaIIa = 1 and mIIa = 1.2. 
%   100% formation corresponds to the complete formations of alphaIIa (1.4 uM)"
%   You can create variables called thrombin for simulation 1 and thrombin2
%   for simulation2

thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1.4e-6 * 100; %1.2x scaling for mIIa
thrombin2 = (y2(:,9) + 1.2 * y2(:,11)) / 1.4e-6 * 100; %note y2 is called (2nd sim)

figure('Name', "Figure 2A - Thrombin formation")
    plot(t, thrombin); %plot t, first simulation vs thrombin
        hold on 
    plot(t2, thrombin2); %plot t2, 2nd simulation vs thrombin2
        legend("Basic Model","Alternate Model"); 
        xlabel("time, s");
        ylabel("% Thrombin formation");

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 2B - Factor Xa formation
%   As described in the legend, Factor Xa exists as Xa, VaXa, and VaXaII, 
%   which as given here will be the 16th, 8th and 10th columns of the 
%   outputs. The legend states "100% formation corresponds to the complete 
%   formation of Xa (170 nM)

factorXa = (y(:,16) + y(:,8) + y(:,10)) / 170e-9 * 100; %No scaling
factorXa2 = (y2(:,16) + y2(:,8) + y2(:,10)) / 170e-9 * 100;

figure('Name','Figure 2B - Factor Xa formation')
    plot(t, factorXa); hold on ;
    plot(t2, factorXa2);
        legend("Basic Model","Alternate Model"); 
        xlabel("time, s");
        ylabel("% Faxtor Xa formation"); %Note the change        

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 2C - % Factor IXa formation
%   As described in the legend, Factor IXa exists as IXa, VIIIaIXa and
%   VIIIaIXaX. "100% formation corresponds to the complete 
%   formation of IXa (90 nM). Here this corresponds to the 15th, 14th and 7th
%   columns of the output arrays)

factorIXa = (y(:,15) + y(:,14) + y(:,7)) / 90e-9 * 100;
factorIXa2 = (y2(:,15) + y2(:,14) + y2(:,7)) / 90e-9 * 100;

figure('Name','Figure 2C - % Factor IXa formation')
    plot(t, factorIXa); %selecting the second column, which is Enzyme
        hold on %A "hold on" command lets you add more data to a single plot
    plot(t2, factorIXa2); %selecting thte third column, which is Complex
        legend("Basic Model","Alternate Model"); %Legend
        xlabel("time, s");
        ylabel("% Factor IXa formation");

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 3 - Reaction Progress for Each Protein

thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1.4e-6 * 100;
Xa = (y(:,16)+y(:,8)+y(:,10)) / 170e-9 * 100;
Ixa = (y(:,15) + y(:,7) +  y(:,14) ) / 90e-9 * 100;
V = y(:,4) / 20e-9 * 100;
Viii = y(:,5) / 0.7e-9 * 100;
figure('Name', "Figure 3 Reaction Progress for Each Protein")
    plot(t,thrombin); hold on
    plot(t,Xa); hold on
    plot(t,Ixa); hold on
    plot(t,V); hold on
    plot(t,Viii);
        title('The reaction progress for each protein');
        legend('Thrombin', 'Xa', 'IXa', 'V', 'VIII');
        xlabel('Time (seconds)'); ylabel('% Formation/degradation');

%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%--%
%Figure 4 - The effect of tissue factor-factor VIIa concentration

    %%%%%%%%%%%%
    %==SIM 5==%
    %%%%%%%%%%%%
    %RATE CONSTANTS
    k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
         0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
    initialConditions = ...
        [5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0]
    time = [0 250];
        %TF_VIIa = 5e-12 (original)
            opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
            [t,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
        %TF_VIIa = 10e-12
            initialConditions(1) = 10e-12;
                opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
                [t2,y2] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
        %TF_VIIa = 50e-12
            initialConditions(1) = 50e-12;
                opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
                [t3,y3] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
        %TF_VIIa = 500e-12
            initialConditions(1) = 500e-12;
                opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
                [t4,y4] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
        %TF_VIIa = 5e-9
            initialConditions(1) = 50e-9;
                opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
                [t5,y5] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);

thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1.4e-6 * 100;
goose2 = ( y2(:,9) + 1.2 * y2(:,11) ) / 1.4e-6 * 100;
goose3 = ( y3(:,9) + 1.2 * y3(:,11) ) / 1.4e-6 * 100;
alien = ( y4(:,9) + 1.2 * y4(:,11) ) / 1.4e-6 * 100;
dog = ( y5(:,9) + 1.2 * y5(:,11) ) / 1.4e-6 * 100;

figure('Name', "Figure 4 The effect of tissue factor-factor VIIa concentration")
    plot(t,thrombin); hold on
    plot(t2, goose2); hold on
    plot(t3, goose3); hold on
    plot(t4, alien); hold on
    plot(t5, dog);
        xlabel('Time (seconds)'); ylabel('Thrombin Formation (microM)');
        legend('TF*VIIa = 5e-12', 'TF*VIIa = 10e-12', 'TF*VIIa = 50e-12', ...
            'TF*VIIa =500e-12', 'TF*VIIa = 5e-9');



%FIG 6%
%defaults
figure('Name','Figure 6 graphing')
k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
initialConditions = ...
    [5e-12 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0]
time = [0 250];

opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %option for ode23s function
[t,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
    thrombin  = ( y(:,9) + 1.2 * y(:,11) ) / 1e-6;
    plot(t,thrombin,'-r'); hold on

k = [2e7 0 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
[t2,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
    thrombin2  = ( y(:,9) + 1.2 * y(:,11) ) / 1e-6;
    plot(t2,thrombin2); hold on

k = [0 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
[t3,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
    thrombin3  = ( y(:,9) + 1.2 * y(:,11) ) / 1e-6;
    plot(t3,thrombin3); hold on

k = [2e7 2e7 1e7 0 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
[tonk,y] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions, opts);
    thrombintonk  = ( y(:,9) + 1.2 * y(:,11) ) / 1e-6;
    plot(tonk,thrombintonk); hold on

    legend('Default', 'k2=0', 'k1 = 0', 'k4=0');
    ylabel('Thrombin Formation (microM)'); xlabel('Time (sec)');
    hold off






f5b = figure; 
initialConditions1 =[1e-9 9e-8 1.7e-7 2e-8 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0];
initialConditions2 =[5e-12 9e-8 1.7e-7 2e-8 0 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0];
initialConditions3 =[5e-12 9e-8 1.7e-7 0 7e-10 1.4e-6 0 0 0 0 0 0 0 0 0 0 0 0];
k = [2e7 2e7 1e7 2e6 1e7 1e8 1e7 4e8 0.005 0.4 ...
     0.3 1.15 8.2 32 1e5 24  44  0.001 70  0.02 ]; 
[t1,y1] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions1, opts);
[t2,y2] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions2, opts);
[t3,y3] = ode23s(@(t,y) coagulation(t, y, k), time, initialConditions3, opts);
thrombin9 = (y1(:,9) + 1.2 * y1(:,11))/1e-6;
thrombin10 = (y2(:,9) + 1.2 * y2(:,11))/1e-6;
thrombin11 = (y3(:,9) + 1.2 * y3(:,11))/1e-6;
plot(t1, thrombin9);
hold on; 
plot(t2, thrombin10);
hold on; 
plot(t3, thrombin11);
hold on;
legend("Thrombin TFVIIa = 1nm ", "Thrombin 0 at VIII","Thrombin 0 at V "); 
xlabel("time, s");
ylabel("Thrombin Formation ");
saveas(f5b,"figure5b.png");
hold off;










function diff = coagulation(t,y,k)
%   RATE CONSTANTS (K defined outside of this "function")
    k1=k(1);    k10=k(10);  k19=k(19);
    k2=k(2);    k11=k(11);  k20=k(20);
    k3=k(3);    k12=k(12);
    k4=k(4);    k13=k(13);
    k5=k(5);    k14=k(14); 
    k6=k(6);    k15=k(15);
    k7=k(7);    k16=k(16);
    k8=k(8);    k17=k(17); 
    k9=k(9);    k18=k(18);

%   INITIAL CONDITIONS 
%   when function is called, initial conditions providedin an array "y"
    TF_VIIa = y(1); %
    IX = y(2); % 90 nM
    X = y(3); % 170 nM
    V = y(4); % 20 nM
    VIII = y(5);% 0.7 nM
    II = y(6); %Prothrombin 1.4 microM
    VIIIa_IXa = y(7); 
    Va_Xa = y(8); 
    IIa = y(9); 
    Va_Xa_II = y(10); 
    mIIa = y(11); 
    TF_VIIa_IX = y(12); 
    TF_VIIa_X = y(13); 
    VIIIa_IXa_X = y(14); 
    IXa = y(15); 
    Xa = y(16); 
    Va = y(17); 
    VIIIa = y(18); 

    %defining the ODEs
    diff = zeros(18,1);

    diff(1)= ( k11 * (TF_VIIa_IX) ) - ( k6 * (TF_VIIa) * (IX) ) + ...
            (k16 * (TF_VIIa_IX) ) + ( k12 * (TF_VIIa_X) ) - ...
            (k6 * (TF_VIIa) * (X) ) + (k17 * (TF_VIIa_X) );

    diff(2)= (k16*(TF_VIIa_IX)) - (k6*(TF_VIIa)*(IX)) - (k15*(IX)*(Xa)) ...
            - (k15*(IX)*(Va_Xa));

    diff(3)= (k17*(TF_VIIa_X)) - (k6*(TF_VIIa)*(X)) - ...
            (k6*(VIIIa_IXa)*X) +(k18*(VIIIa_IXa_X));

    diff(4)= (-k1*(V)*Xa) - (k2*V*IIa) - (k2*V*mIIa);

    diff(5)= (-k3*VIII*Xa) - (k4*VIII*IIa) - (k4*VIII*mIIa);

    diff(6)= (k19*Va_Xa_II) - (k6*Va_Xa*II);

    diff(7)= (k7*VIIIa*IXa) - (k9*VIIIa_IXa) - (k6*VIIIa_IXa*X) + ...
            (k18*VIIIa_IXa_X) + (k13*VIIIa_IXa_X) - ...
            - (k20 * VIIIa_IXa);

    diff(8)= (k8*Xa*Va) - (k10*Va_Xa) + (k19*Va_Xa_II) - ...
            (k6*Va_Xa*II) + (k14 * Va_Xa_II);

    diff(9)= k5*Va_Xa*mIIa;

    diff(10)= (k6*Va_Xa*II) - (k19*Va_Xa_II) - (k14*Va_Xa_II);

    diff(11)= (k14*Va_Xa_II) - (k5*Va_Xa*mIIa);

    diff(12)= (k6*TF_VIIa*IX) - (k16*TF_VIIa_IX) - (k11*TF_VIIa_IX);

    diff(13)= (k6*TF_VIIa*X) - (k17*TF_VIIa_X) - (k12*TF_VIIa_X);

    diff(14)= (k6*VIIIa_IXa*X) - (k18*VIIIa_IXa_X) - (k13*VIIIa_IXa_X);

    diff(15)= (k9*VIIIa_IXa) - (k7*VIIIa*IXa) + (k11*TF_VIIa_IX) + ...
                (k15*IX*Xa) + (k15*IX*Va_Xa);

    diff(16)= (k10*Va_Xa) - (k8*Xa*Va) + (k12*TF_VIIa_X) + (k13*VIIIa_IXa_X);
    
    diff(17)= (k10*Va_Xa) - (k8*Xa*Va) + (k1*V*Xa) + (k2*V*IIa) + (k2*V*mIIa);

    diff(18)= (k9*VIIIa_IXa) - (k7*VIIIa*IXa) + (k3*VIII*Xa) + ...
                (k4*VIII*IIa)+(k4*VIII*mIIa);
end
