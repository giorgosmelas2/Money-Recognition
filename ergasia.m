%Εργασια για τα ασαφοι συστηματα

data = load('data_banknote_authentication.txt');

%Τυχαιο ανακατεματων δεδομενων γιατι ηταν χωρισμενα σε πλαστα και γνησια
shuffled_data = data(randperm(size(data, 1)), :);

%Διαχωρισμος των δεδομενων σε train και test data
n = size(data, 1);
split_idx = round(0.7 * n);

train_data = shuffled_data(1:split_idx, :);
test_data = shuffled_data(split_idx+1:end, :);

%Κανονικοποιηση των δεδομενων
data = (data - mean(data)) ./ std(data);

%Παραμετροι
eps= 0.9; %Ακτινα γειτονιας
minPts = 30; %Ελαχιστος αριθμος σημειων σε μια γειτονια για να σχηματιστει ενα cluster

[cluster_labels] = dbscan_octave(data, eps, minPts);

disp(cluster_labels);

