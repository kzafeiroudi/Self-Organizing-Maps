function somTrainParameters(setOrderLR,setOrderSteps,setTuneLR)

global distances maxNeighborDist tuneND orderLR orderSteps tuneLR;

maxNeighborDist = ceil(max(max(distances)));    %MaxDistance between two neurons in neighborhood
tuneND = 1;     %Distance during Tuning, usually = 1

orderLR = setOrderLR;       %Learning Rate during Ordering
orderSteps = setOrderSteps; %Epochs to train during Ordering
tuneLR = setTuneLR;         %Learning Rate during Tuning