clear all;
clc

%Load Data Sets
Triangle;
OneSpiral;
TwoSpirals;

% load NewsGroup.mat; % Load Data Set
global D P IW distances Winners neuronsPerRow neuronsPerColumn N dimensions positions;

%DataPatterns = Patterns ;
%DataPatterns = full(tfidf(DataPatterns));
%DataPatterns = DataPatterns.' ;

Data = [TrianglePatterns; OneSpiralPatterns; TwoSpiralsData;];

for i=5:2:5
        
DataPatterns = [Data(i,:); Data((i+1),:)];

D = size(DataPatterns,1);
P = size(DataPatterns,2);
%Create minMax matrix from values of all patterns
for ii=1:D
    minMax(ii,1) = min(DataPatterns(ii,:)); 
    minMax(ii,2) = max(DataPatterns(ii,:)); 
end


%Specify SOM characteristics
if (i == 1)
    gridSize = [20 20];
    Winners = zeros(400,1); %Initialization of Winners matrix
elseif (i == 3)
    gridSize = [200 1];
    Winners = zeros(200,1); %Initialization of Winners matrix
else
    gridSize = [350 1];
    Winners = zeros(350,1); %Initialization of Winners matrix
end


%Create SOM
neuronsPerRow = gridSize(1,1);
neuronsPerColumn = gridSize(1,2);
N = neuronsPerRow*neuronsPerColumn;

minFeatureValues = minMax(:,1)';
maxFeatureValues = minMax(:,2)';
dimensions = size(minMax,1);

IW = zeros(N,dimensions);

for ii = 1:N,
    IW(ii,:) = rand(1,dimensions).*(maxFeatureValues-minFeatureValues)+minFeatureValues;
end

if (i == 1)
    f = 400;
elseif (i == 3)
    f = 200;
else
    f = 350;
end

position = [hexagonalTopology(neuronsPerRow,neuronsPerColumn); gridtop(neuronsPerRow,neuronsPerColumn); hextop(neuronsPerRow,neuronsPerColumn); randtop(neuronsPerRow,neuronsPerColumn)];

for k=1:2:7
    positions = position(k:(k+1),:);
    if (k == 1)
        fprintf('hexagonal:\n');
    elseif (k == 3)
            fprintf('grid:\n');
    elseif (k == 5)
            fprintf('hex:\n');
    else
            fprintf('rand:\n');
    end
    distance = [boxdist(positions); dist(positions); linkdist(positions); mandist(positions)];
    for j=0:f:(4*f-1)
        distances = distance(j+1:j+f,:);
    if (j == 0)
        fprintf('boxdist\n\n');
    elseif (j == f)
            fprintf('dist\n\n');
    elseif (j == 2*f)
            fprintf('linkdist\n\n');
    else
            fprintf('mandist\n\n');
    end
        
        %Show original SOM
        % figure;
        % plot2DSomData(IW,distances,DataPatterns);

        %Set TrainParameters
        orderLR = 0.9; 
        orderEpochs = 200;
        tuneLR = 0.1; 
        somTrainParameters(orderLR,orderEpochs,tuneLR);

        %Train SOM
        somTrain(DataPatterns);

        %Show final SOM
        figure; 
        plot2DSomData(IW,distances,DataPatterns);

%         figure;
%         somShow(IW,gridSize);
    end
end
end