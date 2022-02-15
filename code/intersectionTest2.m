%% make a frame
    xlim([0  16]);
    ylim([0  16]);
     axis square
     

%% put a circle in there
    viscircles([4,4],2);
    
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

% line([x1,x2],[y1,y2]);

%% found three lines
line([5,0],[0,4]);

% line([6,0],[0,6]);
% line([0,2],[10,8]);

x =[5,0,6,0,0,2];
y =[0,4,0,6,10,8];
%  line([x(3),x(4)],[y(3),y(4)])
line([x(5),x(6)],[y(5),y(6)])

p1 = [x(5);y(5)];
p2 = [x(6);y(6)]
c =  [4;4;];

[I1,I2] = findIntersection(p1,p2,c,r)

p1c = c - p1;

%% intersection
function [I1,I2]= findIntersection(P1,P2,C,r)
    I1 = [];
    I2= [];
   A = P1-C;
   B = P2-P1;
   d2 = dot(B,B);
   t = (r^2-dot(A,A))*d2+dot(A,B)^2;
   if t < 0, error("no intersection") ,end
   Q = P1-dot(A,B)/d2*B;
   t2 = sqrt(t)/d2*B;
   I1 = Q + t2
   I2 = Q - t2
end
  




