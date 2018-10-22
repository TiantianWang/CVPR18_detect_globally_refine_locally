#!/usr/bin/env sh
/home/wtt/Desktop/PSPNet-master-new/.build_release/tools/caffe train --solver=/media/wtt/Experiment/resnet50/noaug/camera_ready/final2/recurrent-2/solver.prototxt --weights=/media/wtt/Experiment/fcn.berkeleyvision.org-master/resnet/cnn-models-master/ResNet_preact/ResNet50_cvgj/resnet50_cvgj_iter_320000.caffemodel --gpu=0

/home/wang/Desktop/PSPNet-master/.build_release/tools/caffe train --solver=/home/wang/Documents/deep_saliency/fcn.berkeleyvision.org-master/resnet/attention/vgg19-nodilation/v1-spatial-nobn-multiscale-downup-nobias/solver.prototxt --snapshot=/home/wang/Documents/deep_saliency/fcn.berkeleyvision.org-master/resnet/attention/vgg19-nodilation/v1-spatial-nobn-multiscale-downup-nobias/snapshot/snapshot_iter_66820.solverstate --gpu=0
