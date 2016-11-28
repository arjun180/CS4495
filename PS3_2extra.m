
% Question 2.4 and Question 2.5
clear all;
clc

Image_b=imread('PS3_b.jpg');
Image_a=imread('PS3_a.jpg');


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



meanu1=sum(u1(:,1))/(20);
meanv1=sum(v1(:,1))/(20);

for p=1:20
    
Xnew(p,:)= round([u1(p,1) v1(p,1)]-[meanu1 meanv1]); % Subtracting mean
end

maxval=max(max(Xnew));   

s=1/maxval;

matrixS=[s 0 0;0 s 0; 0 0 1];

matrixM=[1 0 -1*meanu1;0 1 -1*meanv1;0 0 1];

Ta=matrixS*matrixM;   % finding matrix Ta




meanu2=sum(u2(:,1))/(20);
meanv2=sum(v2(:,1))/(20);


for k=1:20
    
Ynew(k,:)= round([u2(k,1) v2(k,1)]-[meanu2 meanv2]);  % subtracting mean
end

maxval=max(max(Ynew));

s1=1/maxval;

matrixS1=[s1 0 0;0 s1 0; 0 0 1];

matrixM1=[1 0 -1*meanu2;0 1 -1*meanv2;0 0 1];

Tb=matrixS1*matrixM1;  % finding matrix Tb



for i=1:20
    
    
    A_n(i,:)= Ta*[u1(i) v1(i) 1]';
    B_n(i,:)= Tb*[u2(i) v2(i) 1]';


end



u1new=A_n(1:20,1);
v1new=A_n(1:20,2);

u2new=B_n(1:20,1);
v2new=B_n(1:20,2);

    
    
    
    
    
 A1=[u1new(1)*u2new(1) u1new(1)*v2new(1) u1new(1) v1new(1)*u2new(1) v1new(1)*v2new(1) v1new(1) u2new(1) v2new(1)];
 


for i=2:1:20
     
  A=[u1new(i)*u2new(i) u1new(i)*v2new(i) u2new(i) v1new(i)*u2new(i) v1new(i)*v2new(i) v1new(i) u2new(i) v2new(i)];
     
  A1=vertcat(A1,A);
 end


 B=-ones(20,1);
 
 f=A1\B;
 
 f1=[f(1) f(2) f(3);
    f(4) f(5) f(6);
    f(7) f(8)  1];
    
    
   
 
% Single value decomposition

 [U,S,V] = svd(f1);
 
 t=min(S(S~=0));
  
 index=find(S==t);
  
 S(index)=0;
  
 Fhat=(U*S)*V';
 
 F=Tb'*Fhat*Ta;
 
 
 
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

for d=1:20
    
Lb1(d,:)=[u1new(d,1) v1new(d,1) 1]*F;

p1(d,:)=cross(Lb1(d,:),e);

p2(d,:)=cross(Lb1(d,:),f);

p1_nor(d,:)= p1(d,:)/p1(d,3);

p2_nor(d,:)=p2(d,:)/p2(d,3);


line([round(p1_nor(d,1)),round(p2_nor(d,1))],[round(p1_nor(d,2)),round(p2_nor(d,2))],'color','r','linewidth',1);


end

hold off


figure,
hold on
imshow(Image_a)


for m=1:20
    
Lb1(m,:)=[u2(m,1) v2(m,1) 1]*F';

p1(m,:)=cross(Lb1(m,:),e);

p2(m,:)=cross(Lb1(m,:),f);

p1_nor(m,:)= p1(m,:)/p1(m,3);

p2_nor(m,:)= p2(m,:)/p2(m,3);


line([round(p1_nor(m,1)),round(p2_nor(m,1))],[round(p1_nor(m,2)),round(p2_nor(m,2))],'color','r','linewidth',1);


end

hold off


 

