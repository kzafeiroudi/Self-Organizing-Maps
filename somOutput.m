function [ output ] = somOutput(pattern)
    global IW;
    
    % IW -> NxD
    % pattern -> Dx1, contains D-characteristics of a single pattern
    % output -> Nx1, contains output value of each neuron
    
    output = compet(negdist(IW, pattern));
    
    %negdist -> compute negative euclidean distance
    %compet -> find winner neuron and set its value 1