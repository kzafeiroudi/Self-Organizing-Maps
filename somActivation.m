function [ a ] = somActivation(pattern, neighborDist)
    global distances Winners;
    
    fire = find(somOutput(pattern)); % Find winner neuron (value = 1)
    Winners(fire) = Winners(fire) + 1 ;  
    
    a = distances(fire, :) <= neighborDist;
    %Set a = 1 within neighborhood, a = 0 otherwise
    
    a = a .* 0.5;    %For neurons in neighborhood a = 0.5
    a(fire) = 1;     %For winner neuron a = 1
