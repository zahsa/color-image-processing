clear all
img=imread('Fig1.10(4).jpg');
[rows, cols, colors]= size(img);

freq=zeros(256,1);
for i=1:rows
    for j=1:cols
          freq(img(i,j)+1)=freq(img(i,j)+1)+1;
    end
end
figure
title('histogram')
hold on
bar(freq)

thresh=20;

filt_im_R=img;
filt_im_G=img;
filt_im_B=img;


filt_im_R(img<=thresh)=255;
filt_im_G(img<=thresh)=255;
 

yel_im=cat(3,filt_im_R,filt_im_G,filt_im_B);
figure
title('yellow river')
hold on
imshow(yel_im)