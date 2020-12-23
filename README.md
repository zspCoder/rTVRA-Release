# rTVRA-Release

Source Code of rTVRA for Hyperspectral Image Reconstruction on Dual-camera Compressive Hyperspectral Imaging System
This repository contains the source code for the paper: **Shipeng Zhang, Hua Huang, and Ying Fu. Fast parallel implementation of dual-camera compressive hyperspectral imaging system. IEEE Transactions on Circuits and Systems for Video Technology, 2018, 29(11): 3404-3414.**

## Data
We provide the real captured data on our own hardware implementation of the dual-camera compressive hyperspectral imaging system, including the measurement of 100 frames hyperspectral video and 2 hyperspectral images. It can be download from [RealData](https://drive.google.com/drive/folders/1xTHmHsOOV0guuWuZKh7troiwYr7CupPO?usp=sharing).

## Usage
1. The demo for the real hyperspectral video reconstruction:
>Demo_Video.m 

2. The demo for the real hyperspectral image reconstruction.
>Demo_Image.m 

3. Code of the rTVRA algorithm.
>rTVRA.m 

## Citation
In case you need to use our data and code, please cite the following two papers.

@article{zhang2018fast,

  title={Fast parallel implementation of dual-camera compressive hyperspectral imaging system},
  
  author={Zhang, Shipeng and Huang, Hua and Fu, Ying},
  
  journal={IEEE Transactions on Circuits and Systems for Video Technology},
  volume={29},
  number={11},
  pages={3404--3414},
  year={2018}
}

@article{wang2015dual,
  title={Dual-camera design for coded aperture snapshot spectral imaging},
  author={Wang, Lizhi and Xiong, Zhiwei and Gao, Dahua and Shi, Guangming and Wu, Feng},
  journal={Applied Optics},
  volume={54},
  number={4},
  pages={848--858},
  year={2015}
}
