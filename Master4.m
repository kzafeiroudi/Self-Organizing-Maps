clear all;

%Load Data Sets
load NIPS500.mat

global D P IW distances Winners;

DataPatterns = Patterns ;
DataPatterns = full(tfidf1(DataPatterns));
DataPatterns = DataPatterns.';

D = size(DataPatterns,1);
P = size(DataPatterns,2);

%Create minMax matrix from values of all patterns
for i=1:D
    minMax(i,1) = min(DataPatterns(i,:)); 
    minMax(i,2) = max(DataPatterns(i,:)); 
end

%Specify SOM characteristics
gridSize = [10 10];

% Create SOM - Set TrainParameters
net = newsom(minMax, gridSize, 'hextop', 'dist', 0.9, 1000, 0.01, 1);
net.IW{1,1} = rand(100,8296);
net = train(net, DataPatterns);

%4.1
RecordsPerNeuron = zeros(size(net.IW{1,1},1),1);    %Create a vector to store the records of each neuron #size(IW)

for i=1:size(DataPatterns,2)                        %Simulate the SOM for each record #size(DataPatterns)
    out = sim(net, DataPatterns(:, i));             %And save which neuron recognises it
    winner = find(out);                             
    RecordsPerNeuron(winner) = RecordsPerNeuron(winner) + 1;
end

RecordsPerNeuron = RecordsPerNeuron.*100./(size(DataPatterns,2));
for i=1:100
    fprintf('Neuron %d has %d per cent of records \n\n', i, RecordsPerNeuron(i))
end


%4.2
IWtemp = net.IW{1,1};

for i=1:size(IWtemp,1)                              %Find the max value and its index
%     max1(i) = find(IWtemp(i,:) == max(IWtemp(i,:)));
    [num1(i), max1(i)] = max(IWtemp(i,:));
    IWtemp(i, max1(i)) = -inf;                      %And the index of the second to max value
    max2(i) = find(IWtemp(i,:) == max(IWtemp(i,:)));
end

for i=1:size(IWtemp,1)                              %Save and Print the terms corresponding to the indices above
    fprintf('For neuron %d , most frequent terms are:\n', i);
    term1 = terms(max1(i))
    term2 = terms(max2(i))
    terms1(i,1) = term1;
    terms2(i,1) = term2;
    fprintf('\n');
end

%4.3
IWtemp = net.IW{1,1};
cool = zeros(size(IWtemp,1),1);                     
term1 = find(strcmp(terms, 'neutral'));             %Get the position of the desired terms in vector 'terms'
term2 = find(strcmp(terms, 'algorithm'));

for i=1:size(IWtemp,1)                              %If the weights corresponding to these terms are greater than
                                                    %40% of the max weight of each neuron store neuron
    if ((IWtemp(i,term1) > 0.4*num1(i)) || (IWtemp(i,term2) > 0.4*num1(i)))  
        cool(i) = 1;
        fprintf('Neuron %d satisfies \n', i)
    end
end

if (max(cool) == 0)
    fprintf('No neuron satisfies, do not run 4.4 and 4.5 \n')
end

%4.4
IWtemp = net.IW{1,1};
total_maxima = max(max(IWtemp));                    %Find the maximum of all weights of all neurons

coolZ = [];
for i=1:size(IWtemp,1)                              %Create a new IW only with the neurons satisfying 4.4
    if (cool(i)==1)
        coolZ = [coolZ; IWtemp(i,:)];
    end
end

AvG = mean(coolZ);                                  %Row-vector with the mean value of weights for each term
AvG = AvG.*100./total_maxima;                            %As a percent of the maximum weight

%4.5
[Sorted_AvG, sortedIndex] = sort(AvG,'descend');    %Sort AvG in descending order and get the sorted indices

for i=1:length(terms)                               %Create a new matrix with the sorted terms
    sorted_terms(i) = terms(sortedIndex(i));
end
sorted_terms = sorted_terms'