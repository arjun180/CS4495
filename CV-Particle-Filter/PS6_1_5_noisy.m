
%Q1.5
clear all
vr = VideoReader('noisy_debate.avi');
numFrames = get(vr, 'NumberOfFrames');
vidobj=VideoWriter('noisy_debate_final1.avi');
open(vidobj);

shapeInserter=vision.ShapeInserter;

N=100;

Xt=randsample(220:360,N);
Yt=randsample(205:330,N);
 


Xt_check=Xt;
Yt_check=Yt;


for k=1:46

image = rgb2gray(im2double(read(vr,k)));
image2=rgb2gray(im2double(read(vr,1)));
image1= im2double(read(vr,k));

[X Y]=size(image);




if(k==1)
    
 Unew=320;
 Vnew=175;


else   

%Computing MSE of randomly selected particels

for i=1:N

MSE(i)=sum(sum((1/(129*103))*((image2(320:423,175:304)-image((320:423)+Xt(i)-ceil(129/2),(175:304)+Yt(i)-ceil(103/2)))).^2));

end


 
end

%Adding Gaussian noise

if(k~=1)
    
for i=1:N
    
 sigma=0.3;

Pzt_xt(i)=exp(-MSE(i)/(2*(sigma)^2));

end


norm_factor=sum(Pzt_xt);

Pzt_xt=Pzt_xt./(norm_factor);

%Index=find(Pzt_xt==max(Pzt_xt));

[val,Index]=max(Pzt_xt);

Unew=Xt(Index)-ceil(129/2);
Vnew=Yt(Index)-ceil(103/2);

end

% shapeInserter=vision.ShapeInserter;

rectangle=[Unew Vnew 103 129];


frame=step(shapeInserter,image1,rectangle);

writeVideo(vidobj,frame);


%resampling particles


if(k~=1)

A=[Pzt_xt];
Xt1=randsample(Xt,N,'true',A);
Yt1=randsample(Yt,N,'true',A);
end

if(k==28)

   for h=1:N
     
distance(h)=sqrt((Xt_check(h)-Xt1(h)).^2 +(Yt_check(h)-Yt1(h)).^2) ; 
 
end
 
 weighted_sum=sum(sum(distance));
 
 

 
end

end



close(vidobj);

implay('noisy_debate1.avi');



%%%%%%%% Extracting frames%%%%%%%%


K=imread('noisy_debate_46.jpg');

figure,
imshow(K);

hold on 

plot(Xt1,Yt1,'go');

hold off
