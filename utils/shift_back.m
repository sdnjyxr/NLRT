function [X] = shift_back(Y, step)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    [rows, cols, dims, channels] = size(Y);
    X = zeros(rows, cols-(dims-1)*step, dims, channels);
    [~, ccols, ~] = size(X);
    for i = 1:dims
        X(:, :, i, :) = Y(:,(i-1)*step+1:(i-1)*step+ccols,i, :);
    end
end