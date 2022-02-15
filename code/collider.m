x =  [0 ; 1; 2 ; 3; 4; 5];
y =  [0 ; 1; 1; 3; 1; -2];
r = 10;
cx = 0;
cy = 0;
lastIn = findLastPointWithinRadius(cx, cy);
if (lastIn+1 <= numel(x))
    lineSegX = x(lastIn : lastIn+1);
    lineSegY = y(lastIn : lastIn+1);
    [xInt, yInt] = findIntersect(cx, cy, lineSegX, lineSegY)
else
    error('No collision')
end

cla
h = plot(x,y, 'r*', xInt, yInt, 'ko',cx, cy, 'ko');
set(h, 'lineWIdth',3);
xlim(-6,6);ylim(-6,6);
hold on;
circle([cx,cy],r, 50, '-');
axis equal;
grid on;

%% function
function[lastIn] = findLastPointWithinRadius(cx, cy)
    deltaX =  x - cx ;
    deltaY =  y - cy ;
    distance = sqrt(deltaX^2 + deltaY^2 );
    flagInPoints = (distance <= r);
    lastPointIn = find(flagInPoints, 1, 'last' );
    
end
%% function2
function [xInt, yInt] = findIntersect(cx, cy, lineSegX, lineSegY)
    a = diff(lineX)^2 + diff(lineY)^2 ;
    b = 2 * ( diff(lineX)* (lineX(1)- cx) + diff(lineY)* (lineY(1)- cy) );
    c = (cx - lineX(1))^2 +(cy -lineY(1))^2 - r^2;
    
    u  = (-b + sqrt(b^2 - (4*a*c)))/(2*a);
    
    xInt(1) = lineX(1) + u* diff(lineX);
    yInt(1) = lineY(1) + u* diff(lineY);
end


    



