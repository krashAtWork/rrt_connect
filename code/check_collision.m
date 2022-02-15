%     %%  making inputs
%     q_target= random_node_gen();
%     q_randomInDegrees = rad2deg(q_target);
%     Tb  = tree([0,0,0]);
%     n = 3 ;
%     for i = 1 : n
%         node = random_node_gen();
%         Tb = Tb.addnode(i,node);
%     end
%     % visual representation of tree
%     disp(Tb.tostring);
%     step_length = 1;
    %% end making inputs

%function [doesTouch] = check_collision(q,obstacles)
%     disp('check_collision called once ')
%     doesTouch = false;
%     a = 5;
% %      thetaold1 = q_near(1,1);
% %     thetaold2 = q_near(1,2);
% %     thetaold3 = q_near(1,3);
%     x_initial = 0;
%     y_initial = 0;
%     theta1 = q(1,1);
%     theta2 = q(1,2);
%     theta3 = q(1,3);
%    %% need to do something here
% %     x_initial = a*cos(thetaold1) + a*cos(thetaold1 +thetaold2) + a*cos(thetaold1 +thetaold2 + thetaold3);    
% %     y_initial = a*sin(thetaold1) + a*sin(thetaold1 +thetaold2) + a*sin(thetaold1 +thetaold2 + thetaold3);
%     
%     x_final1 = a*cos(theta1);
%     y_final1 = a*sin(theta1);
%     x_final2 = a*cos(theta1) + a*cos(theta1 +theta2) ;
%     y_final2 = a*sin(theta1) + a*sin(theta1 +theta2) ;
%     x_final3 = a*cos(theta1) + a*cos(theta1 +theta2) + a*cos(theta1 +theta2 + theta3);
%     y_final3 = a*sin(theta1) + a*sin(theta1 +theta2) + a*sin(theta1 +theta2 + theta3);
%     line([x_initial,x_final1],[y_initial,y_final1],'Color','red'); 
%     hold on ;
%     line([x_final1,x_final2],[y_final1,y_final2],'Color','blue'); 
%     hold on ;
%     line([x_final2,x_final3],[y_final2,y_final3],'Color','green'); 
% %     hold on ;
% %     line([x_initial,x_final3],[x_initial,y_final3],'Color','black'); 
%     hold on;
%     for i = 1 : length(obstacles)
%         disp('obstacle does touch')
%         obstacles(i,:);
%         coff = polyfit([x_final2, x_final3], [y_final2, y_final3], 1);
%         doesTouch = abs(coff(1)*obstacles(i,1) + coff(2) - obstacles(i,2))/norm([1 coff(1)]) < obstacles(i,3);
%         doesTouch = false;%%%%%%%%%%%%%%%%%%wrongcode
%         if(doesTouch == true)            
%             break;
%         else
%             continue;
%         end
%     end
% end

    clc;
    q_random = random_node_gen1();
    q_randomInDegrees = rad2deg(q_random);

    
    Ta  = tree([0,0,0]);
    n = 3 ;
    for i = 1 : n
        node = random_node_gen1();
        Ta = Ta.addnode(i,node);
    end
    % visual representation of tree
    disp(Ta.tostring);
    
    
    q_random ; %%% random config
    disp("find_nearest called")
    

    n = nnodes(Ta); % number of nodes in Tree A
    Ta_mat = zeros(n,3);% magnitude matrix for Tree A initialised to zero
    diff_mat = zeros(1,n);
    q_random
    for i = 1 : n
        Ta.get(i)
         diff_mat(1,i) = norm(limitAngle(Ta.get(i) - q_random))  % array of Tree A
    end
    Ta_mat;
   
     
%     Ta_mat = q_random - Ta_mat % difference between Ta and q_random
%     Ta_mat = limitAngle(Ta_mat)
   %%%%%%%%%%  
             

%     mag_random = norm(q_random); % magnitude of q_random

    % difference matrix  initialised to zero


%     for i = 1 : n
%         diff_mat(1,i) = abs(norm(q_random - Ta_mat(i,:))) ; % difference between mag_mat and mag_random
%     end
%     diff_mat;
    
    min(diff_mat);
    index = find(diff_mat == min(diff_mat));
    q_near = Ta.get(index(1))
    indexnear = index(1)%%% nearest one picking one
    
    %% 
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