function [Y] = shift(X, step)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    [rows, cols, dims, channels] = size(X);
    Y = zeros(rows, cols+(dims-1)*step, dims, channels);
    for i = 1:dims
        Y(:, (i-1)*step+1:(i-1)*step+cols, i, :) = X(:,:,i,:);
    end
end