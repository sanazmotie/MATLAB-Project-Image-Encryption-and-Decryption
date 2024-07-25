function [r] = random_matris(seed,bin_matrix_r)
%sakht matris adad random
rng(seed);
r=randi([1 64],bin_matrix_r,8);
end

