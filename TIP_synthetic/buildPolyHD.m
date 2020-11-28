function [residual, A, rho] = buildPolyHD(n, L, B)

for i=1:10
% L is fx3
% B is 1xf

f = size(L, 1);
% x_h = zeros(f, 1);
% x_d = zeros(f, 1);
% x_l = zeros(f, 1);

v = [0, 0, 1];
V = repmat(v, [f, 1]);
H = L + V;
normH = sqrt(H(:, 1).^2 + H(:, 2).^2 + H(:, 3).^2);
H = H ./ repmat(normH, [1, 3]);
x_h = n * H';
x_d = (dot(H, L, 2))';
x_l = max(n * L', 1e-10);

% Trial 1: Linear
% X = ones(4, f);
% X(1, :) = x_h .* x_d .* x_l;
% X(2, :) = x_h .* x_l;
% X(3, :) = x_d .* x_l;
% X(4, :) = x_l;

% Trial 2: I = f(nh) * f(lh) * nl (Quadratic)
X = ones(9, f);
X(1, :) = x_h.^2 .* x_d.^2 .* x_l;
X(2, :) = x_h.^2 .* x_d .* x_l;
X(3, :) = x_h.^2 .* x_l;

X(4, :) = x_h .* x_d.^2 .* x_l;
X(5, :) = x_h .* x_d .* x_l;
X(6, :) = x_h .* x_l;

X(7, :) = x_d.^2 .* x_l;
X(8, :) = x_d .* x_l;
X(9, :) = x_l;


% Trial 3: I = f(nh) * f(lh) * nl (3-rd order)
% X = ones(16, f);
% X(1, :) = x_h.^3 .* x_d.^3 .* x_l;
% X(2, :) = x_h.^3 .* x_d.^2 .* x_l;
% X(3, :) = x_h.^3 .* x_d.^1 .* x_l;
% X(4, :) = x_h.^3 .* x_l;
% 
% X(5, :) = x_h.^2 .* x_d.^3 .* x_l;
% X(6, :) = x_h.^2 .* x_d.^2 .* x_l;
% X(7, :) = x_h.^2 .* x_d.^1 .* x_l;
% X(8, :) = x_h.^2 .* x_l;
%  
% X(9, :)  = x_h .* x_d.^3 .* x_l;
% X(10, :) = x_h .* x_d.^2 .* x_l;
% X(11, :) = x_h .* x_d.^1 .* x_l;
% X(12, :) = x_h .* x_l;
% 
% X(13, :) = x_d.^3 .* x_l;
% X(14, :) = x_d.^2 .* x_l;
% X(15, :) = x_d.^1 .* x_l;
% X(16, :) = x_l;

A = B * pinv(X);
rho = (A * X ./ x_l)';

residual = sum(abs(A * X - B));


end



