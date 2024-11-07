function labels = dbscan_octave(data, epsilon, minPts)
  n = size(data, 1);          % Αριθμός σημείων
  labels = zeros(n, 1);       % Αρχικοποίηση των labels
  cluster_id = 0;             % ID των clusters

  for i = 1:n
    if labels(i) ~= 0
      continue;
    endif

    % Βρες τα γειτονικά σημεία
    neighbors = regionQuery(data, i, epsilon);

    % Αν το πλήθος των γειτόνων είναι μικρότερο από το minPts, σήμανε ως θόρυβο
    if numel(neighbors) < minPts
      labels(i) = -1;
    else
      cluster_id = cluster_id + 1;
      growCluster(data, labels, i, neighbors, cluster_id, epsilon, minPts);
    endif
  endfor
endfunction

function growCluster(data, labels, point_id, neighbors, cluster_id, epsilon, minPts)
  labels(point_id) = cluster_id;
  i = 1;

  while i <= numel(neighbors)
    neighbor_id = neighbors(i);

    if labels(neighbor_id) == -1
      labels(neighbor_id) = cluster_id;
    endif

    if labels(neighbor_id) == 0
      labels(neighbor_id) = cluster_id;
      new_neighbors = regionQuery(data, neighbor_id, epsilon);

      if numel(new_neighbors) >= minPts
        neighbors = [neighbors; new_neighbors];
      endif
    endif
    i = i + 1;
  endwhile
endfunction

function neighbors = regionQuery(data, point_id, epsilon)
  distances = sqrt(sum((data - data(point_id, :)) .^ 2, 2));
  neighbors = find(distances <= epsilon);
endfunction

