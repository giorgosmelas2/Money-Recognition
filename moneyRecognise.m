data = readtable('data_banknote_authentication.txt');
%disp(data);

numRows = size(data, 1);
randomOrder = randperm(numRows);

suffledData = data(randomOrder, :);

n = ceil(size(data, 1)*0.7);

train_data = table2array(suffledData(1:n, 1:end-1));
train_results = table2array(suffledData(1:n, end));

test_data = table2array(suffledData(n+1:end, 1:end-1));
test_results = table2array(suffledData(n+1:end, end));

fis = genfis3(train_data, train_results, 'sugeno', 3);
options = anfisOptions('InitialFIS', fis, ...
                       'EpochNumber', 500, ...
                       'DisplayANFISInformation', true, ...
                       'DisplayErrorValues', true, ...
                       'DisplayStepSize', true, ...
                       'DisplayFinalResults', true);
[trainedFIS, trainingError] = anfis(train_data, options);

output = evalfis(test_data, fis);

predictedLabels = round(output);
accuracy = sum(predictedLabels == test_results / length(test_results));
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
