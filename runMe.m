% Last modified: December 11, 2019

% CLASSIFICATION PROBLEM: can we classify users as artists or non artists?

% feats: id, team, shapeJSON, annotation, black, pink, green, red, changes
% index: 1    2      3            4         5      6     7     8      9

%%%%%%%%%%%%%%%%%%%%% FEATURE EXTRACTION & ENGINEERING %%%%%%%%%%%%%%%%%%%%

% Load feature data
if isfile('featureData.mat') % use existing data (for testing)
    featureData = load('featureData');
    features = featureData.features;
else % generate data
    features = extractFeatures();
end

% Isolate predictor variables
black = features.black;
pink = features.pink;
green = features.green;
red = features.red;
changes = features.changes;
predictors = [black pink green red changes];

%%%%%%%%%%%%%%%%%%%%%%%%%% BUILD AND TEST MODELS %%%%%%%%%%%%%%%%%%%%%%%%%%

% Function parameters
k = 4; % change to multiple different values for testing
opts = statset('Display','final');
reps = 10; % rerun clustering with different random initial centroids
maxIters = 100;
numSamples = 49; % may need to be adjusted depending on k (memory issues)

disp('Building k-means clustering model. Please hold, this will take a while...')
modelInfo = 'Parameters: k = ' + string(k) + ', repetitions = ' + ...
            string(reps) + ', samples = ' + string(numSamples) + ...
            ', max iterations: ' + maxIters + newline;
disp(modelInfo)
set(0,'DefaultFigureVisible','off'); % prevent figures from popping up

% Run clustering algorithm with specified parameters

% Get clustering indices and rows corresponding to clustering indices
[idx,centroids] = kmeans(predictors,k,'Replicates',reps,'Options',opts,'MaxIter',maxIters);
numClusters = size(unique(idx),1);

% Get indices and a sample of annotations for each cluster
for i=1:numClusters
    cNum = string(i);
    clustName = 'k' + string(k) + '-cluster' + cNum;
    cmsg = 'Current cluster: ' + clustName;
    disp(cmsg)

    % Get indices for the ith cluster and randomize them, get subset
    indices = find(idx == i);
    numRows = size(indices,1);
    randIdx = randperm(numRows);
    rows = randIdx(1:numSamples);
    samples = features(rows,:);

    % Save the subset of cluster annotations
    files = {};
    for j=1:size(samples)
        % Get the JSON/structure data for the current annotation
        current = samples(j,:);
        shape = strcat('JSON/',current.shapeJSON);
        struct = readJSON(shape);
        name = clustName + '-' + string(j);

        % Save annotation as individual PNG file, add filename to list
        fig = figure('Name',name);
        displayShape(struct, current.annotation);
        filename = 'images/' + name + '.png';
        saveas(fig,filename);
        files{j} = filename;
    end

    % Create montage of annotations for this cluster
    cluster = montage(files);
    clusterName = 'clusters/' + clustName + '.png';
    saveas(cluster,clusterName);
end

disp('Centroid locations:')
disp(centroids)
disp('You made it to the end of the script! Yay!')
