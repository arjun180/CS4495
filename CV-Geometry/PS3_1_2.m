

% Question1.2 (It has 3 parts: best_matrix.m, cam_Centre.m and avg_min.m)
% Function to compute the min averge rsidual 


function [Avg_min] = avg_min(k)


x=[312.747;309.140; 305.796;307.694;310.149;311.937;311.202;307.106;309.317;307.435;308.253;306.650;308.069;309.671;308.255; 307.546;311.036;307.518;309.950;312.160;311.988];           

y=[309.140;311.649;311.649;312.358;307.186;310.105;307.572;306.876;312.490;310.151;306.300;309.301;306.831;308.834;309.955;308.613;309.206;308.175;311.262;310.772;312.709];
   
z=[30.086;
 30.356;
 30.418;
 29.298;
 29.216;
 30.682;
 28.660;
 30.230;
 29.318;
 28.881;
 28.905;
 29.189;
 29.029;
 29.267;
 28.963;
 28.913;
 29.069;
 29.990;
 29.080;
 30.514];  


u=[731;  
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

v=[238;
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


% least squares method

for L=1:10


u1=randsample(u,k);

for i=1:k
    
    index(i)=find(u==u1(i));
    v1(i)=(v(index(i)));
    x1(i)=(x(index(i)));
    y1(i)=(y(index(i)));
    z1(i)=(y(index(i)));
    
    
end


v1=v1.';
x1=x1.';
y1=y1.';
z1=z1.';


A1= [x1(1) y1(1) z1(1) 1  0    0    0   0 -u1(1)*x1(1) -u1(1)*y1(1) -u1(1)*z1(1);
       
      0    0     0   0 x1(1) y1(1) z1(1) 1 -v1(1)*x1(1) -v1(1)*y1(1) -v1(1)*z1(1)];
  
B1=[u1(1);
    v1(1)];


for i=2:1:k;
 
 
  A=[x1(i) y1(i) z1(i) 1  0     0    0   0   -u1(i)*x1(i) -u1(i)*y1(i) -u1(i)*z1(i);
       
      0   0     0   0 x1(i) y1(i) z1(i)  1    -v1(i)*x1(i) -v1(i)*y1(i) -v1(i)*z1(i)];
     
  A1=vertcat(A1,A);
      
   B=[u1(i);
     v1(i)];
 
 B1=vertcat(B1,B);


 end

  
 m(1:11,1,L)=A1\B1;
 
 
 
 % Change made here
 
 m1(1:3,1:4,L)=[m(1,1,L) m(2,1,L) m(3,1,L) m(4,1,L);
              m(5,1,L) m(6,1,L) m(7,1,L) m(8,1,L);
              m(9,1,L) m(10,1,L) m(11,1,L) 1];
          
          
          
          
          
 % Finding the next 4 random numbers  
  



uk=setdiff(u,u1);

k1=4;

u2=randsample(uk,k1);
  
  
for i1=1:k1
    
    index(i1)=find(u==u2(i1));
    v2(i1)=(v(index(i1)));
    x2(i1)=(x(index(i1)));
    y2(i1)=(y(index(i1)));
    z2(i1)=(y(index(i1)));
    
    
end 


v2=v2.';
x2=x2.';
y2=y2.';
z2=z2.';


 A2= [x2(1) y2(1) z2(1) 1  0    0    0   0 -u2(1)*x2(1) -u2(1)*y2(1) -u2(1)*z2(1);
       
      0    0     0   0 x2(1) y2(1) z2(1) 1 -v2(1)*x2(1) -v2(1)*y2(1) -v2(1)*z2(1)];
  
  
 B2=[u2(1);
     v2(1)]; 
 
 
 for i=2:1:k1;
 
 
  A=[x2(i) y2(i) z2(i) 1  0     0    0   0   -u2(i)*x2(i) -u2(i)*y2(i) -u2(i)*z2(i);
       
      0   0     0   0 x2(i) y2(i) z2(i)  1    -v2(i)*x2(i) -v2(i)*y2(i) -v2(i)*z2(i)];
     
  A2=vertcat(A2,A);
      
   B=[u1(i);
     v1(i)];
 
 B2=vertcat(B2,B);

 end

 
 
 mn(1:11,1,L)=A2\B2;
 
 
 
 %Change made here

 mn1(1:3,1:4,L)= [mn(1,1,L) mn(2,1,L) mn(3,1,L) mn(4,1,L);
                  mn(5,1,L) mn(6,1,L) mn(7,1,L) mn(8,1,L);
                  mn(9,1,L) mn(10,1,L) mn(11,1,L) 1];
          
 
 P(:,:,L)=A2*mn(:,:,L);

  


 %For finding residual
  
 
 Diff_P(1,1,L)= (P(1,1,L).^2)-(B2(1,1).^2);
               
Diff_P(2,1,L)= (P(2,1,L).^2)-(B2(2,1).^2);
               
Diff_P(3,1,L)= (P(3,1,L).^2)-(B2(3,1).^2);
               
Diff_P(4,1,L)= (P(4,1,L).^2)-(B2(4,1).^2);
               
Diff_P(5,1,L)= (P(5,1,L).^2)-(B2(5,1).^2);
               
Diff_P(6,1,L)= (P(6,1,L).^2)-(B2(6,1).^2);
              
Diff_P(7,1,L)= (P(7,1,L).^2)-(B2(7,1).^2);
               
Diff_P(8,1,L)= (P(8,1,L).^2)-(B2(8,1).^2)
 

  
sum1(L)=sum(Diff_P(:,:,L));

Avg_residual(L)= sqrt(sum1(L)/4);


end

Avg_min=min(Avg_residual(:));

index_min=find(Avg_residual==Avg_min);

Best_matrix=m1(1:3,1:4,index_min);


end