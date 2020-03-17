close all
im=imread('Fig6.35(1).jpg');
Gx_mask=[-1 -2 -1;0 0 0;1 2 1];
Gy_mask=[-1 0 1;-2 0 2;-1 0 1];


[msk_im_x]=convolution(Gx_mask,double(im));
[msk_im_y]=convolution(Gy_mask,double(im));
RGB_grad=msk_im_x+msk_im_y;
figure;title('gradient of RGB'); hold on
imshow(uint8(RGB_grad))


R = double(im(:,:,1));
G = double(im(:,:,2));
B = double(im(:,:,3));

[msk_im_x]=convolution(Gx_mask,R);
[msk_im_y]=convolution(Gy_mask,R);
R_grad=msk_im_x+msk_im_y;
figure;title('gradient of R'); hold on
imshow(uint8(R_grad))


[msk_im_x]=convolution(Gx_mask,G);
[msk_im_y]=convolution(Gy_mask,G);
G_grad=msk_im_x+msk_im_y;
figure;title('gradient of G'); hold on
imshow(uint8(G_grad))

[msk_im_x]=convolution(Gx_mask,B);
[msk_im_y]=convolution(Gy_mask,B);
B_grad=msk_im_x+msk_im_y;
figure;title('gradient of B'); hold on
imshow(uint8(B_grad))

% RGB_grad_comb=cat(3,abs(R_grad),abs(G_grad),abs(B_grad));
RGB_grad_comb=R_grad+G_grad+B_grad;
figure;title('addition of the 3 gradient'); hold on
imshow(uint8(RGB_grad))

% diff_RGB=RGB_grad_comb-RGB_grad;
% figure;title('difference'); hold on
% imshow(uint8(diff_RGB))

%%%%%%%%%%%%%%%%%%%%
im=imread('Fig6.35(1).jpg');
r=double(im(:,:,1));
g=double(im(:,:,2));
b=double(im(:,:,3));
Lx=length(r(:,1));
Ly=length(r(1,:));

for i=1:Lx
    for j=1:Ly
        ii=i;
        jj=j;
        if ii==1
            ii=2;
        end
        if jj==1
            jj=2;
        end
        rx=r(ii,jj)-r(ii-1,jj);
        ry=r(ii,jj)-r(ii,jj-1);
        gx=g(ii,jj)-g(ii-1,jj);
        gy=g(ii,jj)-g(ii,jj-1);
        bx=b(ii,jj)-b(ii-1,jj);
        by=b(ii,jj)-b(ii,jj-1);
%% gradient of RGB
        gxx=rx^2+gx^2+bx^2;
        gyy=ry^2+gy^2+by^2;
        gxy=rx*ry+gx*gy+bx*by;

        if gxx~=gyy
            theta=.5*atan(2*gxy/(gxx-gyy));
        else
            theta=pi/4;
        end
        F=(abs(.5*(gxx+gyy)+(gxx-gyy)*cos(2*theta)+2*gxy*sin(2*theta)))^.5;
        LRGB(i,j)=F;
%% Gradient of R
        grxx=rx^2;
        gryy=ry^2;
        grxy=rx*ry;
        if grxx~=gryy
            theta=.5*atan(2*grxy/(grxx-gryy));
        else
            theta=pi/4;
        end
        F=(abs(.5*(grxx+gryy)+(grxx-gryy)*cos(2*theta)+2*grxy*sin(2*theta)))^.5;
        LR(i,j)=F;
%% Gradient of G
        ggxx=gx^2;
        ggyy=gy^2;
        ggxy=gx*gy;
        if ggxx~=ggyy
            theta=.5*atan(2*ggxy/(ggxx-ggyy));
        else
            theta=pi/4;
        end
        F=(abs(.5*(ggxx+ggyy)+(ggxx-ggyy)*cos(2*theta)+2*ggxy*sin(2*theta)))^.5;
        LG(i,j)=F;
 %% Gradient of B       
        gbxx=bx^2;
        gbyy=by^2;
        gbxy=bx*by;
        if gbxx~=gbyy
            theta=.5*atan(2*gbxy/(gbxx-gbyy));
        else
            theta=pi/4;
        end
        F=(abs(.5*(gbxx+gbyy)+(gbxx-gbyy)*cos(2*theta)+2*gbxy*sin(2*theta)))^.5;
        LB(i,j)=F;
    end
end
%% show results
figure;title('Gradient of RGB vector');hold on;
imshow(uint8(LRGB))

figure;title('Gradient of R vector');hold on;
imshow(uint8(LR))
figure;title('Gradient of G vector');hold on;
imshow(uint8(LG))
figure;title('Gradient of B vector');hold on;
imshow(uint8(LB))

Lrgb=(LR+LG+LB);
% % Lrgb=cat(3,abs(R_grad),abs(G_grad),abs(B_grad));
figure;title('Gradient of combining R,B, and G gradient vectors');hold on;
imshow(uint8(Lrgb))

diff_RGB=(RGB_grad_comb-Lrgb);
figure;title('difference');hold on;
imshow(uint8(diff_RGB))