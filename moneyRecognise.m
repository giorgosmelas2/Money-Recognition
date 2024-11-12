data = readtable('data_banknote_authentication.txt');

%Suffling data
randomOrder = randperm(size(data, 1));
suffledData = data(randomOrder, :);

%Divade data to train and test data
n = ceil(size(data, 1)*0.7);

train_data = table2array(suffledData(1:n, 1:end-1));
train_results = table2array(suffledData(1:n, end));

test_data = table2array(suffledData(n+1:end, 1:end-1));
test_results = table2array(suffledData(n+1:end, end));

%Training model
fis = genfis3(train_data, train_results, 'sugeno', 3);
options = anfisOptions('InitialFIS', fis, ...
                       'EpochNumber', 500, ...
                       'DisplayANFISInformation', true, ...
                       'DisplayErrorValues', true, ...
                       'DisplayStepSize', true, ...
                       'DisplayFinalResults', true);
                   
trainingDataWithLabels = [train_data, train_results];
[trainedFIS, trainingError] = anfis(trainingDataWithLabels, options);

for i = 1:length(trainedFIS.input)
    figure;
    plotmf(trainedFIS, 'input', i);
    title(['Participant functions for input', num2str(i)])
end

%Rate the output
output = evalfis(test_data, trainedFIS);
predictedLabels = round(output);
accuracy = sum(predictedLabels == test_results) / length(test_results);
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
