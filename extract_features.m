%% Clean
clear
close all
clc
format compact

%% Load the dataset
dataset = load('data/clean_dataset.mat');
clean_dataset = dataset.clean_dataset';

%% Extracting features
