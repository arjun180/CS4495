% Problem Set 2 Question 2 
%Shift from Left to Right

ImgLeft=im2double(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/leftTest.png'));
ImgRight= im2double(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/rightTest.png'));

ImgLeft=imresize(ImgLeft,[128 128]);
ImgRight=imresize(ImgRight,[128 128]);

[rows cols]= size(ImgLeft);
[tplrows tplcols]= size(ImgRight);



win=5;
 for m=1:128-win+1
     
    
    
    for n=1:128-win+1
        for k = 1:128-win+1
            
          
            
            for i=1:win-1
                for j=1:win-1
            
            
                     sum1(i,j)=(ImgRight(i+m,j+n)- ImgLeft(i+m,j+k)).^2;
            
                end
            end
           
            
       ssd(k)=sum(sum(sum1));
        
    
       
    if(ssd(k))==0
        
    else
          
          ssd(k)=100;
    end
     
     
         
         
     end
    
        
    ssdnew(m,n)=max(find(ssd==min(ssd(:))));
    
    end
    
    end
     
    
    
     
  
        

 
  for m=1:118
        for n= 1:118
           
           disp(m,n)=ssdnew(m,n)-n;
       end
  end
  
  figure(1)
  imshow(disp,[-10 75]);
  
  figure(2)
  surf((double(disp)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')

   
      
 