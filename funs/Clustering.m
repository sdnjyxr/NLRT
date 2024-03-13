function [mn_cell, bparams] = Clustering(initial_image, rows, cols, varargin)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    if (nargin-length(varargin)) ~= 3
        error('Wrong number of required inputs');
    elseif rem(length(varargin),2) == 1
        error('Optional inputs should always go by pairs')
    end
    for i = 1:2:length(varargin)-1
        switch lower(varargin{i})
            case 'winsize'
                winsize = varargin{i+1};
            case 'overlap'
                overlap = varargin{i+1};
            case 'searchsz'
                searchsz = varargin{i+1};
            otherwise
                error(['Invalid parameter: ',varargin{i}]);
        end
    end
    
    if ~exist('winsize', 'var')
        winsize = 10;
    end

    if ~exist('overlap', 'var')
        overlap = 5;
    end

    if ~exist('searchsz', 'var')
        searchsz = [7,7];
    end

    num1                =   (rows-winsize)/(winsize-overlap)+1; % 行分块数量
    num2                =   (cols-winsize)/(winsize-overlap)+1; % 列分块数量
    if rem(num1,1) ~= 0
        num1 = floor(num1) + 1;
    end

    if rem(num2,1) ~= 0
        num2 = floor(num2) + 1;
    end
    bparams.img_sz      =   [rows,cols];
    bparams.block_sz    =   [winsize,winsize];
    bparams.overlap_sz  =   [overlap,overlap];
    bparams.block_num   =   [num1,num2]; 


    mn_cell = cell(1,num1*num2);
    k_blocks = ExtractBlocks(initial_image, bparams);
    parfor gg = 1:num1*num2
        mn = neiborhold_blocks(k_blocks, gg, bparams, searchsz);
        mn_cell{gg} = mn;
    end
