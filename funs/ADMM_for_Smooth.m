function [output] = ADMM_for_Smooth(meas, omega, rho, A, AT, P, PT, shifted_mask, varargin)
% Algorithm 1

    if (nargin-length(varargin)) ~= 8
        error('Wrong number of required inputs');
    elseif rem(length(varargin),2) == 1
        error('Optional inputs should always go by pairs')
    end
    for i = 1:2:length(varargin)-1
        switch lower(varargin{i})
            case 'admm_iter'
                ADMM_iter = varargin{i+1};
            case 'tv_iter'
                TV_iter = varargin{i+1};
            case 'initializer'
                if numel(varargin{i+1}) == 3 
                    init = 3;
            	    Vars = varargin{i+1};
                    S = Vars{1};
                    T = Vars{2};
                    E = Vars{3};
                else
                    error('Unknwon initializer (''initializer'')');
                end
            otherwise
                error(['Invalid parameter: ',varargin{i}]);
        end
    end

    pusai = A(shifted_mask);
    for i = 1:ADMM_iter
        temp_b = P(T) + 1/omega*E;
        temp_Y = meas;
        S = temp_b + AT((temp_Y-A(temp_b))./(omega+pusai));     % eq.21 Solve S
        T = proxTVa(PT(S-1/omega*E), rho/omega, TV_iter);       % e1.22 Solve T
        E = E - omega*(S-P(T));                                 % eq.19 Updating Multipliers
    end
    output = mean(T,3);                                         % eq.23
end