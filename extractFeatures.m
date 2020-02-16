function [features] = extractFeatures()
% Features: id, team, shapeJSON, annotation, black, pink, green, red, changes
% Indices:   1    2      3            4         5      6     7     8      9

    % Load dataset with specific options
    data = load('dataset');
    opts = detectImportOptions('annotationTable.csv');
    opts.VariableNames = {'id','team','shapeJSON','annotation'};
    opts.VariableTypes = {'double','string','string','string'};
    opts.SelectedVariableNames = {'id','team','shapeJSON','annotation'};
    opts.ExtraColumnsRule = 'ignore';
    existing = readtable('annotationTable.csv', opts);
    existing.annotation = data.annotations; % use string annotations
    numAnnotations = size(existing,1);

    % Initialize table for holding new feature data
    colorCols = {'black','pink','green','red','changes'};
    colors = table(rand(1,1),rand(1,1),rand(1,1),rand(1,1),rand(1,1),...
        'VariableNames',colorCols);
    
    disp('Extracting features now...')
    
    % Extract color data from annotations
    prevNum = 4; % initalize with random value as there is no prev num yet
    for i=1:numAnnotations
        % Get current annotation, its length (# of triangles), and change var
        current = existing.annotation(i);
        annoLen = strlength(current); % changes based on shape variant
        numTriangles = size(current,2);
        numChange = 0; % number of color changes in a row (i.e. 1->2)

        % Check for change in color, excluding first iteration
        for j = 1:annoLen 
            currentNum = current{1}(j);
            if currentNum ~= prevNum && j ~= 1
                numChange = numChange + 1;
            end
            prevNum = currentNum;
        end

        % Get percentages of each color and percent change
        percentB = count(current,'0')/numTriangles/100;
        percentP = count(current,'1')/numTriangles/100;
        percentG = count(current,'2')/numTriangles/100;
        percentR = count(current,'3')/numTriangles/100;
        percentChange = numChange/size(current,1)/100;

        % Append new row to colors table
        newRow = table(percentB,percentP,percentG,percentR,percentChange,...
            'VariableNames',colorCols);
        newColors = [colors;newRow];
        colors = newColors;
    end

    % Clean up colors data, combine w/ existing to form final feature table
    colors(1,:) = []; % remove first row of random data
    features = [existing colors];
    save('featureData.mat','features'); % for testing later
    disp('Data has been preprocessed!')
    disp(newline)
end
