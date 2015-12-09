function Database()   

a0=imread('4-11.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d1=reshape(c0,1,260*360);
a0=imread('4-12.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d2=reshape(c0,1,260*360);
a0=imread('4-13.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d3=reshape(c0,1,260*360);
a0=imread('4-11.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d4=reshape(c0,1,260*360);
a0=imread('4-12.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d5=reshape(c0,1,260*360);
a0=imread('4-13.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d6=reshape(c0,1,260*360);
a0=imread('4-13.jpg');
b0=imcrop(a0,[186 15 259 359]);
c0=rgb2gray(b0);
d7=reshape(c0,1,260*360);

train_bags=cell(2,1);
train_target=cell(2,1);
test_bags=cell(1,1);
test_target=cell(1,1);

train_bags(1)={double(d1)};
train_bags(2)={double(d2)};
test_bags(1)={double(d3)};
train_target(1)={1};
train_target(2)={1};
test_target(1)={1};
end