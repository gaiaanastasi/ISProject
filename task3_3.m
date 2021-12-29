%% Clean
clear
close all
clc
format compact

%% Load dataset

best3 = load("data/best3.mat");

x_train = best3.best3.x_train;
y_train = best3.best3.y_train.';
x_test = best3.best3.x_test;
y_test = best3.best3.y_test.';
best_features = best3.best3.best_features;
y_values = best3.best3.y_values;

%Retrive the features name from the entire dataset
dataset = load("data\dataset.mat");
%dataset_clean = table2array(dataset);
features_names = dataset.dataset.Properties.VariableNames(5:58);
best3_features_names = features_names(best_features);
%{
fuzzyData = load("fuzzyData.mat");
x_train = fuzzyData.fuzzyData.x_train_arousal;
y_train = fuzzyData.fuzzyData.y_train_arousal;
x_test = fuzzyData.fuzzyData.x_test_arousal;
y_test = fuzzyData.fuzzyData.y_test_arousal;
best_features = fuzzyData.fuzzyData.best_features;
y_values = fuzzyData.fuzzyData.y_values;
%}
x_13= x_train(:,1);
x_27=x_train(:,2);
x_12=x_train(:,3);


%Plot histogram
figure
t = tiledlayout(1,3);
nexttile
histogram(x_13,'BinWidth',0.5, 'BinLimits',[-1 1]);
title('Histogram of ECG 18');
nexttile
histogram(x_27, 'BinWidth',0.1, 'BinLimits',[-0.5 0.5]);
title('Histogram of EEC 10');
nexttile
histogram(x_12, 'BinWidth',0.005, 'BinLimits',[0 0.1]);
title('Histogram of GSR 1');


%Index of samples for each output
index1 = find(y_values == 1);
index2 = find(y_values == y_values(2)); %The value 7/3 gave some problems to be recognized
index3 = find(y_values == 11/3);
index4 = find(y_values == 5);
index5 = find(y_values == 19/3);
index6 = find(y_values == 23/3);
index7 = find(y_values == 9);

% Plot Histogram of features for a specific subset of outputs
