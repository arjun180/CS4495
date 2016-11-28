
%Probelm Set 2 Question 3 Gaussian noise

%Left to Right


ImgLeft=im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-L.png')));
ImgRight= im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-R.png')));

ImgLeft=imresize(ImgLeft,[256 256]);
ImgRight=imresize(ImgRight,[256 256]);

Imgl=imnoise(ImgLeft,'gaussian',0,0.01);


Imgr=imnoise(ImgLeft,'gaussian',0,0.01);







[rows cols]= size(Imgl);
[tplrows tplcols]= size(Imgr);


disp=zeros(256,256);
ssdnew=zeros(256,256);






win=7;

 for m=1:256-win+1
     
    
    
    for n=1:256-win+1
        
        for k = 1:256-win+1
            
          
            
            for i=1:win-1
                for j=1:win-1
            
            
                     sum1(i,j)=(Imgr(i+m,j+n)- Imgl(i+m,j+k)).^2;
            
                end
            end
           
            
       ssd(k)=sum(sum(sum1));
        
%      
     
         
         
     end
    
        
        ssdnew(m,n)=min(find(ssd==min(ssd(:))));
    
    end
    
    end
     
    
    
     
  
        

 
 for m=1:254
         for n= 1:254
            
            disp(m,n)=ssdnew(m,n)-n;
        end
   end
    
    figure(1)
    imshow(disp,[-140 40]);
    
     figure(2)
   surf((double(disp)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')

   
      