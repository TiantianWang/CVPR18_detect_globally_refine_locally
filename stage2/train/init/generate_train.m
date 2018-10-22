
%% test
clc;clear;close all;
addpath(genpath('/home/iiau/Desktop/wtt/ICCV17_SRM-master/PSPNet/matlab'));

caffe.set_mode_gpu();
caffe.set_device(0);
% % % 
solver_def_file='./solver.prototxt';

shot_path='snapshot/';
mkdir(shot_path);

resnet = caffe.Solver(solver_def_file);

w1 = eye(25);
w1 = reshape(w1, [5, 5, 1, 25]);
resnet.net.params('data_transpose',1).set_data(w1);
w1 = ones(1, 25);
w1 = reshape(w1, [1, 1, 25, 1]);
resnet.net.params('conv3-prod_sal_sum',1).set_data(w1);
resnet.net.params('conv3-prod_back_sum',1).set_data(w1);
b3 = zeros(25, 1);
b3(13, 1) = 1;
resnet.net.params('conv3',2).set_data(b3);

STR=sprintf('%s%d%s','snapshot_iter_',0,'_init.caffemodel');
resnet.net.save(sprintf([shot_path STR]));
caffe.reset_all()



