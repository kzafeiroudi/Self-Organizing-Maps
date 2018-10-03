function somTrain(patterns)   
    % patterns -> DxP, each column is a pattern x
    global maxNeighborDist tuneND orderLR orderSteps tuneLR P;

	% Ordering Phase %

    %Create matrices which contain exponentially declining values from:
    % i) maxNeighborDist to TuneND
    % ii)orderLR to tuneLR
	OrderingND = linspace(maxNeighborDist,tuneND,orderSteps);
	OrderingLR = linspace(orderLR,tuneLR,orderSteps);

	for i=1:orderSteps
		neighborDist = OrderingND(i);
		learningRate = OrderingLR(i);
        
        %Train for each of P - patterns
        for j=1:P
			somUpdate(patterns(:,j), learningRate, neighborDist);
		end
    end

	% Tuning Phase %

    neighborDist = tuneND ;
	learningRate = tuneLR ;
    
    coeff = 4;  %coefficient values range from 2 to 5
	tuningSteps = orderSteps * coeff;
    
	for i=1:tuningSteps
        
        %Train for each of P - patterns
		for j=1:P
			somUpdate(patterns(:,j), learningRate, neighborDist);
		end
	end

