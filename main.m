%% Setting paths
addpath(genpath(pwd));

%% Full model: Homogeneous
param1.ne       = 300;
param1.ni       = 100;
param1.p_ee     = 0.15;
param1.p_ie     = 0.5;
param1.p_ei     = 0.5;
param1.p_ii     = 0.4;
param1.s_ee     = 5;
param1.s_ie     = 2;
param1.s_ei     = 4.91;
param1.s_ii     = 4.91;
param1.tau_r    = 2.5;
param1.M        = 100;
param1.Mr       = 66;
param1.lambda_e = 1/7;
param1.lambda_i = 1/7; 
%7000 spikes/sec means time constant is 1/7 ms.
param1.tau_ee   = 4; 
param1.tau_ie   = 1.2; 
param1.tau_i    = 4.5;

iter            = 1500000;
s               = false;

spikes1 = model_full(s, iter, param1);

%scatter plot
maxrow=max(spikes1(1,:));
for i=1:300
scatter(spikes1(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes1(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

%% Full model: Regular
param2.ne       = 300;
param2.ni       = 100;
param2.p_ee     = 0.15;
param2.p_ie     = 0.5;
param2.p_ei     = 0.5;
param2.p_ii     = 0.4;
param2.s_ee     = 5;
param2.s_ie     = 2;
param2.s_ei     = 4.91;
param2.s_ii     = 4.91;
param2.tau_r    = 2.5;
param2.M        = 100;
param2.Mr       = 66;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7; 
%7000 spikes/sec means time constant is 1/7 ms.
param2.tau_ee   = 2; 
param2.tau_ie   = 1.2; 
param2.tau_i    = 4.5;

iter            = 1500000;
%About 300 ms
s               = false;

spikes2 = model_full(s, iter, param2);

%scatter plot
maxrow=max(spikes2(1,:));
for i=1:300
scatter(spikes2(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes2(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end

%% Full model: Sychronized
param3.ne       = 300;
param3.ni       = 100;
param3.p_ee     = 0.15;
param3.p_ie     = 0.5;
param3.p_ei     = 0.5;
param3.p_ii     = 0.4;
param3.s_ee     = 5;
param3.s_ie     = 2;
param3.s_ei     = 4.91;
param3.s_ii     = 4.91;
param3.tau_r    = 2.5;
param3.M        = 100;
param3.Mr       = 66;
param3.lambda_e = 1/7;
param3.lambda_i = 1/7; 
%7000 spikes/sec means time constant is 1/7 ms.
param3.tau_ee   = 1.3; 
param3.tau_ie   = 0.95; 
param3.tau_i    = 4.5;

iter            = 1500000;
s               = false;

spikes3 = model_full(s, iter, param3);

%scatter plot
maxrow=max(spikes3(1,:));
for i=1:300
scatter(spikes3(2:maxrow+1,i), i*ones(1,maxrow),'.','r');
hold on
end
for i=301:400
scatter(spikes3(2:maxrow+1,i), i*ones(1,maxrow),'.','b');
hold on
end
