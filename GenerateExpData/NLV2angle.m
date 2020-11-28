function brdf4D = NLV2angle(N,L,V)
% assume isotropy and reciprocity

L = L(:)'/norm(L);
V = V(:)'/norm(V);
N = N ./ repmat(sqrt(sum(N.^2,2)),[1 3]);

theta_in  = acos(max(min(N*L',1),-1));
theta_out = acos(max(min(N*V',1),-1));

phi_in = zeros(size(theta_in)); 

projL = repmat(L,[size(N,1) 1]) - repmat(N*L',[1 3]) .* N;
projV = repmat(V,[size(N,1) 1]) - repmat(N*V',[1 3]) .* N;
projL = projL ./ repmat(sqrt(sum(projL.^2,2)),[1 3]);
projV = projV ./ repmat(sqrt(sum(projV.^2,2)),[1 3]);

phi_out = acos(max(min(sum(projL.*projV,2),1),-1));
% phi_sig = sign(dot(N,cross(projL,projV,2),2));
% phi_sig(phi_sig==0) = 1;
% phi_out = phi_out .* phi_sig;

brdf4D = [theta_in phi_in theta_out phi_out];
