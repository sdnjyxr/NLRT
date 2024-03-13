function [Y] = Regular(X,mn_cell, bparams, rank)
    K = length(mn_cell);
    k_blocks = ExtractBlocks(X, bparams);     

    kout_blocks = zeros(size(k_blocks));
    gg_cell = cell(1,K);

    mlt_blocks = zeros(size(k_blocks));
    out_blocks_cell = cell(1,K); 

    parfor i = 1:K
        gg = mn_cell{i};
        now_block = k_blocks(:,:,:,gg);
        temp_Regular = prox_CP_4D(now_block,rank);
        out_blocks_cell{i} = temp_Regular;
        gg_cell{i} = gg;
    end

    for i = 1:K
        gg = gg_cell{i};
        mlt_blocks(:,:,:,gg) = mlt_blocks(:,:,:,gg) + 1;
        kout_blocks(:,:,:,gg) = kout_blocks(:,:,:,gg) + out_blocks_cell{i};
    end
    kout_blocks = kout_blocks./mlt_blocks;

    Y = JointBlocks(kout_blocks, bparams);
end
