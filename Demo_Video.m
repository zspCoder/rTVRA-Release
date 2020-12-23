%% =========================== Frist part notes ===========================
% Demo for rTVRA algorithm on the real captured video data for the dual-Camera compressive hyperspectral imaging system          
% -------------------------------------------------------------------------
%
%% =========================== Second part notes===========================
% Reference paper-1: Fast Parallel Implementation of Dual-Camera Compressive Hyperspectral Imaging System
% @article{zhang2018fast,
%   title={Fast parallel implementation of dual-camera compressive hyperspectral imaging system},
%   author={Zhang, Shipeng and Huang, Hua and Fu, Ying},
%   journal={IEEE Transactions on Circuits and Systems for Video Technology},
%   volume={29},
%   number={11},
%   pages={3404--3414},
%   year={2018}
% }
% Reference paper-2: Dual-camera design for coded aperture snapshot spectral imaging
% @article{wang2015dual,
%   title={Dual-camera design for coded aperture snapshot spectral imaging},
%   author={Wang, Lizhi and Xiong, Zhiwei and Gao, Dahua and Shi, Guangming and Wu, Feng},
%   journal={Applied optics},
%   volume={54},
%   number={4},
%   pages={848--858},
%   year={2015},
%   publisher={Optical Society of America}
% }
% -------------------------------------------------------------------------

%%
close all;clc;clear;
addpath(genpath('Utilized')); 

for frameIndex = 1:100
    
    %Load data
    dataMatname=sprintf('RealData\\Frame%02d.mat', frameIndex);
    load (dataMatname);
    fprintf('\nReconstructing Frame %02d\n',frameIndex);
    
    %Measurement of DualCameraDesign
    Y  = [cassiInput;panInput];
    Y  = Y.*(Y>0);
    
    %Imaging Principle
    A  = @(x)Rfuntwist_DualCamera(x,Mask,cameraSpectralResponse); %Forward image
    AT = @(x)RTfuntwist_DualCamera(x,Mask,cameraSpectralResponse);%Backward image
    
    %Parameters
    maxiterations      = 6;
    lambda             = 0.15;
    maxiterations_cg   = 25;
    ro                 = 35.10;
    tvFlag             = 'iso';
    
    x_rTVRA            = rTVRA(Y,A,AT,maxiterations,lambda,ro,tvFlag,maxiterations_cg);
    
    recMatname         = sprintf('Results\\rec_Video_Frame%02d.mat', frameIndex);
    save(recMatname,'x_rTVRA');
end
