
% Question 2.3 

clear all;
clc

Image_b=(imread('PS3_b.jpg'));
Image_a=(imread('PS3_a.jpg'));


u1=[880;  
 43;  
270;  
886;  
745;  
943;  
476;  
419;  
317;  
783;  
235;  
665;  
655;  
427;  
412;  
746;  
434;  
525;  
716;  
602];



 v1=[214;
     203;
  197;
  347;
  302;
  128;
  590;
  214;
  335;
  521;
  427;
  429;
  362;
  333;
  415;
  351;
  415;
  234;
  308;
  187];



u2=[731;  
22;   
204;  
903; 
635;  
867;  
958;  
328;  
426;  
1064; 
480;  
964;  
695;  
505;  
645;  
692;  
712;  
465;  
591;  
447];



 v2=[238;
   248;
  230;
  342;
  316;
  177;
  572;
  244;
  386;
  470;
  495;
  419;
  374;
  372;
  452;
  359;
  444;
  263;
  324;
  213];


A1=[u1(1)*u2(1) u1(1)*v2(1) u1(1) v1(1)*u2(1) v1(1)*v2(1) v1(1) u2(1) v2(1)];
 


for i=2:1:20
    
    
    A=[u1(i)*u2(i) u1(i)*v2(i) u2(i) v1(i)*u2(i) v1(i)*v2(i) v1(i) u2(i) v2(i)];
    
    A1=vertcat(A1,A);
end


B=-ones(20,1);

f=A1\B;

f1=[f(1) f(2) f(3);
   f(4) f(5) f(6);
   f(7) f(8)  1];
    







%SIngular value decomposition

[U,S,V] = svd(f1);

t=min(S(S~=0));
 
index=find(S==t);
 
S(index)=0;
 
Fhat=(U*S)*V';


[h w]=size(Image_b);

Pul=[0 0 1];
Pbl=[0 h 1];
Pur=[1072 0 1];
Pbr=[1072 h 1];

e=cross(Pul,Pbl);
f=cross(Pur,Pbr);

figure,
hold on
imshow(Image_b);

for t=1:20
    
Lb1(t,:)=[u1(t,1) v1(t,1) 1]*Fhat;

p1(t,:)=cross(Lb1(t,:),e);

p2(t,:)=cross(Lb1(t,:),f);

p1_nor(t,:)= p1(t,:)/p1(t,3);

p2_nor(t,:)=p2(t,:)/p2(t,3);


line([round(p1_nor(t,1)),round(p2_nor(t,1))],[round(p1_nor(t,2)),round(p2_nor(t,2))],'color','r','linewidth',1);


end

hold off




figure,
hold on
imshow(Image_a)


for k=1:20
    
Lb1(k,:)=[u2(k,1) v2(k,1) 1]*Fhat';

p1(k,:)=cross(Lb1(k,:),e);

p2(k,:)=cross(Lb1(k,:),f);

p1_nor(k,:)= p1(k,:)/p1(k,3);

p2_nor(k,:)=p2(k,:)/p2(k,3);


line([round(p1_nor(k,1)),round(p2_nor(k,1))],[round(p1_nor(k,2)),round(p2_nor(k,2))],'color','r','linewidth',1);


end

hold off






