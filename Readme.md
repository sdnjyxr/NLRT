# Nonlocal Low-Rank Tensor (NLRT)
This repository contains the MATLAB code for the paper **Hyperspectral Image Reconstruction of SD-CASSI Based on Nonlocal Low-Rank Tensor Prior**.

**All test data are available at [this link on Google Drive](https://drive.google.com/drive/folders/1DH7-Z6y5X-lqQyO-J3Sy3R68NKUUdH8I?usp=sharing).**

<p align="center">
<img src="https://sdnjyxr.github.io/NLRT/results/S3.gif?raw=true">
</p>

Figure 1. Reconstruction process of the hyperspectral image for scenario S3 as described in the corresponding paper.

<p align="center">
<img src="https://sdnjyxr.github.io/NLRT/results/S4.gif?raw=true">
</p>

Figure 2. Reconstruction process of the hyperspectral image for scenario S4 as described in the corresponding paper.


## Usage
### Download the NLRT repository
0. Requirements are MATLAB(R) with Parallel Computing Toolbox (`parfor` for multi-CPU acceleration).
1. Download this repository via git
```
git clone https://github.com/sdnjyxr/NLRT
```
### Run NLRT on hyperspectral images
3. Test the NLRT algorithm via
```matlab
NLRT.m
```

## Structure of directories

| directory  | description  |
| :--------: | :----------- | 
| `datasets` | data used for reconstruction             | 
| `funs`     | functions of main algorithms             |
| `results`  | reconstruction results                   |
| `tools`    | the toolbox used by the main algorithm   |
| `utils`    | utility functions                        |

## Platform
The testing environment utilizes MATLAB(R) R2023a on Ubuntu 22.10, equipped with an Intel® Xeon® w7-2495X × 48 processor and 256 GB RAM. It is compatible with any system running MATLAB(R) and Parallel Computing Toolbox, including Windows(R), Linux, or Mac OS. GPU is not required for running this code.

