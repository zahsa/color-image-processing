close all
clear all
RGB=imread('Fig6.30(1).jpg');
%% RGB
R = (RGB(:,:,1));
G = (RGB(:,:,2));
B = (RGB(:,:,3));

figure
title('Red')
hold on
imshow(uint8(R))
figure
title('Blue')
hold on
imshow(uint8(G))
figure
title('Green')
hold on
imshow(uint8(B))


%% HSI
RGB=double(RGB);
R_norm = (RGB(:,:,1))/256;
G_norm = (RGB(:,:,2))/256;
B_norm = (RGB(:,:,3))/256;

a=0.5*((R_norm-G_norm)+(R_norm-B_norm));
b=sqrt((R_norm-G_norm).^2+(R_norm-B_norm).*(G_norm-B_norm));
theta=acos(a./(b));


S=1-3*min(min(R_norm,G_norm),B_norm)./(R_norm+G_norm+B_norm);
I=(1/3)*(R_norm+G_norm+B_norm);

H=theta;
H(B_norm<=G_norm)=theta(B_norm<=G_norm);
H(B_norm>G_norm)=2*pi-theta(B_norm>G_norm);
H=H/(2*pi);


figure
title('Hue')
hold on
imshow((H))
figure
title('Saturation')
hold on
imshow(S)
figure
title('Intensity')
hold on
imshow(I)

%% XYZ

if R_norm>0.04045
    R_norm=((R_norm+0.055)/1.055)^2.4;
else
    R_norm=R_norm/12.92;
end

if G_norm>0.04045
    G_norm=((G_norm+0.055)/1.055)^2.4;
else
    G_norm=G_norm/12.92;
end

if B_norm>0.04045
    B_norm=((B_norm+0.055)/1.055)^2.4;
else
    B_norm=B_norm/12.92;
end


X=0.4124*R_norm+0.3175*G_norm+0.1804*B_norm;
Y=0.2126*R_norm+0.7151*G_norm+0.0721*B_norm;
Z=0.0193*R_norm+0.1191*G_norm+0.9502*B_norm;

figure
title('X')
hold on
imshow(X/max(max(X)))
figure
title('Y')
hold on
imshow(Y/max(max(Y)))
figure
title('Z')
hold on
imshow(Z/max(max(Z)))

%% Lab
Xw=94.82; 
Yw=100;
Zw=107.38; 

q=Y/Yw;
if q>0.008856
    hy=q^(1/3);
else
    hy=7.787*q+16/116;
end
L_star=116*hy-16;

q=X/Xw;
if q>0.008856
    hx=q^(1/3);
else
    hx=7.787*q+16/116;
end
a_star=500*(hx-hy);

q=Z/Zw;
if q>0.008856
    hz=q^(1/3);
else
    hz=7.787*q+16/116;
end
b_star=200*(hy-hz);

figure
title('L*')
hold on
imshow((L_star))
figure
title('a*')
hold on
imshow(a_star)
figure
title('b*')
hold on
imshow(b_star)
