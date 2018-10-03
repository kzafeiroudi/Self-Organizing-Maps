function somCreate(minMax,gridSize)

global neuronsPerRow neuronsPerColumn N IW distances dimensions positions;

neuronsPerRow = gridSize(1,1);
neuronsPerColumn = gridSize(1,2);
N = neuronsPerRow*neuronsPerColumn;

minFeatureValues = minMax(:,1)';
maxFeatureValues = minMax(:,2)';
dimensions = size(minMax,1);

IW = zeros(N,dimensions);

for i = 1:N,
    IW(i,:) = rand(1,dimensions).*(maxFeatureValues-minFeatureValues)+minFeatureValues;
end

% positions = hexagonalTopology(neuronsPerRow,neuronsPerColumn);
% positions = gridtop(neuronsPerRow,neuronsPerColumn);
positions = hextop(neuronsPerRow,neuronsPerColumn);
% positions = randtop(neuronsPerRow,neuronsPerColumn);

% distances = boxdist(positions);
% distances = dist(positions);
% distances = linkdist(positions);
distances = mandist(positions);

%%%%%%%%%%%%
%distances = ring_distances(N);