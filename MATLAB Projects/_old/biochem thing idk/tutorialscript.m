%This is a script that will define input values, and use an ODE solver
%to simulate reactions defined in 'example.m'
%You can use this interactively: highlight the code you want to run, right
%click on it, and select "Evaluate selection"

%Encode rates as k = [k1 k2 k3]
k = [1e7 0.004 20]; %These are in s^-1 for 1st order, M^-1 s^-1 for second order

%Encode initial values
%In this example, n = [Substrate Enzyme Complex Product], but you can use
%encoding any starting amounts in this way as long as you keep track of
%the order for other calculations.
n = [1e-6 1e-9 0 0]; %These are in M (molar) concentrations.

%Encode time frame as [start end].
%This will correspond to seconds, because seconds are used in rates (k)
time = [0 500];

%The following line is necessary for MATLAB to work with smaller numbers
opts = odeset('RelTol',1e-12,'AbsTol',1e-12); %This is REQUIRED for simulation


%ODE solver. Here we use ode23s.
%For the project, you will replace tutorialfunction(t,y,k) with
%coagulation(t,y,k). 
[t2, y2] = ode23s(@(t,y) tutorialfunction(t,y,k), time, n, opts); %Simulation

%t2 and y2 are the outputs. 
%t2 is a 1D array of the specific timepoint sampled.
%y2 is a 2D array, with initial values becoming the first row.
%Each time step adds a new row. 
%In this case, column 1 will be Substrate, column 2 will be Enzyme, etc.

%Call the substrates with the following command:
y2(:,1) % NOTE: Here, regular parentheses are required.

%Call the Enzyme concentration with the following command:
y2(:,2)

%Plot the results
f1 = figure;
plot(t2, y2); %This plots all four columns
legend("Substrate","Enzyme","Complex","Product"); %Legend
xlabel("time, s");
ylabel("Concentrations, M");
saveas(f1,"figure1-tutorial.png");


%Create a new figure to just show two lines
f2 = figure;
plot(t2, y2(:,2)) %selecting the second column, which is Enzyme
hold on %A "hold on" command lets you add more data to a single plot
    %Defining a new figure object resets the hold
plot(t2, y2(:,3)) %selecting thte third column, which is Complex
legend("Enzyme","Complex"); %Legend
xlabel("time, s");
ylabel("Concentrations");
saveas(f2,"figure2-tutorial.png");

%Now we can alter the parameters, and see how it affects aspects of the
%model. First we will run a narrow time scale and see early events of the
%complex formation
time = [0 0.5];
%We create new output variables t3 and y3 to prevent overwriting the
%results of the first simulation
[t3, y3] = ode23s(@(t,y) tutorialfunction(t,y,k), time, n, opts); %Simulation
f3 = figure;
hold on;
plot(t3, y3(:,2)) %selecting the second column, which is Enzyme
plot(t3, y3(:,3)) %selecting thte third column, which is Complex
legend("Enzyme","Complex"); %Legend
xlabel("time, s");
ylabel("Concentrations");
saveas(f3,"figure3-tutorial.png");

%Next we will reset to a longer time window, but alter reduce value of k3
%to 0.5 s-1. We will plot all four species again.
time = [0 500];
k(3) = 0.5; %This changes only the third value in the k array to 0.5
[t4, y4] = ode23s(@(t,y) tutorialfunction(t,y,k), time, n, opts); %Simulation
f4 = figure;
plot(t4, y4); %This plots all four columns
legend("Substrate","Enzyme","Complex","Product"); %Legend
xlabel("time, s");
ylabel("Concentrations, M");
saveas(f4,"figure4-tutorial.png");

%This slows down the accumulation of product by quite a lot. Let's look at a
%longer time window.
time = [0 5000];
[t5, y5] = ode23s(@(t,y) tutorialfunction(t,y,k), time, n, opts); %Simulation
f5 = figure;
plot(t5, y5); %This plots all four columns
legend("Substrate","Enzyme","Complex","Product"); %Legend
xlabel("time, s");
ylabel("Concentrations, M");
saveas(f5,"figure5-tutorial.png");

%Finally, lets compare product accumulation rate of the original reaction
%with the slowed reaction on the same plot. We will need to create a new
%set of outputs.
k(3) = 20; %Reset k3 back to original value
[t6, y6] = ode23s(@(t,y) tutorialfunction(t,y,k), time, n, opts); 
%Note the new variable names for the output. The names themselves are
%arbitrary, as long as they are distinct. We will use the hold command to
%make the plot
f6 = figure;
plot(t5, y5(:,4)) %This is the k3 = 0.5 simulation
hold on %A "hold on" command lets you add more data to a single plot
plot(t6, y6(:,4)) %This is the k3=20 simulation
legend("Product: k3 = 0.5","Product: k3=20"); %Legend
xlabel("time, s");
ylabel("Concentrations");
hold off
saveas(f6,"figure6-tutorial.png");
