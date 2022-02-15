function [collides] = collisionCheck(obstacle,X,Y)

disp("collisionCheck called")

collides = false
% %% make a frame
%     xlim([0  16]);
%     ylim([0  16]);
%      axis square
% %% show a circle
%     viscircles([4,4],2);
% %% test points
%     x =[5,0,6,0,0,2];
%     y =[0,4,0,6,10,8];
% 
% %% circle points
%     c1 = 4;
%     c2 = 4;
    C = [obstacle(1),obstacle(2)]
    r =  obstacle(3)
%% ALGORITHM
%     E is the starting point of the ray,
%     L is the end point of the ray,
%     C is the center of sphere you're testing against
%     r is the radius of that sphere
%     line([0,2],[10,8]);
    E1 = [X(1),Y(1)];
    L1 = [X(2),Y(2)];
    d = L1 - E1 %( Direction vector of ray, from start to end )
    f = E1 - C %( Vector from center sphere to ray start )
    a = dot( d,d )
    b = 2*dot( f,d ) ;
    c = dot( f,f ) - r*r ;
    discriminant = b*b-(4*a*c);
    if(discriminant < 0)
%         //no intersection
        collides = false;
    else
        discriminant = sqrt( discriminant );
        t1 = (-b - discriminant)/(2*a)
        t2 = (-b + discriminant)/(2*a)
            
        if( t1 >= 0 && t1 <= 1 )  
%     // t1 is the intersection, and it's closer than t2
%     // (since t1 uses -b - discriminant)
%     // Impale, Poke
            collides = true;
        end
        if ( t2 >= 0 && t2 <= 1 )
            collides = true;
        end
        
            
    end
%  // 3x HIT cases:
%   //          -o->             --|-->  |            |  --|->
%   // Impale(t1 hit,t2 hit), Poke(t1 hit,t2>1), ExitWound(t1<0, t2 hit), 
% 
%   // 3x MISS cases:
%   //       ->  o                     o ->              | -> |
%   // FallShort (t1>1,t2>1), Past (t1<0,t2<0), CompletelyInside(t1<0, t2>1)

  
      
    
  end
   
    
    
    


