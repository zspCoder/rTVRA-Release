# rTVRA-Release

Source code of **rTVRA** for hyperspectral image reconstruction on dual-camera compressive hyperspectral imaging system (DCCHI)
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

@article{zhang2018fast,<br/>
  title={Fast parallel implementation of dual-camera compressive hyperspectral imaging system},<br/>
  author={Zhang, Shipeng and Huang, Hua and Fu, Ying},<br/>
  journal={IEEE Transactions on Circuits and Systems for Video Technology},<br/>
  volume={29},<br/>
  number={11},<br/>
  pages={3404--3414},<br/>
  year={2018}<br/>
}<br/>
<br/>
@article{wang2015dual,<br/>
  title={Dual-camera design for coded aperture snapshot spectral imaging},<br/>
  author={Wang, Lizhi and Xiong, Zhiwei and Gao, Dahua and Shi, Guangming and Wu, Feng},<br/>
  journal={Applied Optics},<br/>
  volume={54},<br/>
  number={4},<br/>
  pages={848--858},<br/>
  year={2015}<br/>
}<br/>
