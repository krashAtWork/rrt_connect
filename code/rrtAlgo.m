% understanding the configuration space.
% There are three circular obstacles placed in the workspace of the robotic manipulator.
% The obstacles are centered at coordinates (8,0), (8,8), and (8,-8), and they all have radii of 2 units.

% How to draw a figure drawing such circles / obstacles

figure('Name','Obstacles')
title('Plot of initial and final goals with the circular obstacles')


 % Fix the axis limits.
    xlim([-20  20])
    ylim([-20  20])
 
    % Set the axis aspect ratio to 1:1.
axis square
viscircles([8,0],2); 
hold on;
% Clear the axes.

viscircles([8,8],2);
hold on;

viscircles([8,-8],2);
hold on;
% how to draw multiple circles

q_start =[0 -0.9273 0.9273];
q_goal = [0  0.9273  -0.9273];
a = 5;
%      thetaold1 = q_near(1,1);
%     thetaold2 = q_near(1,2);
%     thetaold3 = q_near(1,3);
x_initial = 0;
y_initial = 0;
theta1 = q_start(1,1);
theta2 = q_start(1,2);
theta3 = q_start(1,3);
x_final1 = a*cos(theta1);
y_final1 = a*sin(theta1);
x_final2 = a*cos(theta1) + a*cos(theta1 +theta2) ;
y_final2 = a*sin(theta1) + a*sin(theta1 +theta2) ;
x_final3 = a*cos(theta1) + a*cos(theta1 +theta2) + a*cos(theta1 +theta2 + theta3);
y_final3 = a*sin(theta1) + a*sin(theta1 +theta2) + a*sin(theta1 +theta2 + theta3);
line([x_initial,x_final1],[y_initial,y_final1],'Color','red'); 
hold on ;
line([x_final1,x_final2],[y_final1,y_final2],'Color','blue'); 
hold on ;
line([x_final2,x_final3],[y_final2,y_final3],'Color','green'); 
hold on ;
% line([x_initial,x_final3],[x_initial,y_final3],'Color','black'); 
hold on;
theta1 = q_goal(1,1);
theta2 = q_goal(1,2);
theta3 = q_goal(1,3);
x_final1g = a*cos(theta1);
y_final1g = a*sin(theta1);
x_final2g = a*cos(theta1) + a*cos(theta1 +theta2) ;
y_final2g = a*sin(theta1) + a*sin(theta1 +theta2) ;
x_final3g = a*cos(theta1) + a*cos(theta1 +theta2) + a*cos(theta1 +theta2 + theta3);
y_final3g = a*sin(theta1) + a*sin(theta1 +theta2) + a*sin(theta1 +theta2 + theta3);
line([x_initial,x_final1g],[y_initial,y_final1g],'Color','red','LineStyle','--'); 
hold on ;
line([x_final1g,x_final2g],[y_final1g,y_final2g],'Color','blue','LineStyle','--'); 
hold on ;
line([x_final2g,x_final3g],[y_final2g,y_final3g],'Color','green','LineStyle','--'); 
hold on ;

text(x_final3,y_final3,'\leftarrow qStart ')
text(x_final3g,y_final3g,'\leftarrow qGoal ')
% line([x_initial,x_final3],[x_initial,y_final3],'Color','black','LineStyle','--'); 

 




