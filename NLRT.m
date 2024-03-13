clc;clear;close all;

fullpath = mfilename('fullpath');
[curpath, ~] = fileparts(fullpath);
cd(curpath);

%% tools loading
addpath(genpath('./tools'));
addpath(genpath('./utils'));
addpath(genpath('./funs'));

%% data loading
fprintf("loading data...\n");
dataload_path = "./datasets/CAVE/Face.mat";
maskload_path = "./datasets/mask_for_512.mat";

fprintf("Data loading...\n");

load(dataload_path, 'orig');   % 读入函数orig, mask
load(maskload_path, 'mask');   % 读入函数orig, mask

[nrows, ncols, dims] = size(orig);

mask = repmat(mask,1,1,dims);

%% 参数设置
step = 2;   % 色散步长
rho = 5e-6;
beta = 1e-3;
rank = 9;
gamma = 1e-3;
omega = 1e-5;   

winsize = 10;   % clustering
overlap = 5;

niters = 300;   % NLRT算法

%% coding and compressing
P = @(x) shift(x, step);
PT = @(x) shift_back(x, step);

shifted_orig = P(orig);
shifted_mask = P(mask);

A = @(x) (sum(x.*shifted_mask, 3));      
AT = @(x) (bsxfun(@times, x, shifted_mask));  

[rows, cols, dims] = size(orig); 
[srows, scols, ~] = size(shifted_orig); 

meas = A(P(orig));

%% NLRT
fprintf("Start...\n");
if isempty(gcp('nocreate')) % enable parallel
    p = parpool(24);
end

mytimestart = tic;

%% V.A. Measurement Image Restoration
fprintf("Step 1. Measurement image restorating...\n");

step1_time = tic;

S = zeros(srows,scols,dims);    % initial
T = zeros(rows,cols,dims);
E = S;

initial_image = ADMM_for_Smooth(meas,omega,rho,A,AT,P,PT,shifted_mask,...
                'initializer', {S,T,E},...
                'ADMM_iter',   10,...
                'TV_iter',     10);

% initial_image = mean(orig,3);
step1_time = toc(step1_time);
fprintf("step1_time:%f s\n", step1_time);

%% V.B. Nonlocal HSI Blocks Clustering
fprintf("Step 2.  Nonlocal HSI blocks clustering...\n");

step2_time = tic;

[mn_cell, bparams] = Clustering(initial_image, rows, cols,...
                'winsize',     10,...
                'overlap',     5,...
                'searchsz',    [7,7]);

step2_time = toc(step2_time);
fprintf("step2_time:%f s\n", step2_time);

%% V.C. Optimization Procedure
fprintf("Step 3. NLRT iter...\n");

step3_time = tic;

Y = meas;   % initial
X = zeros(rows,cols,dims);
V = zeros(srows,scols,dims);
M = zeros(srows,scols,dims);

[X, V, metric] = ADMM_for_NLRT(Y,gamma,mn_cell,bparams,A,AT,P,PT,shifted_mask, ...
                'initializer', {X,V,M},...
                'display',     true,...
                'orig',        orig,...
                'rank',        rank,...
                'niters',      niters);

step3_time = toc(step3_time);  % 计时
fprintf("step3_time:%f\n", step3_time);

tmymethod = toc(mytimestart);
t_part_mymethod = [step1_time, step2_time, step3_time];
fprintf('%s---NLRT_time:%fs\n', dataload_path, tmymethod);

%% Save results
save("./results/CAVE_results/Face_Xresult.mat", 'orig', 'shifted_mask', 'meas', 'X', 'V', 'tmymethod', 't_part_mymethod', 'metric');