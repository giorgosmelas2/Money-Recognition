%Εργασια για τα ασαφοι συστηματα

data = load('data_banknote_authentication.txt');

%Τυχαιο ανακατεματων δεδομενων γιατι ηταν χωρισμενα σε πλαστα και γνησια
shuffled_data = data(randperm(size(data, 1)), :);
disp(shuffled_data);

%Διαχωρισμος των δεδομενων σε train και test data
n = size(data, 1);
split_idx = round(0.7 * n);

train_data = shuffled_data(1:split_idx, :);
test_data = shuffled_data(split_idx+1:end, :);

%Clustering με Fuzzy C-Means
n_clusters = 2;

[centers, U] = fcm(train_data, n_clusters);
disp(U);
%disp('Κεντρα των clusters: ');
%disp(centers);

[~, cluster_membership] = max(U);
disp(cluster_membership)

%disp('Κατηγοριοποιηση των δεδομενων');
%disp(cluster_membership);

cluster_1 = [];
cluster_2 = [];
%{
for i=1:length(train_data)
  if  cluster_membership(i) == 1
    cluster_1 = [cluster_1; shuffled_data(i, :)];
  else
    cluster_2 = [cluster_2; shuffled_data(i, :)];
  endif

endfor

disp('Cluster 1');
disp(cluster_1);
disp('Cluster 2')
disp(cluster_2);
%}




