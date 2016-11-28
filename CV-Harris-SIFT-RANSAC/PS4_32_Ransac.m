% Q3.2 Ransac using similarity transform


% Finding harris corner
clear all;

I=im2double(imread('simA.jpg'));

I1=single(imread('simA.jpg'));

H=fspecial('gaussian',[3 3],1);

I_blur=imfilter(I,H,'replicate');
 
%figure,imshow(I_blur);

[rows cols]=size(I_blur);


[Ix Iy]=imgradientxy(I_blur);

% figure,imshow(Ix);
% 
% figure,imshow(Iy);


I_adjoin=[Ix Iy];

r=1;
w=1;
%figure,imshow(I_adjoin);



R=zeros(480,640);



for i=2:(rows-1)
    
    
for j=2:(cols-1)


w1(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)).^2)));    
  
w2(i,j)=sum(sum(w.*(Iy((i-r):(i+r),(j-r):(j+r)).^2)));       
        
w3(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)))*(Iy((i-r):(i+r),(j-r):(j+r)))));
 

M=[w1(i,j) w3(i,j);w3(i,j) w2(i,j)];

 
R(i,j)=det(M)-(0.4)*trace((M)^2);




end
end

%figure,
%imshow(R,[min(min(R)) max(max(R))]);



for i=2:(rows-1)
    
    for j=2:(cols-1)
        

 
   if(R(i,j)~=max(max(R(i-1:i+1,j-1:j+1))))  
 
       
       R(i,j)=0;
       
end
end
  
end


threshold=0.25;


for i=1:(rows)
    
for j=1:(cols)    

if(R(i,j)<threshold)
    
    R(i,j)=0;
    
   end


end



end


[Xp Yp]=find(R>0);



% SIFT Implementation for first image

for i=1:rows
    
    
    for j=1:cols
        

     angle(i,j)=atan2(Iy(i,j),Ix(i,j));   
        
        
    end
end



figure(1)

imshow('simA.jpg');

hold on
    
for i=1:size(Xp,1)
    
Z=[Yp(i);Xp(i)];

d=angle(Xp(i),Yp(i));


F_in(1:4,i)=[Z;3;d];



h=vl_plotframe(F_in(1:4,i));
 
set(h,'linewidth',1);

end

hold off


[F_out,D_out]=vl_sift(I1,'frames',F_in);















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Implementation on second image   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




Ib=im2double(imread('simB.jpg'));

I1b=single(imread('simB.jpg'));

H1=fspecial('gaussian',[3 3],1);

I_blurb=imfilter(Ib,H1,'replicate');
 


[rows1 cols1]=size(I_blurb);


[Ixb Iyb]=imgradientxy(I_blurb);



r1=1;
w1=1;




R1=zeros(480,640);



for i=2:(rows1-1)
    
    
for j=2:(cols1-1)


w11(i,j)=sum(sum(w1.*(Ixb((i-r1):(i+r1),(j-r1):(j+r1)).^2)));    
  
w22(i,j)=sum(sum(w1.*(Iyb((i-r1):(i+r1),(j-r1):(j+r1)).^2)));       
        
w33(i,j)=sum(sum(w1.*(Ixb((i-r1):(i+r1),(j-r1):(j+r1)))*(Iyb((i-r1):(i+r1),(j-r1):(j+r1)))));
 

M1=[w11(i,j) w33(i,j);w33(i,j) w22(i,j)];

 
R1(i,j)=det(M1)-(0.4)*trace((M1)^2);




end
end





for i=2:(rows1-1)
    
    for j=2:(cols1-1)
        

 
   if(R1(i,j)~=max(max(R1(i-1:i+1,j-1:j+1))))  
 
       
       R1(i,j)=0;
       
end
end
  
end


threshold=0.25;


for i=1:(rows1)
    
for j=1:(cols1)    

if(R1(i,j)<threshold)
    
    R1(i,j)=0;
    
   end


end



end


[Xpb Ypb]=find(R1>0);




% SIFT Implementation for second image

for i=1:rows1
    
    
    for j=1:cols1
        

     angle(i,j)=atan2(Iyb(i,j),Ixb(i,j));   
        
        
    end
end



figure(2)

imshow('simB.jpg');

hold on
    
for i=1:size(Xpb,1)
    
Z1=[Ypb(i);Xpb(i)];

d1=angle(Xpb(i),Ypb(i));


F_in1(1:4,i)=[Z1;3;d1];

h1=vl_plotframe(F_in1(1:4,i));
 
set(h1,'linewidth',1);

end

hold off


[F_outb,D_outb]=vl_sift(I1b,'frames',F_in1);


[M_ubc,S_ubc] = vl_ubcmatch(D_out,D_outb);

 


for i=1:size(M_ubc,2)
    
ka(1:4,i)=F_out(:,M_ubc(1,i));    

kb(1:4,i)=F_outb(:,M_ubc(2,i));




end

%%% Computing Similarity transform and then consensus






k=1:size(M_ubc,2); % Depending on the number of matches

m=randsample(k,2); % taking 2 random samples

e=[m];


u1(1:4,1)=ka(1:4,e(1)); % computing u for simA

v1(1:4,1)=ka(1:4,e(2)); % computing v for simA


u2(1:4,1)=kb(1:4,e(1)); % Computing u' for simA

v2(1:4,1)=kb(1:4,e(2)); % Computing v' for simB


A=[u1(1:4,1) -v1(1:4,1) ones(4,1) zeros(4,1);v1(1:4,1) u1(1:4,1) zeros(4,1) ones(4,1)];  %% Computing similarity transform
                                                                                        %%[ u -v 1 0; v u 0 1][a;b;c;d]=[u';v']

Y=[u2(1:4,1);v2(1:4,1)];

X=A\Y; % Finding a,b,c,d using least squares method

Y1=A*X;

u2_new=Y1(1:4,1);% Computing new u'

v2_new=Y1(5:8,1);% COmputing new v'


distance_offset= sum(sqrt((u2_new-u1).^2 + (v2_new-v1).^2));  % Computing distance



for i=1:size(M_ubc,2)
    
    d_offset=(ka(1:4,i)-kb(1:4,i)).^2;
    
    d_offset(i)=sum(sqrt(d_offset));
    
    
    trans(i)= abs(distance_offset-d_offset(i));
    
    
end


tolerance=20;
 
index_offset=find(trans>tolerance);  % Finding index for consesnus set
 
 consensus_set=length(index_offset);
 
 consesnus_percentage=((consensus_set)/(size(M_ubc,2)))*(100); % Consesnus percentage
 
 
 D=[index_offset];
 
 
 
 %%% Computing best plot%%%%%
 
imageadjoin(:,1:640) = I;
imageadjoin(:,641:1280) =Ib;

figure(3)
imshow(imageadjoin);

hold on
 
for i=1:(consensus_set)
    
ka=F_out(:,M_ubc(1,D(i)));    

kb=F_outb(:,M_ubc(2,D(i)));

plot([ka(1,1),(kb(1,1)+640)],[ka(2,1),kb(2,1)]);

 end

hold off















