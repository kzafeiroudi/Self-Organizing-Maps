clear all;

%Load Data Set
GroupData;

global D P IW distances Winners;

DataPatterns = ClassPatterns;

D = size(DataPatterns,1);
P = size(DataPatterns,2);
%Create minMax matrix from values of all patterns
for i=1:D
    minMax(i,1) = min(DataPatterns(i,:)); 
    minMax(i,2) = max(DataPatterns(i,:)); 
end

%Specify SOM characteristics
gridSize = [10 10];
Winners = zeros(100,1); %Initialization of Winners matrix

% Create SOM - Set TrainParameters
net = newsom(DataPatterns, gridSize, 'hextop', 'dist', 0.9, 1000, 0.01, 1);
net = train(net, DataPatterns);

HitsPerNeuron = zeros(size(net.IW{1,1},1),1);  

for i=1:size(DataPatterns,2)                        
    out = sim(net, DataPatterns(:, i));             
    winner = find(out);                             
    HitsPerNeuron(winner) = HitsPerNeuron(winner) + 1;
end

