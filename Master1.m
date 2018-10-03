clear all;

%Load Data Sets
Triangle;
OneSpiral;
TwoSpirals;
GroupData;

global D P IW distances Winners ;

DataPatterns = ClassPatterns;

D = size(DataPatterns,1);
P = size(DataPatterns,2);
%Create minMax matrix from values of all patterns
for i=1:D
    minMax(i,1) = min(DataPatterns(i,:)); 
    minMax(i,2) = max(DataPatterns(i,:)); 
end


%Specify SOM characteristics
gridSize = [15 15];
Winners = zeros(225,1); %Initialization of Winners matrix

somCreate(minMax, gridSize); %Create SOM
    
%Set TrainParameters
orderLR = 0.9; 
orderEpochs = 500;
tuneLR = 0.1; 
somTrainParameters(orderLR,orderEpochs,tuneLR);

%Train SOM
somTrain(DataPatterns);

%Show final SOM
figure; 
plot2DSomData(IW,distances,DataPatterns);

figure;
somShow(IW,gridSize);