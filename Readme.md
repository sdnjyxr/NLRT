# Nonlocal Low-Rank Tensor (NLRT)
This repository contains the MATLAB code for the paper **Hyperspectral Image Reconstruction of SD-CASSI Based on Nonlocal Low-Rank Tensor Prior**.

**[New] Real data and associated code are available at [this link on Google Drive](https://drive.google.com/open?id=1d2uh9nuOL5Z7WnEQJ5HZSDMWK2VAT9sH) or [Baidu Drive](https://pan.baidu.com/s/1mEODhEd0_zP4-hBhWUTp2g).** Note that the code for real data is not tested but with raw results as in the paper. Please refer to the readme file for the original source(s) of the real data.

<p align="center">
<img src="https://github.com/liuyang12/DeSCI/blob/master/results/video/desci_gmm_gaptv_kobe32.gif?raw=true">
</p>

Figure 1. Reconstructed `Kobe` video using DeSCI compared with the state-of-the-art methods, *i.e.*, GMM-TP (TIP'14), MMLE-GMM (TIP'15), MMLE-MFA (TIP'15), and GAP-TV (ICIP'16). Here, 8 video frames are encoded in a single measurement and a total of 32 frames are presented by reconstructing 4 snapshot measurements. The `Kobe` video is used in the MMLE-GMM [paper](https://doi.org/10.1109/TIP.2014.2365720 "Compressive Sensing by Learning a Gaussian Mixture Model From Measurements, TIP'15").

## Usage
### Download the NLRT repository
0. Requirements are MATLAB(R) with Parallel Computing Toolbox (`parfor` for multi-CPU acceleration).
1. Download this repository via git
```
git clone https://github.com/sdnjyxr/NLRT
```
### Run NLRT on hyperspectral images
3. Test the DeSCI algorithm (for hyperspectral imaging, that is CASSI on `toy` dataset) via
```matlab
test_desci_cassi.m
```
and (optionally) video demonstrate the reconstruction results (after running `test_desci_cassi.m`) via
```matlab
./figures/fig_desci_cassi.m
```

## Structure of directories

| directory  | description  |
| :--------: | :----------- | 
| `algorithms` | MATLAB functions of main algorithms proposed in the paper (original) | 
| `figures`    | MATLAB scripts to reproduce the results and figures in the paper (original) |
| `packages`   | algorithms adapted from the state-of-art algorithms (adapted)|
| `dataset`    | data used for reconstruction (simulated) |
| `results`    | results of reconstruction (after reconstruction) |
| `utils`      | utility functions |

## Platform
The test platform is MATLAB(R) R2023a operating on Ubuntu 22.10 with an Intel® Xeon® w7-2495X × 48 and 256 GB RAM. It can run on any machine with MATLAB(R) and Parallel Computing Toolbox, operating on Windows(R), Linux, or Mac OS. No GPU is needed to run this code.

