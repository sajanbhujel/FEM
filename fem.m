clear all; clc;
syms xi eta real;

E = 3e7;
nu = 0.3;       

D = (E/(1-nu^2)) * [1   nu   0;
                     nu  1    0;
                     0   0    (1-nu)/2];
nodes = [0 1;    
         0 0;    
         2 0.5;  
         2 1];   

N = [(1-xi)*(1-eta)/4;
     (1+xi)*(1-eta)/4;
     (1+xi)*(1+eta)/4;
     (1-xi)*(1+eta)/4];

dNdxi = [diff(N,xi), diff(N,eta)]

J = dNdxi' * nodes

detJ = det(J)
invJ = inv(J)

dNdx = invJ * dNdxi'

B = sym(zeros(3,8));
for i = 1:4
    B(1,2*i-1) = dNdx(1,i);  
    B(2,2*i)   = dNdx(2,i);  
    B(3,2*i-1) = dNdx(2,i);   
    B(3,2*i)   = dNdx(1,i);
end

K_integrand = B' * D * B * detJ;


K_func = matlabFunction(K_integrand, 'Vars', [xi, eta])

gauss_pts = [-1/sqrt(3), -1/sqrt(3); 
             -1/sqrt(3),  1/sqrt(3);
              1/sqrt(3), -1/sqrt(3);
              1/sqrt(3),  1/sqrt(3)];
weights = [1, 1];

K = zeros(8,8);
for gp = 1:4
    xi_val = gauss_pts(gp,1);
    eta_val = gauss_pts(gp,2);
    K = K + K_func(xi_val, eta_val)
end

fixed_dofs = [1, 2, 3, 4]; 
free_dofs = setdiff(1:8, fixed_dofs);

F = zeros(8,1);
F([2, 8]) = -20;

K_ff = K(free_dofs, free_dofs);
F_f = F(free_dofs);
U_f = K_ff \ F_f

U = zeros(8,1);
U(free_dofs) = U_f;

disp('Nodal Displacements [x, y] (meters):');
for i = 1:4
    fprintf('Node %d: [%.4e, %.4e]\n', i, U(2*i-1), U(2*i));
end

disp('Stresses at Gauss Points [σ_xx, σ_yy, τ_xy] (Pa):');
for gp = 1:4
    xi_val = gauss_pts(gp,1);
    eta_val = gauss_pts(gp,2);

    B_num = double(subs(B, {xi, eta}, {xi_val, eta_val}));
    stress = D * B_num * U;

    fprintf('GP %d: [%.2f, %.2f, %.2f]\n', gp, stress(1), stress(2), stress(3));
end

figure;
hold on; axis equal;
node_labels = {'1','2','3','4'};
for i = 1:4
    plot(nodes(i,1), nodes(i,2), 'ko', 'MarkerSize', 8, 'LineWidth', 2);
    text(nodes(i,1)+0.05, nodes(i,2), node_labels{i}, 'FontSize', 12, 'Color', 'r');
end
fill(nodes([1 2 3 4 1],1), nodes([1 2 3 4 1],2), 'cyan', 'FaceAlpha', 0.3);
title('4-Node Q4 Element Mesh');
xlabel('X'); ylabel('Y');
