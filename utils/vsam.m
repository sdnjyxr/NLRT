function [sammean,sam_2D] = vsam(v,ref)
%VPSNR Peak signal-to-noise ratio (PSNR) for a video or volume.
%   psnrmean=VPSNR(v,ref,maxval) returns the mean PSNR of the image
%   sequence, where v is the video or volume, ref is the reference 
%   video or volume with the same dimension as v, and maxval is the 
%   maximum value of the video or volume, say 255 for uint8.
%   See also: PSNR.
sam_2D = acos(sum(v.*ref,3)./(sqrt(sum(v.^2,3)).*sqrt(sum(ref.^2,3))));
sammean = mean(sam_2D(:));

    