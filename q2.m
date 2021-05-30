clc;
clear;
close all;

%% Set Seed
rng(1);

%% Constants
% Dimension of signal
n = 128;
% Tolerance factor for creating Orthonormal Matrix
tol = 0.1;

%% Initialize Avg. Relative RMSE list
rmse_avg = [];

%% Generating a random orthonormal matrix
% The n-dimensional normal distribution has spherical symmetry,
% which implies that after normalization the drawn vectors would be
% uniformly distributed on the n-dimensional unit sphere.
% Then using Gram-schmidt on the random vector to generate matrix
U = zeros(n);
vi = randn(n,1);
U(:,1) = vi ./ norm(vi);
for i=2:n
    nrm = 0;
    % only if vector has sufficiently large component orthogonal to U
    while nrm < tol
        vi = randn(n,1);
        vi = vi - U(:,1:i-1) * (U(:,1:i-1)' * vi);
        nrm = norm(vi);
    end
    U(:,i) = vi ./ nrm;
end

for alpha=[0, 3]
    %% Generating Co-variance Matrix
    Sigma = U * diag((1:n).^(-alpha)) * U';

    %% Generating 10 n-dimensional vectors
    xs = mvnrnd(zeros(n,1), Sigma, 10)';

    %% Reconstruction
    for m=[40, 50, 64, 80, 100, 120]
        rmse = zeros(10, 1);

        % Generating a random sensing matrix
        phi = randn(m, n) / sqrt(m);

        % Variables used in reconstruction (for faster computation)
        SpT = Sigma * phi';
        pSpT = phi * SpT;

        for i=1:10
            % Generating noisy measurement
            y = phi * xs(:, i);
            sig = 0.01 * mean(abs(y));
            y = y + mvnrnd(zeros(m, 1), eye(m)*sig^2, 1)';

            % Reconstruction of x
            x = (SpT - SpT/(eye(m)*sig^2 + pSpT)*pSpT) * y / (sig^2);

            % Calculating Avg. Relative RMSE
            rmse(i) = sqrt(mean((x - xs(:,i)).^2))/sqrt(mean(xs(:,i).^2));
        end
        rmse_avg = [rmse_avg mean(rmse)];
    end
end

%% Plot the Avg. Relative RMSE vs m
figure;

plot([40, 50, 64, 80, 100, 120], rmse_avg(1:6), 'r');
legend("\alpha = 0");
xlabel("m");
ylabel("Avg. Relative RMSE");
title("Avg. Relative RMSE Vs m");
saveas(gcf, "plots/0.jpg");
plot([40, 50, 64, 80, 100, 120], rmse_avg(7:12), 'b');
legend("\alpha = 3");
xlabel("m");
ylabel("Avg. Relative RMSE");
title("Avg. Relative RMSE Vs m");
saveas(gcf, "plots/3.jpg");
hold on;
plot([40, 50, 64, 80, 100, 120], rmse_avg(1:6), 'r');
legend("\alpha = 3", "\alpha = 0");
xlabel("m");
ylabel("Avg. Relative RMSE");
title("Avg. Relative RMSE Vs m");
saveas(gcf, "plots/both.jpg");

close all;

%% Print the Avg. Relative RMSE
fprintf("Avg. Relative RMSE for \x03b1 = 0, m = %i \t: %f\n", [[40, 50, 64, 80, 100, 120]; rmse_avg(1:6)]);
fprintf("Avg. Relative RMSE for \x03b1 = 3, m = %i \t: %f\n", [[40, 50, 64, 80, 100, 120]; rmse_avg(7:12)]);
