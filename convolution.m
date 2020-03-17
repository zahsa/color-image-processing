% function [new_img,img_org]=convolution(mask,img)
function [new_img]=convolution(mask,img)
% mask=[1 1 1;1 -8 1;1 1 1];

% mask=[-1 -1 -1 ;-1 8 -1; -1 -1 -1];
% mask=[0 -1 0;-1 4 -1;0 -1 0];

% img=imread('Fig3.40(a).jpg');

msk_size=size(mask);
img_size=size(img);

% a=floor(msk_size(1)/2);
% b=floor(msk_size(2)/2);

a=(msk_size(1)-1)/2;
b=(msk_size(2)-1)/2;

sc1=ceil(msk_size(1)/2);
sc2=ceil(msk_size(2)/2);

% sc1=floor(msk_size(1)/2)+1;
% sc2=floor(msk_size(2)/2)+1;

% new_img=zeros(img_size);

for x=1:img_size(1)
    for y=1:img_size(2)
        sigma=0;
        for s=-a:a
            for t=-b:b
                if x+s>0 && y+t>0 && x+s<=img_size(1) && y+t<=img_size(2)
%                 new_img(x,y)=new_img(x,y)+img(x+s,y+t)*mask(s+sc1,t+sc2);
                  sigma=sigma+double(img(x+s,y+t))*mask(s+sc1,t+sc2);
                end
            end
        end
%         img_org(x,y)=sigma;
        new_img(x,y)=((sigma));
    end
end

% imshow(new_img)
% figure
% enhanced_img=img-new_img;
% max(max(new_img))
% scaled_img=new_img*round((255/max(max(new_img))));
% imshow(scaled_img)


