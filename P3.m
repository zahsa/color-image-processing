close all
clear all
RGB=imread('Fig6.35(5).jpg');
[rows, cols, colors]= size(RGB);
R = (RGB(:,:,1));
G = (RGB(:,:,2));
B = (RGB(:,:,3));
figure;title('Red');hold on;imshow(uint8(R))
figure;title('Green');hold on;imshow(uint8(G))
figure;title('Blue');hold on;imshow(uint8(B))

%% RGB equilization
[e_freq_R,R_equi]=equalization(R);
[e_freq_G,G_equi]=equalization(G);
[e_freq_B,B_equi]=equalization(B);
RGB_RGB_equi=cat(3,R_equi,G_equi,B_equi);

figure;title('Red Histogram');hold on;bar(e_freq_R);
figure;title('equi-Red');hold on;imshow(uint8(R_equi));
figure;title('Green Histogram');hold on;bar(e_freq_G);
figure;title('equi-Green');hold on;imshow(uint8(G_equi));
figure;title('Blue Histogram');hold on;bar(e_freq_B);
figure;title('equi-Blue');hold on;imshow(uint8(B_equi));

figure;title('RGB from combination of equi-R,equi-G,equi-B');hold on;imshow(uint8(RGB_RGB_equi));
%% convert RGB2HSI

R_norm = double(R)/256;
G_norm = double(G)/256;
B_norm = double(B)/256;

a=0.5*((R_norm-G_norm)+(R_norm-B_norm));
b=sqrt((R_norm-G_norm).^2+(R_norm-B_norm).*(G_norm-B_norm));
theta=acos(a./(b));

S=1-3*min(min(R_norm,G_norm),B_norm)./(R_norm+G_norm+B_norm);
I=(1/3)*(R_norm+G_norm+B_norm);

H=theta;
H(B_norm<=G_norm)=theta(B_norm<=G_norm);
H(B_norm>G_norm)=2*pi-theta(B_norm>G_norm);
H=H/(2*pi);

figure;title('Hue');hold on;imshow((H))
figure;title('Saturation');hold on;imshow(S)
figure;title('Intensity');hold on;imshow(I)

%% I equilization
%%%??? [e_freq_I,e_img]=equalization(round(I*100));
[e_freq_I,I_equi]=equalization(fix(I*255));

figure;title('equi-Intensity');hold on;bar(e_freq_I);
figure;title('equi-Intensity');hold on;imshow(uint8(I_equi));
 
%% convert HSI2RGB
I=(I_equi/255);
[M,N]=size(I);

RR=zeros(M,N);
GG=zeros(M,N);
BB=zeros(M,N);
H=H*(2*pi);
% 0 <= theta <= 120=2*pi/3 ;
i=find((0<=H)&(H<2*pi/3));
BB(i)=I(i).*(1-S(i));
RR(i)=I(i).*(1+S(i).*cos(H(i))./cos(pi/3-H(i)));
GG(i)=3*I(i)-(RR(i)+BB(i));

% 2*pi/3 <= H <= 4*pi/3 ;
i=find((2*pi/3<=H)&(H<4*pi/3));
RR(i)=I(i).*(1-S(i));
GG(i)=I(i).*(1+S(i).*cos(H(i)-2*pi/3)./cos(pi-H(i)));
BB(i)=3*I(i)-(RR(i)+GG(i));

% 4*pi/3 <= H <= 2*pi ;
i=find((4*pi/3<=H)&(H<=2*pi));
GG(i)=I(i).*(1-S(i));
BB(i)=I(i).*(1+S(i).*cos(H(i)-4*pi/3)./cos(5*pi/3-H(i)));
RR(i)=3*I(i)-(GG(i)+BB(i));

RGB_HSI_RGB=cat(3,RR,GG,BB);


% figure;title('converted Red');hold on;imshow(double(RR))
% figure;title('converted Green');hold on;imshow(double(GG))
% figure;title('converted Blue');hold on;imshow(double(BB))
% 
figure;title('RGB from combination of converted R,G,B');hold on;imshow((RGB_HSI_RGB));

diff=(RGB_RGB_equi/255)-(RGB_HSI_RGB);
figure;title('difference');hold on;imshow((diff));
