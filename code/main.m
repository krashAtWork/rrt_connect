function [] = main()

clc;
%rng(1);
disp("main called")
q_start =[0, -0.9273 ,0.9273];
q_goal = [0 , 0.9273 , -0.9273];
Ta = tree(q_start);
Tb = tree(q_goal);
success  = false;
max_nodes = 1000;
step_length = 0.1;
% step_length = 1;
q_connect=[];
result2 = false;
result = false;


for i = 1: max_nodes
    q_rand = random_node_gen(); %% find the next point to extend to
    [result, Ta, q_target] = rrt_extend_single_func(Ta, q_rand, step_length); % extend from Ta to this new point using this step length
    if(result == true)
        disp("1st True")
        [result2, Tb, q_connect] = rrt_extend_multiple_func(Tb, q_target,step_length);
        if (result2 == true) % connected the two trees
            disp("2nd True")
            success = true;
            break;
        end
    end
    [Ta,Tb] = swap(Ta, Tb);
end
plotFinal(success, q_connect, Ta, Tb);
end

%% random_config()
function[q_rand] = random_node_gen()
disp("random_node_gen called");
a = 0;
b = 2 * pi;
q_rand = a + ( b-a ).* rand(1,3);
for i = 1: length(q_rand)
    if (q_rand(1,i) >= pi) % if value is greater than 180, we get a negative degree
        q_rand(1,i) = -( b - q_rand(1,i));
    end
end
end
%% swap
function [Ta,Tb] = swap(Ta, Tb)
temp = Ta;
Ta = Tb ;
Tb = temp ;
disp("swapped");
end
%%
function [] = plotFinal(success, q_connect, Ta, Tb)
disp("plotFinal called");
nodesA = nnodes(Ta);
nodesB = nnodes(Tb);
pathFromA = zeros(nodesA ,3);
pathFromB = zeros(nodesB ,3);
if success == true    
    for nA = nodesA :-1:1 %% tracing back each parent from final node
        elem =  Ta.getparent(nA);
        if(elem == 0)
            parent = -1 ;
        else
        parent = Ta.get(elem);   
        end
        pathFromA(nodesA - nA + 1,:) = parent;
    end
    
    for nB = nodesB :-1:1
        elem =  Tb.getparent(nB);
        if(elem == 0)
            parent = -1;
        else
        parent = Tb.get(elem) ;  
        end
        pathFromB(nodesB - nB + 1,: )= parent;
    end
    pathFromA
    pathFromB
    pathFromA(nodesA,:) = []; % remove the last element i.e. [-1,-1,-1]
    pathFromB(nodesB,:) = [];
    path = [pathFromB; q_connect; pathFromA] % make the whole path
    plotThePath(path);
else
    disp("no plot");
    for i=1 : nodesA
        pathFromA(i,:) = Ta.get(i);
    end
    plotThePath(pathFromA)
    for i=1 : nodesB
        Tb.get(i);
        pathFromB(i,:) = Tb.get(i);
    end
    plotThePath(pathFromB)
end

end
%%
function [] = plotThePath(path)
% path
% length(path)
disp("plotThePath called");

figure();
title('final Path');


% Fix the axis limits.
    xlim([-20  20]);
    ylim([-20  20]);
 
% Set the axis aspect ratio to 1:1.
axis square
viscircles([8,0],2); 
hold on;
% Clear the axes.

viscircles([8,8],2);
hold on;

viscircles([8,-8],2);
hold on;
    a = 5;
    x_initial = 0;
    y_initial = 0;
    for q = 1 : size(path,1)
        q;
        theta1 = path(q,1);
        theta2 = path(q,2);
        theta3 = path(q,3);
        
        x_final1 = a*cos(theta1);
        y_final1 = a*sin(theta1);
        x_final2 = a*cos(theta1) + a*cos(theta1 +theta2);
        y_final2 = a*sin(theta1) + a*sin(theta1 +theta2);
        x_final3 = a*cos(theta1) + a*cos(theta1 +theta2) + a*cos(theta1 +theta2 + theta3);
        y_final3 = a*sin(theta1) + a*sin(theta1 +theta2) + a*sin(theta1 +theta2 + theta3);
        
        line([x_initial,x_final1],[y_initial,y_final1],'Color',"red");
        hold on ;
        line([x_final1,x_final2],[y_final1,y_final2],'Color',"blue");
        hold on ;
        line([x_final2,x_final3],[y_final2,y_final3],'Color',"green");

        hold on;
    end

end
