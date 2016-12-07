%% % Testing Phase %%%%%%%%%%%%%%%%%%%%
%% load testing hyper-cube
clc; clearvars; close all;
addpath('Dictionaries')


load('test_cube.mat')
load('Dicts_x2_hyperion.mat')

full_bands = size(test_cube,3);
sub_sampling = 2; % sub-sampling factor
lambda = 0.1; % sparsity regularization parameter

% lin_p = 1.95;   % parameter that scales the differences between low & high spectral res. hyper-pixels
% % for x4 sub-sampling factor
% % lin_p = 1.8;  % parameter that scales the differences between low & high spectral res. hyper-pixels
% % for x3 sub-sampling factor
lin_p = 1.38; % parameter that scales the differences between low & high spectral res. hyper-pixels
% for x2 sub-sampling factor

test_cube_small = test_cube(156:755,571:970,:);
%% Run spectral super-resolution
tic
[full_bands_admm] = SPSR(test_cube_small, D_high, D_low, lambda,lin_p,full_bands,sub_sampling);
toc

%% Calculate PSNR
psnrRec_admm=myPSNR(double(full_bands_admm),double(test_cube_small),1);
fprintf('\nPSNR (ADMM SSR Recovery)= %.2f \n',psnrRec_admm);

% Display Cubes
figure;
for ii=1:size(full_bands_admm,3)
    imagesc(full_bands_admm(:,1:end,ii)); title(sprintf('Band %d',ii));
    pause(0.5)
end

% Save Results
% save('Results\full_spectrum_x2.mat','full_bands_admm')