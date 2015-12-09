function [train_bags,testbags,train_target,test_target]=CreateDatabase()
train_bags=cell(200,7);
test_bags=cell(200,7);
train_target=cell(200,7);
test_target=cell(200,7);
str='/FEI/'
for i=1:200
for j=1:14
str1=int2str(i)
if (mod(j,2))
str2=int2str(j);
if (j<10)
str=strcat(str1,'-0',str2,'.jpg');
else
str=strcat(str,str1,'-',str2,'.jpg');
end
a=imread(str);
b=imcrop(a,[186 15 259 359]);
c=rgb2gray(b);
d=reshape(c,1,260*360);
e=double(d)/256;
train_bags(i,ceil(j/2))={e};
train_target(i,ceil(j/2))={1};
else
str2=int2str(j);
if (j<10)
str=strcat(str1,'-0',str2,'.jpg');
else
str=strcat(str1,'-',str2,'.jpg');
end
a=imread(str);
b=imcrop(a,[186 15 259 359]);
c=rgb2gray(b);
d=reshape(c,1,260*360);
e=double(d)/256;
test_bags(i,j/2)={e};
test_target(i,(j/2))={1};
%f=reshape(e,360,260);
%imshow(f);
end
end
end

end