function [A] = prox_CP_4D(orig, rank)
%UNTITLED4 此处提供此函数的摘要
%   此处提供详细说明
    orig = tensor(orig);
    P = cp_als(orig, rank, 'printitn', 0);
    % P = cp_opt(orig, rank);
    A = double(zeros(size(double(orig))));
    for r = 1:rank
        u = reshape(P.U{1}(:,r), [], 1, 1, 1);
        v = reshape(P.U{2}(:,r), 1, [], 1, 1);
        w = reshape(P.U{3}(:,r), 1, 1, [], 1);
        p = reshape(P.U{4}(:,r), 1, 1, 1, []);
        A = A + P.lambda(r)*bsxfun(@times,bsxfun(@times,kron(u,v),w),p);
%         A = A + P.lambda(r)*kron(u,v);
    end
end