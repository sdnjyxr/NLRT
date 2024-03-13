function [X, V, metric] = ADMM_for_NLRT(Y,gamma,mn_cell,bparams,A,AT,P,PT,shifted_mask,varargin)
% Algorithm 2

    display = false;
    if (nargin-length(varargin)) ~= 9
        error('Wrong number of required inputs');
    elseif rem(length(varargin),2) == 1
        error('Optional inputs should always go by pairs')
    end
    for i = 1:2:length(varargin)-1
        switch lower(varargin{i})
            case 'display'
                display = varargin{i+1};
            case 'niters'
                niters = varargin{i+1};
            case 'orig'
                orig = varargin{i+1};
            case 'rank'
                rank = varargin{i+1};
            case 'initializer'
                if numel(varargin{i+1}) == 3   % we have an initial x
                    init = 3;
            	    Vars = varargin{i+1};
                    X = Vars{1};
                    V = Vars{2};
                    M = Vars{3};
                else
                    error('Unknwon initializer (''initializer'')');
                end
            otherwise
                error(['Invalid parameter: ',varargin{i}]);
        end
    end

    psnr = zeros(1,niters);
    ssim = zeros(1,niters);
    sam = zeros(1,niters);

    pusai = A(shifted_mask);
    for i = 1:niters
        T_temp = tic;
        temp = P(X)+1/gamma*M;
        V = temp + AT((Y-A(temp))./(gamma+pusai));      % eq.29 Solve V
        temp = PT(V-1/gamma*M);
        X = Regular(temp, mn_cell, bparams, rank);      % eq.32-35 Solve X
        % X_restore(:,:,:,i) = X;
        M = M - gamma*(V-P(X));                         % eq.36 Updating Multipliers
        if display
            psnr(i) = vpsnr(X, orig);
            ssim(i) = vssim(X, orig);
            sam(i) = vsam(X, orig)/pi*180;
            relErrX(i) = Norm_F(P(X) - V);
            if i ~= 1
                relChgX(i) = Norm_F(-gamma*PT(V-V_last));
            else
                relChgX(i) = 1e9;
            end
            T(i) = toc(T_temp);
            fprintf('%d/%d: PSNR:%f SSIM:%f SAM:%f relErrX:%f relChgX:%f T:%f\n', i, niters, psnr(i), ssim(i), sam(i), relErrX(i), relChgX(i), T(i));
        end
        V_last = V;
    end 

    metric = [psnr;ssim;sam];

    function cost = Norm_F(X)
        cost = normArr(X)^2;
    end

end