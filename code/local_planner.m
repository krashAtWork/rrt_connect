%% local planner

function [success] = local_planner(q_near, q_int, step_size)
success = false;
disp('local_planner called ')
obstacle1 = [8, 0, 2];
obstacle2 = [8, 8, 2];
obstacle3 = [8, -8, 2];
% obstacles = [];
obstacles = [obstacle1; obstacle2 ; obstacle3];

 % Fix the axis limits.
 xlim([-16  16]);
 ylim([-16  16]);
 axis square
 viscircles([8,0],2); 
 hold on;

 viscircles([8,8],2);
 hold on;

 viscircles([8,-8],2);
 hold on;
 
q2 = q_int;
q1 = q_near;
delta_q = q2 - q1;
delta_q = limitAngle(delta_q);
num_steps = ceil(norm(delta_q)/step_size); % be careful about angle correction 
step = delta_q/ num_steps;
collision = false;
q = q1;
    for i = 1: num_steps %%4
        
        q = q + step ;      
         collision = collision || check_collision( q, obstacles); 
        if(collision == true)
            return;
        end
    end
success = not(collision);
end


%% check collision function

function [doesTouch] = check_collision(q,obstacles)
    disp('check_collision called ')
    doesTouch = false;
    a = 5;
    x_initial = 0;
    y_initial = 0;
    theta1 = q(1,1);
    theta2 = q(1,2);
    theta3 = q(1,3);  
   
    x_final1 = a*cos(theta1);
    y_final1 = a*sin(theta1);
    x_final2 = a*cos(theta1) + a*cos(theta1 +theta2); 
    y_final2 = a*sin(theta1) + a*sin(theta1 +theta2); 
    x_final3 = a*cos(theta1) + a*cos(theta1 +theta2) + a*cos(theta1 +theta2 + theta3);
    y_final3 = a*sin(theta1) + a*sin(theta1 +theta2) + a*sin(theta1 +theta2 + theta3);
    
    line([x_initial,x_final1],[y_initial,y_final1],'Color','red'); 
    hold on ;
    line([x_final1,x_final2],[y_final1,y_final2],'Color','blue'); 
    hold on ;
    line([x_final2,x_final3],[y_final2,y_final3],'Color','green'); 
     hold on;
%     hold on ;
%     line([x_initial,x_final3],[x_initial,y_final3],'Color','black'); 
   
    for i = 1 : length(obstacles)
        obstacles(i,:);
        collidesl1 = collisionCheck(obstacles(i,:),[x_final1,x_final2],[y_final1,y_final2] ); %2nd link
        collidesl2 = collisionCheck(obstacles(i,:),[x_final2,x_final3],[y_final2,y_final3] ); %3rd link
        doesTouch = false;
        doesTouch = collidesl1 || collidesl2;
        if(doesTouch == true)            
            break;
        else
            continue;
        end
    end
end
 
 
 

function [Ta_mat] = limitAngle(Ta_mat)
        [m, n] = size(Ta_mat); %m rows, n columns
        for i = 1: m
            for j = 1: n
                if (Ta_mat(i,j) >= pi )
                    Ta_mat(i,j) = Ta_mat(i,j) - 2*pi;
                    elseif (Ta_mat(i,j) < - pi )
                    Ta_mat(i,j) = Ta_mat(i,j) + 2*pi ;
                end 
            end
        end
    end



    
    
    
    