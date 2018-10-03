function [distances] = ring_distances(N)



	v = zeros(1,N);
	distances = diag(v);
	if rem(N,2)==0,
		max_dist = N/2;
	else 
		max_dist = (N-1)/2;
	end
	max_dist
	for i=1:max_dist,
		i
		v = ones(1,N-i)*i;
		distances = distances+diag(v,i);
		distances = distances+diag(v,-i);
		v = ones(1,i)*i;
		if (i==max_dist) & (rem(N,2)==0),
			break
		end
		distances = distances+diag(v,N-i);
		distances = distances+diag(v,i-N);

   
	end
end