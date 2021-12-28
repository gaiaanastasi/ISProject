%% Clean
clear
close all
clc
format compact

%% Load the features

%{
test_arousal = load('test_data_arousal.mat');
train_arousal = load('training_data_arousal.mat');

x_train_arousal = train_arousal.training_data_arousal.x_train_arousal';
y_train_arousal = train_arousal.training_data_arousal.y_train_arousal';
x_test_arousal = test_arousal.test_data_arousal.x_test_arousal';
y_test_arousal = test_arousal.test_data_arousal.y_test_arousal';
%}
test_arousal = load('data/testing_arousal.mat');
train_arousal = load('data/training_arousal.mat');
x_train_arousal = train_arousal.best_arousal_training.x_train';
y_train_arousal = train_arousal.best_arousal_training.y_train'.';
x_test_arousal = test_arousal.best_arousal_testing.x_test';
y_test_arousal = test_arousal.best_arousal_testing.y_test'.';

fprintf("Arousal features loaded\n");
%{

test_valence = load('data/testing_valence.mat');
train_valence = load('data/training_valence.mat');
x_train_valence = train_valence.best_valance_training.x_train';
y_train_valence = train_valence.best_valance_training.y_train';
x_test_valence = test_valence.best_valance_testing.x_test';
y_test_valence = test_valence.best_valance_testing.y_test';

fprintf("Valence features loaded\n");
%}
%% MLP for Arousal
hiddenLayerSize_arousal = 30;
mlp_arousal = fitnet(hiddenLayerSize_arousal);
mlp_arousal.divideParam.trainRatio = 0.7;
mlp_arousal.divideParam.testRatio = 0.1;
mlp_arousal.divideParam.valRatio = 0.2;
mlp_arousal.trainParam.showCommandLine=1;
mlp_arousal.trainParam.showWindow=0;
mlp_arousal.trainParam.epochs =110;

[mlp_arousal, tr] = train(mlp_arousal, x_train_arousal, y_train_arousal);
view(mlp_arousal);
figure(1);
plotperform(tr);

% Test
test_output_arousal = mlp_arousal(x_test_arousal);

% Plot regression
figure(2)
plotregression(y_test_arousal, test_output_arousal, " Arousal ");
figure(3)
ploterrhist(y_test_arousal - test_output_arousal, 'bins', 7 );

