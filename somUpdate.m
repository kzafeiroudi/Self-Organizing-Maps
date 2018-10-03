function somUpdate(pattern, learningRate, neighborDist)
    global N IW;
    
    a = somActivation(pattern, neighborDist);   %compute a using somActivation
    
    %update weights using: W_new = W_old + LR*a*(Xpattern - W_old)
    for j=1:N
        IW(j,:) = IW(j,:) + learningRate * a(1,j) * (pattern' - IW(j,:));   
    end
