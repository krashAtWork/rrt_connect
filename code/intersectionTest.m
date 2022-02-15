%% make a frame
    xlim([0  16]);
    ylim([0  16]);
     axis square
     

%% put a circle in there
    viscircles([4,4],2);
    hold on;
%% define the points
x1 = 0;
x2 = 2;
y1 = 0;
y2 = 2;
P1=[x1;y1];
P2 = [x2;y2];
c1 = 4;
c2 = 4;
C = [c1;c2];
r =  2;

line([x1,x2],[y1,y2]);

slope1 = (y2 - y1)/(x2 - x1);
% 
% y = slope1* x;

%% circle equation

%  x^2 + y^2 = 4;
 
 %% solving equation
  
   A = P1-C;
   B = P2-P1;
   d2 = dot(B,B);
   t = (r^2-dot(A,A))*d2+dot(A,B)^2;
   if t < 0, error('There is no intersection.'), end
   Q = P1-dot(A,B)/d2*B;
   t2 = sqrt(t)/d2*B;
   I1 = Q + t2
   I2 = Q - t2
   hold on ;
   line([x1,I1(1,1)],[ y1,I1(2,1)],'Color','red')
   
   %% 
   d = 
   float a = d.Dot( d ) ;
float b = 2*f.Dot( d ) ;
float c = f.Dot( f ) - r*r ;

float discriminant = b*b-4*a*c;
if( discriminant < 0 )
{
  // no intersection
}
else
{
  // ray didn't totally miss sphere,
  // so there is a solution to
  // the equation.

  discriminant = sqrt( discriminant );

  // either solution may be on or off the ray so need to test both
  // t1 is always the smaller value, because BOTH discriminant and
  // a are nonnegative.
  float t1 = (-b - discriminant)/(2*a);
  float t2 = (-b + discriminant)/(2*a);

  // 3x HIT cases:
  //          -o->             --|-->  |            |  --|->
  // Impale(t1 hit,t2 hit), Poke(t1 hit,t2>1), ExitWound(t1<0, t2 hit), 

  // 3x MISS cases:
  //       ->  o                     o ->              | -> |
  // FallShort (t1>1,t2>1), Past (t1<0,t2<0), CompletelyInside(t1<0, t2>1)

  if( t1 >= 0 && t1 <= 1 )
  {
    // t1 is the intersection, and it's closer than t2
    // (since t1 uses -b - discriminant)
    // Impale, Poke
    return true ;
  }

  // here t1 didn't intersect so we are either started
  // inside the sphere or completely past it
  if( t2 >= 0 && t2 <= 1 )
  {
    // ExitWound
    return true ;
  }

  // no intn: FallShort, Past, CompletelyInside
  return false ;
}
   
    
