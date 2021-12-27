clear
close all
clc
format compact

%% Load the dataset
dataset = load('data/dataset.mat');
dataset = table2array(dataset.dataset);

%% Remove infinite values
is_inf = isinf(dataset);
[rows_inf, ~] = find(is_inf == 1);
dataset(rows_inf,:) = [];


%% Removing outliers
% I can ignore the first 2 lines because they don't have significant values
dataset = dataset(:, 3:end);
[initial_rows, ~] = size(dataset);
%I use the default method 'median' in rmoutliers
clean_dataset = rmoutliers(dataset);
[final_rows, ~] = size(clean_dataset);
ret = initial_rows - final_rows;
fprintf("%i outliers removed\n", ret);

%% Data Balancing
arousal_level = dataset(:,1);
valence_level = dataset(:,2);


%getting arousal and valance levels
arousal_level  = clean_dataset(:,1);
valence_level = clean_dataset(:,2);

% samples for arousal and valence
sample_arousal = groupcounts(arousal_level);
sample_valence = groupcounts(valence_level);

% plot the graph
figure("Name", "Sample for arousal before balancing");
bar(sample_arousal);
title("Sample for arousal before balancing");

fprintf("Data are unbalanced\n");

[~, min_arousal] = min(sample_arousal);
[~, max_arousal] = max(sample_arousal);

% plot the graph
%figure("Name", "Sample for valence before balancing");
%bar(sample_valence);
%title("Sample for valence before balancing");

fprintf("Data are unbalanced\n");

[~, min_valence] = min(sample_valence);
[~, max_valence] = max(sample_valence);

augmentation_factors = [0 0];

debug = clean_dataset;
possible_values = [];

possible_values(1) = debug(10,1);
possible_values(2) = debug(1,1);
possible_values(3) = debug(8,1);
possible_values(4) = debug(15,1);
possible_values(5) = debug(7,1);
possible_values(6) = debug(21,1);
possible_values(7) = debug(27,1);

rep = 80;
row_to_check = final_rows;

for k = 1:rep
    for i = 1:row_to_check
        if (clean_dataset(i,1)==possible_values(min_arousal) && clean_dataset(i,2)~=possible_values(max_valence)) || (clean_dataset(i,1)~=possible_values(max_arousal) && clean_dataset(i,2)==possible_values(min_valence))
            %fprintf(" %i) I am going to aumgent the following class valence:%f and arousal:%f\n",i, clean_dataset(i,2), clean_dataset(i,1));
            % Selection of i-th row
            selected_row = clean_dataset(i,:);
            % Augmentation of the i-th row
            row_to_add = selected_row;
            % Selection of the augmentation factor
            augmentation_factors(1) = 0.95+(0.04)*rand;
            augmentation_factors(2) = 1.01+(0.04)*rand;
            j = round(0.51+(1.98)*rand);
            % Augmentation
            row_to_add(3:end) = selected_row(3:end).*augmentation_factors(j); 
            % Addition of the new sample, obtained through augmentation, to
            % the dataset
            clean_dataset = [clean_dataset; row_to_add];
        end
        
        if((clean_dataset(i,1)==possible_values(max_arousal) && clean_dataset(i,2)~=possible_values(min_valence)) || (clean_dataset(i,2)==possible_values(max_valence) && clean_dataset(i,1)~=possible_values(min_arousal)))
            clean_dataset(i,:)=[];
            %fprintf(" I am removing the row %i\n",i);
        end
    end
    samples_arousal = groupcounts(clean_dataset(:,1));
    samples_valence = groupcounts(clean_dataset(:,2));

    [~, min_arousal] = min(samples_arousal);
    [~, max_arousal] = max(samples_arousal);

    [~, min_valence] = min(samples_valence);
    [~, max_valence] = max(samples_valence);
end
fprintf(" Balancing ended\n");

samples_arousal = groupcounts(clean_dataset(:,1));
samples_valence = groupcounts(clean_dataset(:,2));
figure("Name", "Samples for arousal after balancing");
bar(samples_arousal);
title("Samples for arousal after balancing");
fprintf("Arousal data balanced\n");
figure("Name", "Samples for valence after balancing");
bar(samples_valence);
title("Samples for valence after balancing");
fprintf("Valence data balanced\n");


%% Save balanced dataset
    save('data/clean_dataset.mat','clean_dataset');