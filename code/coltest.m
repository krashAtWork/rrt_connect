 
obstacle1 = [8, 0, 2];
obstacle2 = [8, 8, 2];
obstacle3 = [8, -8, 2];
% obstacles = [];
obstacles = [obstacle1; obstacle2 ; obstacle3];
x_final1 = 0;
x_final2 = 1;
x_final3 = 2;
y_final1 = 0;
y_final2 = 0;
y_final3 = 0;

 xlim([-16  16]);
 ylim([-16  16]);
 axis square
 viscircles([8,0],2); 
 hold on;
% Clear the axes.

 viscircles([8,8],2);
 hold on;

 viscircles([8,-8],2);
 hold on;
 
     line([x_final1,x_final2],[y_final1,y_final2],'Color','blue'); 
    hold on ;
    line([x_final2,x_final3],[y_final2,y_final3],'Color','green'); 
    
    
    

for i = 1 : length(obstacles)
        obstacles(i,:);
        coff = polyfit([x_final1,x_final2],[y_final1,y_final2], 1);
        doesTouchlink2 = abs(coff(1)*obstacles(i,1) + coff(2) - obstacles(i,2))/norm([1 coff(1)]) < obstacles(i,3);
        coff = polyfit([x_final2,x_final3],[y_final2,y_final3], 1);
        doesTouchlink3 = abs(coff(1)*obstacles(i,1) + coff(2) - obstacles(i,2))/norm([1 coff(1)]) < obstacles(i,3);
        doesTouch = false;%%%%%%%%%%%%%%%%%%wrongcode
        doesTouch = doesTouchlink2 || doesTouchlink3
%         if(doesTouch == true)            
%             break;
%         else
%             continue;
%         end
end
    