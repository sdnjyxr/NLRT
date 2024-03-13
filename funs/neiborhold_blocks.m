function [mn] = neiborhold_blocks(k_blocks, gg, bparams, searchsz)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    num1 = bparams.block_num(1);
    num2 = bparams.block_num(2);
    ref_blocks = k_blocks(:,:,:,gg);
    [block_pos1, block_pos2] = ind2sub(bparams.block_num, gg); % [x,y]
    cnt = 1;
    D = zeros(1, searchsz(1)*searchsz(2));
    ind_blocks = zeros(1, searchsz(1)*searchsz(2));
    for i = -(searchsz(1)-1)/2:(searchsz(1)-1)/2
        for j = -(searchsz(2)-1)/2:(searchsz(2)-1)/2
            if block_pos1 + i < 1 || block_pos1 + i > num1 || block_pos2 + j < 1 || block_pos2 + j > num2
                D(cnt) = inf;
                cnt = cnt + 1;
                continue;
            end
            nowpos = [block_pos1 + i, block_pos2 + j];
            ind_blocks(cnt) = sub2ind(bparams.block_num, nowpos(1), nowpos(2));
            D(cnt) = normArr(k_blocks(:,:,:,ind_blocks(cnt))-ref_blocks);
            cnt = cnt + 1;
        end
    end
    [~,ind] = sort(D);
    maxK = findMaxK(D(ind),1e-1);
    k = min(max(5, maxK),17);
    mn = ind_blocks(ind(1:k));
    if isempty(find(mn == gg, 1))
        mn = [gg, mn(1:k-1)];
    end
end

function maxK = findMaxK(data, threshold)
    n = length(data);
    left = 1;
    right = n;
    maxK = 0;

    while left <= right
        mid = floor((left + right) / 2);
        
        if std(data(1:mid)) <= threshold
            maxK = mid;
            left = mid + 1;
        else
            right = mid - 1;
        end
    end
end
