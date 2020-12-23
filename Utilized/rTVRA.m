%% =========================== Frist part notes ===========================
% rTVRA algorithm: Hyperspectral image reconstruction for snapshot hyperspectral imaging          
%                  (using ADMM to solve TV regularized reconstruction problem)
%      The approximate model:  
%                                min 0.5*||y-Hx||^2_2 + \lambda*||Dx||_1,
%      where D is the TV difference operator.
% -------------------------------------------------------------------------
%
%% =========================== Second part notes===========================
% Reference paper: Fast Parallel Implementation of Dual-Camera Compressive Hyperspectral Imaging System
% @article{zhang2018fast,
%   title={Fast parallel implementation of dual-camera compressive hyperspectral imaging system},
%   author={Zhang, Shipeng and Huang, Hua and Fu, Ying},
%   journal={IEEE Transactions on Circuits and Systems for Video Technology},
%   volume={29},
%   number={11},
%   pages={3404--3414},
%   year={2018}
% }
% -------------------------------------------------------------------------
%
%% =========================== Thrid part notes =========================== 
% INPUT:
%   Y:     compressive measurement of snapshot hyperspectral imaging systems
%   A:     forward imaging principle            
%   AT:    backward imaging principle
%   maxIter: max iteration number for the main loop. Generally, 6-10 for a
%            higher-efficiency implementation, >10 for a higher-fidelity implementation
%   lambda:  the regularization factor for data fedility term
%   ro:  the regularization factor for lagrangian multiplier fedility term,
%        >10 for real data, [2,10] for synthetic data
%   flag: type for TV regularization, 'iso' for Isotropy TV regularization,
%         'aniso' for Ansotropy TV regularization
%   cgIter: max iteration for the conjugate gradient algorithm
% OUTPUT:
%   x:    reconstructed image
%  ========================================================================


function [x] = rTVRA(Y,A,AT,maxIter,lambda,ro,flag,cgIter)

%% Initialize parameters
[D,Dt]      = defDDt();

ATb         = AT(Y);
x           = ATb;
sizeX       = size(x);
T1          = zeros(size(x));
T2          = zeros(size(x));
V1          = zeros(size(x));
V2          = zeros(size(x));

%% Initialize the objective function value
[Dx1, Dx2]  = D(x);
resid       = Y-A(x);
f_prev      = 0.5*(resid(:)'*resid(:)) + lambda*sum(sqrt(Dx1(:).^2+Dx2(:).^2));

fprintf('Start rTVRA-CPU Reconstruction\n');
fprintf('Initial Objective Function Value = %.6e\n',f_prev);

%% Main loop
for itr=1:maxIter
    
    %% Update the hyperspectral image
    aux         =  ATb+Dt(ro*T1+V1,ro*T2+V2);
    [xt,~]      =  pcg(@(x) Afun(x,AT,A,Dt,D,ro,sizeX),aux(:),1E-4,cgIter,[],[],x(:));
    x           =  reshape(xt,sizeX);
    
    %% Update the auxiliary variable
    [Dx1, Dx2]  = D(x);
    U1          = Dx1-(1/ro)*(V1);
    U2          = Dx2-(1/ro)*(V2);
    if strcmp(flag,'iso')
        %Isotropy TV regularization
        U       = sqrt(U1.^2 + U2.^2);
        U(U==0) = 1e-6;
        U       = max(U - lambda/ro, 0)./U;
        T1      = U1.*U;
        T2      = U2.*U;
    else
        %Anisotropy TV regularization
        T1      = max(abs(U1) - lambda/ro, 0).*sign(U1);
        T2      = max(abs(U2) - lambda/ro, 0).*sign(U2);
    end
    
    %% Update the Lagrangian multiplier
    V1    = V1 + ro*(T1 - Dx1);
    V2    = V2 + ro*(T2 - Dx2);
    
    %% Update the objective function value
    resid = Y-A(x);
    f_cur = 0.5*(resid(:)'*resid(:)) + lambda*sum(sqrt(Dx1(:).^2+Dx2(:).^2));
    
    %% Update the parameters
    if(f_cur>f_prev)
        ro = ro*2;
        fprintf('Increasing Ro = %f\n',ro);
        if(ro>1e8)
            break;
        end
    else
        criterion=abs(f_prev-f_cur)/f_prev;
        if(criterion<1e-6)
            break;
        end
        fprintf('Iteration = %02d, funValue = %.6e, Criterion = %.6f\n',itr,f_cur,criterion);
        ro     = ro*1.001;
        f_prev = f_cur;
    end
end
x    =  x.*(x>0);
fprintf('rTVRA-CPU Reconstruction Has Finished.\n');
end

%% Auxiliary function for CG
function [y] = Afun(x,AT,A,Dt,D,ro,sizeX)
    x        = reshape(x,sizeX);
    [dx,dy]  = D(x);
    dtd      = ro*Dt(dx,dy);
    y        = AT(A(x));
    y        = y(:)+dtd(:);
end