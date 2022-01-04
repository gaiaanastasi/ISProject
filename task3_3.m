%% Clean
clear
close all
clc
format compact

%% Load dataset

best3 = load("data/best3.mat");

x_train = best3.best3.x_train;
y_train = best3.best3.y_train;
x_test = best3.best3.x_test;
y_test = best3.best3.y_test;
best_features = best3.best3.best_features;
y_values = best3.best3.y_values;

%Retrive the features name from the entire dataset
dataset = load("data/dataset.mat");
%dataset_clean = table2array(dataset);
features_names = dataset.dataset.Properties.VariableNames(5:58);
best3_features_names = features_names(best_features);

x_27= x_train(:,1);
x_11=x_train(:,2);
x_13=x_train(:,3);



%Plot histogram
figure
t = tiledlayout(1,3);
nexttile
histogram(x_27,'BinWidth',0.5, 'BinLimits',[-1 1]);
x_27_name = best3_features_names(:,1);
title(x_27_name);
nexttile
histogram(x_11, 'BinWidth',0.5, 'BinLimits',[-2 2]);
x_11_name = best3_features_names(:,2);
title(x_11_name);
nexttile
histogram(x_13, 'BinWidth',0.5, 'BinLimits',[-1 1]);
x_13_name = best3_features_names(:,3);
title(x_13_name);

max_27 = max(x_27);
max_11 = max(x_11);
max_13 = max(x_13);

min_27 = min(x_27);
min_11 = min(x_11);
min_13 = min(x_13);

fprintf(" --- RANGES FOR UNIVERSE OF DISCOURSE ---\n");
fprintf("  Feature 24 -> Max:%f Min:%f\n", max_27, min_27);
fprintf("  Feature 27 -> Max:%f Min:%f\n", max_11, min_11);
fprintf("  Feature 37 -> Max:%f Min:%f\n", max_13, min_13);


%Index of samples for each output
index1 = find(y_values == 1);
index2 = find(y_values == y_values(1)); %The value 7/3 gave some problems to be recognized
index3 = find(y_values == 11/3);
index4 = find(y_values == 5);
index5 = find(y_values == 19/3);
index6 = find(y_values == 23/3);
index7 = find(y_values == 9);

low = [index1 index2];
middle = [index3 index4 index5];
high = [index6 index7];

% Plot Histogram of features for a specific subset of outputs
binwidth = 0.5;
y_lim = 2;
figure(2)
nexttile

histogram(x_27(low), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('GRS1 low');
nexttile
histogram(x_11(low), 'BinWidth', binwidth, 'BinLimits',[-0.5 0.5]);
yline(y_lim, '--r');
title('ECG28 low');
nexttile
histogram(x_13(low), 'BinWidth', binwidth, 'BinLimits',[-0.5 0.5]);
yline(y_lim, '--r');
title('ECG30 low');
nexttile

histogram(x_27(middle), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('GRS1 medium');
nexttile
histogram(x_11(middle), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('ECG28 medium');
nexttile
histogram(x_13(middle), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('ECG30 medium');

nexttile

histogram(x_27(high), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('GRS1 high');
nexttile
histogram(x_11(high), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('ECG28 high');
nexttile
histogram(x_13(high), 'BinWidth', binwidth, 'BinLimits',[-1 1]);
yline(y_lim, '--r');
title('ECG30 high');

