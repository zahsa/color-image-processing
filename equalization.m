function [e_freq,e_img]=equalization(img)
%% histogram
[rows, cols, colors]= size(img);
freq=zeros(rows*cols,1);
for i=1:rows
    for j=1:cols
          freq(img(i,j)+1)=freq((img(i,j))+1)+1;
    end
end
% bar(freq)
%% histo equalization
cumFreq=cumsum(freq);
eq_histo=round(255*((cumFreq)-min(cumFreq))/(rows*cols-min(cumFreq))); 
% eq_histo=round(cumFreq/cumFreq(256)*255);

e_img=[];
for i=1:rows
    for j=1:cols
        e_img(i,j)=eq_histo(img(i,j)+1);
    end
end

img=e_img;
[rows, cols, colors]= size(img);
e_freq=zeros(256,1);
for i=1:rows
    for j=1:cols
          e_freq(img(i,j)+1)=e_freq(img(i,j)+1)+1;
    end
end
% bar(e_freq)

