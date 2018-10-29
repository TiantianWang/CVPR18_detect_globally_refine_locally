
## Detect Globally, Refine Locally: A Novel Approach to Saliency Detection (DGRL)
This package has the source code for the paper "Detect Globally, Refine Locally: A Novel Approach to Saliency Detection" (CVPR18).

## Paper link
* The paper can be found in [Baidu drive](https://pan.baidu.com/s/177EfYKf48VDzflB0S7zL2w) or [Google drive](https://drive.google.com/open?id=17MyYRD5kbSFMn0bw7s5pbmWRU-R6_LiR).

## How to use
Train
* For Global Localizaiton Network (GLN), using the code in `./stage1/train/` for training. The example image is given in `./stage1/train/data/`. Download the initialized model from [Baidu drive]() or [Google drive]().
* For Boundary Refinement Network (BRN), using the code in `./stage2/train/` for training. The examples image is given in `./stage2/train/data/`. The training set should be resize to 480 * 480 by the 'nearest' method. Using the code in `./stage2/train/init/generate_train.m` to generate the initialization model.

Test
* Download our trained model from [Baidu drive](https://pan.baidu.com/s/1TqIsKJrRbiQUhOGq1brCDg) or [Google drive](https://drive.google.com/open?id=12uRLj3CnjkLsq4fggJPox-PXh4uuy_FG).
* Run `./stage1/test/test.m` to generate saliency maps of Global Localizaiton Network (GLN). 
* Run `./stage2/test/test.m` to generate saliency maps of Boundary Refinement Network (BRN). 
The saliency maps of GLN will serve as the input of BRN.


## Download

The saliency maps on 10 datasets including ECSSD, PASCAL-S, SOD, SED1, SED2, MSRA, DUT-OMRON, THUR15K, HKU-IS and DUTS 
can be found in the following links.

GLN: [Baidu drive](https://pan.baidu.com/s/1j7c6GJisRJjevHrpE1xiVg) or [Google drive](https://drive.google.com/open?id=1U0F_IypJOt8TsEorHj6EJEvoNJnBou2f).

BRN: [Baidu drive](https://pan.baidu.com/s/1hC2tax6Eo27FxBvbR0VBvg) or [Google drive](https://drive.google.com/open?id=1t3vJjbCgQzcYxpt_2iOc499XPRMwY5JR).
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



