clc;clear;close all;
inpath='/home/wang/Documents/datasets/datasets/ECCSD/';
outpath='./ECCSD10/';
mkdir(outpath);
in_dir=dir(inpath);
imgnum=length(in_dir);
% 
% addpath(genpath('/home/wujie/caffe-master/matlab'));
addpath(genpath('/home/wang/Desktop/PSPNet-master/matlab'));

net_model='./deploy.prototxt';
net_weights='./snapshot/snapshot_iter_100000.caffemodel';
phase='test';
caffe.set_mode_gpu();
caffe.set_device(0);
% Initialize a network
net=caffe.Net(net_model, net_weights, phase);

IMAGE_DIM = 393;

for i=1:imgnum-2
    i
    imgname=in_dir(i+2).name;
    img_name=[inpath imgname];
    out_name=[outpath imgname(1:end-4) '.png'];
%     if ~exist(out_name)
        im=imread(img_name);
        % resize to fixed input size
        im = single(im);
       [m n k]=size(im);
        % mean BGR pixel
        mean_pix = [104.00699, 116.66877, 122.67892];
%         mean_pix=[0 0 0];
        im = imresize(im, [IMAGE_DIM IMAGE_DIM]);

        % RGB -> BGR
        im = im(:, :, [3 2 1]);

        % oversample (4 corners, center, and their x-axis flips)
        images = zeros(IMAGE_DIM, IMAGE_DIM, 3, 1, 'single');
        images(:,:,1:3,1)=permute(im,[2 1 3]);

        % mean BGR pixel subtraction
        for c = 1:3
        images(:, :, c, :) = images(:, :, c, :) - mean_pix(c);
        end
        input_data = {images};

        % do forward pass to get scores
        % scores are now Width x Height x (Channels x 2) x Num
        %     tic;
        scores=net.forward(input_data);
        %scores = caffe('forward', input_data);
        %     toc;
        temp=scores{1}(:,:,2);
        map=permute(temp,[2,1,3]); 
%         map(map<0)=0;
%         map=double(medfilt2(map,[8,8]));
        map=imresize(map,[m,n]);
        map=(map-min(map(:)))./(max(map(:))-min(map(:)));
%         map=uint8(map*255);
        imwrite(map,out_name,'png');
%     end
end