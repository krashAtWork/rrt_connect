function [result, Ta, q_target ] = rrt_extend_single_func(Ta, q_random, step_length)
    step_size = 0.01;
    disp("rrt_extend_single_func called")
    q_target= [];
    [q_near,indexnear] = find_nearest(Ta, q_random);    
    q_int = limit( q_random, q_near, step_length); % be careful about angle correction
    
    result = local_planner(q_near, q_int, step_size);
    if (result == true) 
        Ta = Ta.addnode( indexnear , q_int); 
        q_target = q_int;
    end
end
%% find_nearest
function[q_near,indexnear] = find_nearest(Ta, q_random)
    disp("find_nearest called")
    n = nnodes(Ta); % number of nodes in Tree A
    Ta_mat = zeros(n,3);% magnitude matrix for Tree A initialised to zero
    diff_mat = zeros(1,n);  
    for i = 1 : n
        Ta.get(i)
         diff_mat(1,i) = norm(limitAngle(Ta.get(i) - q_random))  % array of Tree A
    end     
    index = find(diff_mat == min(diff_mat));
    q_near = Ta.get(index(1));
    indexnear = index(1);
end
%% limit
% The LIMIT function finds an intermediate configuration q_int from between q_near and q_target, 
% such that q_int is at a distance of step_length from q_near. 
% If the distance between q_near and q_target is less than step_length, it would return q_target
function [q_int] = limit( q_random, q_near, step_length)
disp("limit called")
delta_q = q_random - q_near ;
delta_q = limitAngle(delta_q);
step = step_length * delta_q / norm(delta_q) ;
% step_length = norm(step)
flag = step_length < norm(delta_q);
if(flag == true)
    q_int = q_near + step  ;
else
    q_int  = q_random;
end
end


%% random node generator
function[q_rand] = random_node_gen()
a = 0;
b = 2 * pi;
q_rand = a + (b-a).* rand(1,3);
% angleInDegrees = rad2deg(q_rand);
for i = 1: length(q_rand)
    if (q_rand(1,i) > pi)
        q_rand(1,i) = -( b - q_rand(1,i));
    end
end
end

%% limitAngle
function [Ta_mat] = limitAngle(Ta_mat)
        [m, n] = size(Ta_mat); %m rows, n columns
        for i = 1: m
            for j = 1: n
                if (Ta_mat(i,j) >= pi )
                    Ta_mat(i,j) = Ta_mat(i,j) - 2*pi;
                    elseif (Ta_mat(i,j) <- pi )
                    Ta_mat(i,j) = Ta_mat(i,j) + 2*pi ;
                end 
            end
        end
    end


