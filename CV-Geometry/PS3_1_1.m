
% Q1.1    

clear all;
   clc;
   
   % Normalized 3d points
   
  x=[1.5706;
     -1.5282;   
   -0.6821;
   0.4124;
    1.2095;
    0.8819;
   -0.9442;
    0.0415;
   -0.7975;
   -0.4329;
   -1.1475;
   -0.5149;
    0.1993;
   -0.4320;
   -0.7481;
    0.8078;
   -0.7605;
    0.3237;
    1.3089;
    1.2323];

y = [ -0.1490; 
       0.9695 ;
     - 1.2856 ;   
     -1.0201;   
      0.2812 ;  
     -0.8481;    
     -1.1583 ;  
      1.3445 ;   
      0.3017 ;  
     -1.4151 ;  
      -0.0772;   
      -1.1784;   
       -0.2854;   
       0.2143;   
      -0.3840;   
      -0.1196;   
      -0.5792;   
        0.7970;    
        0.5786;   
       1.4421];
   
   
   z=[0.2598;
       0.3802;
       0.4078;
       -0.0915;
       -0.1280;
       0.5255;
       -0.3759;
       0.3240;
       -0.0826;
       -0.2774;
       -0.2667;
       -0.1401;
       -0.2114;
       -0.1053;
       -0.2408;
       -0.2631;
       -0.1936;
        0.2170;
       -0.1887;
        0.4506];
             
   u=[1.0486;                              
   -1.6851;                               
   -0.9437;                                
    1.0682;                           
    0.6077;                              
    1.2543;                         
   -0.2709;                           
   -0.4571;                  
   -0.7902;                          
    0.7318;                        
   -1.0580;                          
    0.3464;                          
    0.3137;                      
   -0.4310;             
   -0.4799;                    
    0.6109;                  
   -0.4081;               
   -0.1109;                    
    0.5129;                  
    0.1406];                              
          
     
v=[-0.3645;
    -0.4004;
   -0.4200;
    0.0699; 
   -0.0771;
   -0.6454;
    0.8635;
    -0.3645;
    0.0307;
    0.6382;
    0.3312;
    0.3377;
    0.1189;
    0.0242;
    0.2920;
    0.0830;
    0.2920;
    -0.2992;
    -0.0575;
    -0.4527];


 % Least squares method

 A1= [x(1) y(1) z(1) 1  0    0    0   0 -u(1)*x(1) -u(1)*y(1) -u(1)*z(1);
       
      0    0     0   0 x(1) y(1) z(1) 1 -v(1)*x(1) -v(1)*y(1) -v(1)*z(1)];
  
  B1=[u(1);
      v(1)];
  
 
 for i=2:1:20;
 
 
  A=[x(i) y(i) z(i) 1  0     0    0   0   -u(i)*x(i) -u(i)*y(i) -u(i)*z(i);
       
      0   0     0   0 x(i) y(i) z(i)  1    -v(i)*x(i) -v(i)*y(i) -v(i)*z(i)];  % Concatenating to form formula
     
 A1=vertcat(A1,A);
      
   B=[u(i);
     v(i)];
 
 B1=vertcat(B1,B);


  end
 
 
 
m=A1\B1;
 
 
m1= [m(1) m(2) m(3) m(4);
     m(5) m(6) m(7) m(8);
     m(9) m(10) m(11) 1];
  
  
  
   L=A1*m;
  
% For finding residual
  

   for k=1:20
       
       diff(k)=(L(k).^2)-(B1(k).^2);
       
   end
   
sum1=sum(diff(k));
   
res=sqrt(sum1);
      









