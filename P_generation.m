%% Setting paths
addpath(genpath(pwd));
%% Full model: Hom, small-size, long time

param1.ne       = 75;
param1.ni       = 25;
param1.p_ee     = 0.15;
param1.p_ie     = 0.5;
param1.p_ei     = 0.5;
param1.p_ii     = 0.4;
param1.s_ee     = 25;
param1.s_ie     = 10;
param1.s_ei     = 25;
param1.s_ii     = 25;
param1.M        = 100;
param1.Mr       = 66;
param1.lambda_e = 1/7;
param1.lambda_i = 1/7;
param1.tau_ee   = 4;
param1.tau_ie   = 1.2;
param1.tau_i    = 4.5;
param1.gate      = 70;
duration_time   = 10000;
param1.type      ='hom';
param1.fix = false;
param1.time_delta = 1;

param1.rare_range_e=3;           %range definition of rare events of e neurons
param1.rare_range_i=1;           %range definition of rare events of i neurons
param1.simulation_times=2000;     %times of rare events simulation
param1.simulation_duration=1;    %duration of each simulation

name1 = 'n=100-t=1000-hom-noref';
param1.method   = 'extend';
save=false;

% random inilialization
s = zeros(4,param1.ne+param1.ni);
s(2:3,:) = double(rand(2,param1.ne+param1.ni)>0.8);
s(1,:) = unidrnd(param1.M+param1.Mr+1,[1,param1.ne+param1.ni])- param1.Mr-1;
%% noref
param1.tau_r    = 0;
% t=clock;
% res1 = model_full(s, duration_time, param1);
% runtime1 = etime(clock,t);
rare_res1=rare_model_full(res1,param1);
%% ref
param1.tau_r    = 2.5;
% t=clock;
% res1_ref = model_full(s, duration_time, param1);
% runtime1 = etime(clock,t);
rare_res1_ref=rare_model_full(res1_ref,param1);

%% Full model: Reg, small-size, noref, long time
param2.ne       = 75;
param2.ni       = 25;
param2.p_ee     = 0.15;
param2.p_ie     = 0.5;
param2.p_ei     = 0.5;
param2.p_ii     = 0.4;
param2.s_ee     = 25;
param2.s_ie     = 10;
param2.s_ei     = 25;
param2.s_ii     = 25;
param2.M        = 100;
param2.Mr       = 66;
param2.lambda_e = 1/7;
param2.lambda_i = 1/7;
param2.tau_ee   = 2;
param2.tau_ie   = 1.2;
param2.tau_i    = 4.5;
param2.gate      = 70;
param2.time_delta = 1;
duration_time   = 10000;

param2.rare_range_e=3;           %range definition of rare events of e neurons
param2.rare_range_i=1;           %range definition of rare events of i neurons
param2.simulation_times=2000;     %times of rare events simulation
param2.simulation_duration=1;    %duration of each simulation

name2 = 'n=100-t=1000-reg-noref';
save=false;
param2.type    ='reg';
param2.fix     = false;


s = zeros(4,param2.ne+param2.ni);
s(2:3,:) = double(rand(2,param2.ne+param2.ni)>0.8);
s(1,:) = unidrnd(param2.M+param2.Mr+1,[1,param2.ne+param2.ni])- param2.Mr-1;


%% noref
param2.tau_r    = 0;
% t = clock;
% res2 = model_full(s, duration_time, param2);
% runtime2 = etime(clock, t);
rare_res2=rare_model_full(res2,param2);
%% ref
param2.tau_r    = 2.5;
t = clock;
res2_ref = model_full(s, duration_time, param2);
runtime2 = etime(clock, t);
rare_res2_ref=rare_model_full(res2_ref,param2);

%% Full model: syn, small-size, noref, long time
param3.ne       = 75;
param3.ni       = 25;
param3.p_ee     = 0.15;
param3.p_ie     = 0.5;
param3.p_ei     = 0.5;
param3.p_ii     = 0.4;
param3.s_ee     = 25;
param3.s_ie     = 10;
param3.s_ei     = 25;
param3.s_ii     = 25;
param3.M        = 100;
param3.Mr       = 66;
param3.lambda_e = 1/7;
param3.lambda_i = 1/7;
param3.tau_ee   = 1.3;
param3.tau_ie   = 0.95;
param3.tau_i    = 4.5;
param3.gate     = 70;
duration_time   = 40000;
param3.time_delta = 1;

param3.rare_range_e=3;           %range definition of rare events of e neurons
param3.rare_range_i=1;           %range definition of rare events of i neurons
param3.simulation_times=7000;     %times of rare events simulation
param3.simulation_duration=1;    %duration of each simulation

param3.fix = false;
name3 = 'n=100-t=1000-syn-noref';
save=false;
param3.type     = 'syn';
param3.method   = 'extend';

%random inilialization
s = zeros(4,param3.ne+param3.ni);
% s(2:3,:) = double(rand(2,param3.ne+param3.ni)>0.8);
s(1,:) = unidrnd(param3.M+param3.Mr+1,[1,param3.ne+param3.ni])- param3.Mr-1;

%% noref

param3.tau_r    = 0;
t = clock;
res3 = model_full(s, duration_time, param3);
runtime3 = etime(clock,t);
rare_res3=rare_model_full(res3,param3);
%% ref

param3.tau_r    = 2.5;
% t = clock;
res3_ref = model_full(s, duration_time, param3);
% runtime3 = etime(clock,t);
rare_res3_ref=rare_model_full(res3_ref,param3);

%% Calculate the P
bar.e = 60;
bar.i = 60;
% Statistical method
% P1_stat = P_generation_statistics(res1, rare_res1, param1, bar);
% P1_stat_ref = P_generation_statistics(res1_ref, rare_res1_ref, param1, bar);
% 
% P2_stat = P_generation_statistics(res2, rare_res2, param2, bar);
% P2_stat_ref = P_generation_statistics(res2_ref, rare_res2_ref, param2, bar);

P3_stat = P_generation_statistics(res3, rare_res3, param3, bar);
P3_stat_ref = P_generation_statistics(res3_ref, rare_res3_ref, param3, bar);


















