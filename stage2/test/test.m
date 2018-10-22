clc;clear;close all;
inpath='/home/iiau/Desktop/dataset/OMRON/OMRON-Image/'; %image
inpath_sal='/home/iiau/Desktop/noaug/code_cvpr18/stage1/test/OMRON_3_19/'; % saliency map of stage 1

in_dir=dir(inpath);
imgnum=length(in_dir);
% 
% addpath(genpath('/home/wujie/caffe-master/matlab'));
addpath(genpath('/home/iiau/Desktop/wtt/ICCV17_SRM-master/PSPNet/matlab'));
net_model='./deploy.prototxt';
phase='test';
caffe.set_mode_gpu();
caffe.set_device(0);
net_weights='./snapshot/';
in_dir_weights=dir(net_weights);
IMAGE_DIM = 480;

for m=1:length(in_dir_weights)-2
    m
    modelname=in_dir_weights(m+2).name;
    model_name=[net_weights modelname];
    % Initialize a network
    net=caffe.Net(net_model, model_name, phase);

    outpath=['./HKUIS' modelname(15:end-15) '/'];
    mkdir(outpath);

    for i=1:imgnum-2
        i
        imgname=in_dir(i+2).name;
        img_name=[inpath imgname];
        img_name_sal=[inpath_sal imgname(1:end-4) '.png'];        
        out_name=[outpath imgname(1:end-4) '.png'];
        im=imread(img_name);
        im_sal=imread(img_name_sal)./255;
        % resize to fixed input size
        im = single(im);
        im_sal = single(im_sal);            
        [m n k]=size(im);
        % mean BGR pixel
        mean_pix = [104.00699, 116.66877, 122.67892];
        imm = imresize(im, [IMAGE_DIM IMAGE_DIM],'nearest');
        imm_sal = imresize(im_sal, [IMAGE_DIM IMAGE_DIM],'nearest');

        if k==1
            imt(:,:,1)=imm;
            imt(:,:,2)=imm;
            imt(:,:,3)=imm;
        else
            imt=imm;
        end
        im=imt;
        % RGB -> BGR
        im = im(:, :, [3 2 1]);

        % oversample (4 corners, center, and their x-axis flips)
        images = zeros(IMAGE_DIM, IMAGE_DIM, 3, 1, 'single');
        images_sal = zeros(IMAGE_DIM, IMAGE_DIM, 1, 1, 'single');

        images(:,:,1:3,1)=permute(im,[2 1 3]);
        images_sal(:,:,1,1)=permute(imm_sal,[2 1 3]);

        % mean BGR pixel subtraction
        for c = 1:3
            images(:, :, c, :) = images(:, :, c, :) - mean_pix(c);
        end
        input_data = {images};
        input_data_sal = {images_sal};

        % do forward pass to get scores
        scores=net.forward([input_data input_data_sal]);

        temp=scores{1}(:,:,2);
        map=permute(temp,[2,1,3]); 

        map=imresize(map,[m,n],'nearest');
        map=(map-min(map(:)))./(max(map(:))-min(map(:)));
        imwrite(map,out_name,'png');
    end
    caffe.reset_all();
end
