clc;clear;close all;
inpath='//home/iiau/Desktop/dataset/OMRON/OMRON-Image/'; %path of input image

in_dir=dir(inpath);
imgnum=length(in_dir);

addpath(genpath('/home/iiau/Desktop/noaug/PSPNet-master-new/matlab'));
net_model='./deploy.prototxt';
phase='test';
caffe.set_mode_gpu();
caffe.set_device(0);
net_weights='./snapshot/';
in_dir_weights=dir(net_weights);
IMAGE_DIM = 384;
IMAGE_DIM2 = 384;
IMAGE_DIM3 = 384;
for m=1:length(in_dir_weights)-2
    m
    modelname=in_dir_weights(m+2).name;
    model_name=[net_weights modelname];
    % Initialize a network
    net=caffe.Net(net_model, model_name, phase);

    % outpath=['./THUR_' modelname(15:end-15) '/'];
    % outpath1=['./THUR_1_' modelname(15:end-15) '/'];
    % outpath2=['./THUR_2_' modelname(15:end-15) '/'];
    outpath3=['./OMRON_3_' modelname(15:end-15) '/'];  %path of output image

    % mkdir(outpath);
    % mkdir(outpath1);
    % mkdir(outpath2);
    mkdir(outpath3);

    for i=1:imgnum-2
        i
        imgname=in_dir(i+2).name;
        img_name=[inpath imgname];
        % out_name=[outpath imgname(1:end-4) '.png'];
        % out_name1=[outpath1 imgname(1:end-4) '.png'];
        % out_name2=[outpath2 imgname(1:end-4) '.png'];

        out_name3=[outpath3 imgname(1:end-4) '.png'];

        % if ~exist(out_name)
        im=imread(img_name);
        % resize to fixed input size
        im = single(im);
        [m n k]=size(im);
        % mean BGR pixel
        % mean_pix = [104.00699, 116.66877, 122.67892];
        % mean_pix=[0 0 0];
        imm = imresize(im, [IMAGE_DIM IMAGE_DIM]);
        % imm2 = imresize(im, [IMAGE_DIM2 IMAGE_DIM2]);
        % imm3 = imresize(im, [IMAGE_DIM3 IMAGE_DIM3]);

        if k==1
            imt(:,:,1)=imm;
            imt(:,:,2)=imm;
            imt(:,:,3)=imm;

            % imt2(:,:,1)=imm2;
            % imt2(:,:,2)=imm2;
            % imt2(:,:,3)=imm2;
            %                 
            % imt3(:,:,1)=imm3;
            % imt3(:,:,2)=imm3;
            % imt3(:,:,3)=imm3;
        else
            imt=imm;
            % imt2=imm2;
            % imt3=imm3;

        end
        im=imt;
        % im2=imt2;
        % im3=imt3;
        % RGB -> BGR
        im = im(:, :, [3 2 1]);
        % im2 = im2(:, :, [3 2 1]);
        % im3 = im3(:, :, [3 2 1]);

        % oversample (4 corners, center, and their x-axis flips)
        images = zeros(IMAGE_DIM, IMAGE_DIM, 3, 1, 'single');
        images(:,:,1:3,1)=permute(im,[2 1 3]);

        % images2 = zeros(IMAGE_DIM2, IMAGE_DIM2, 3, 1, 'single');
        % images2(:,:,1:3,1)=permute(im2,[2 1 3]);
        %             
        % images3 = zeros(IMAGE_DIM3, IMAGE_DIM3, 3, 1, 'single');
        % images3(:,:,1:3,1)=permute(im3,[2 1 3]);
        % mean BGR pixel subtraction
        for c = 1:3
            images(:, :, c, :) = images(:, :, c, :) ;
            % images2(:, :, c, :) = images2(:, :, c, :) ;
            % images3(:, :, c, :) = images3(:, :, c, :) ;                
        end
        input_data =[ {images},{images},{images}];

        % do forward pass to get scores
        % scores are now Width x Height x (Channels x 2) x Num

        scores=net.forward(input_data);

        % temp1=scores{1}(:,:,2);
        % temp2=scores{2}(:,:,2);
        temp3=scores{3}(:,:,2);

        % map1=permute(temp1,[2,1,3]); 
        % map2=permute(temp2,[2,1,3]); 
        map3=permute(temp3,[2,1,3]); 
        % 
        % map1=imresize(map1,[m,n]);
        % map1=(map1-min(map1(:)))./(max(map1(:))-min(map1(:)));
        % map2=imresize(map2,[m,n]);
        % map2=(map2-min(map2(:)))./(max(map2(:))-min(map2(:)));
        map3=imresize(map3,[m,n]);
        map3=(map3-min(map3(:)))./(max(map3(:))-min(map3(:)));

        % imwrite(map1,out_name1,'png');
        %imwrite(map2,out_name2,'png');
        imwrite(map3,out_name3,'png');
    end
    caffe.reset_all();
end
