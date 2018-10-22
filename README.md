# CVPR18_detect_globally_refine_locally

## Detect Globally, Refine Locally: A Novel Approach to Saliency Detection (DGRL)
This package has the source code for the paper "Detect Globally, Refine Locally: A Novel Approach to Saliency Detection" (CVPR18).

## Paper link
* The paper can be found in [Baidu drive](https://pan.baidu.com/s/177EfYKf48VDzflB0S7zL2w) or [Google drive](https://drive.google.com/open?id=17MyYRD5kbSFMn0bw7s5pbmWRU-R6_LiR).

## How to use
Train

Test
* Download our trained model from [Baidu drive](https://pan.baidu.com/s/1TqIsKJrRbiQUhOGq1brCDg) or [Google drive](https://drive.google.com/open?id=12uRLj3CnjkLsq4fggJPox-PXh4uuy_FG).
* Run `./stage1/test/test.m` to generate saliency maps of Global Localizaiton Network (GLN). 
* Run `./stage2/test/test.m` to generate saliency maps of Boundary Refinement Network (BRN). 
The saliency maps of GLN will serve as the input of BRN.


## Download
* The saliency maps on 10 datasets including ECSSD, PASCAL-S, SOD, SED1, SED2, MSRA, DUT-OMRON, THUR15K, HKU-IS and DUTS 
can be found in [Baidu drive]() or [Google drive]().

## Cite this work
If you find this work useful in your research, please consider citing:

     @inproceedings{wang2018detect,
       title={Detect Globally, Refine Locally: A Novel Approach to Saliency Detection},
       author={Wang, Tiantian and Zhang, Lihe and Wang, Shuo and Lu, Huchuan and Yang, Gang and Ruan, Xiang and Borji, Ali},
       booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
       pages={3127--3135},
       year={2018}
     }
     

## Contact
tiantianwang.ice@gmail.com



