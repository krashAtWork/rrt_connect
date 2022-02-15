function [result, Tb, q_connect] = rrt_extend_multiple_func(Tb,q_target,step_length)

step_size = 0.1;

disp("rrt_extend_multiple_func called")
q_connect= [];
result = false;
[q_near,indexnear]= find_nearest(Tb, q_target);
q_int = limit( q_target, q_near, step_length); % be careful about angle correction
q_last= q_near;
num_steps= ceil(norm(limitAngle(q_target-q_near))/step_length);

for i=1:num_steps
    result = local_planner(q_int, q_last, step_size);
    
    if (result == true)
        %             [ t node1 ] = t.addnode(1, 'Node 1'); %% attach to root
        
        [Tb,  idx]= Tb.addnode(indexnear , q_int);
        q_connect = q_int;
        if (i< num_steps)
            q_last = q_int;
            q_int = limit( q_target, q_int, step_length);
            indexnear = idx; %%% have added qint, its index in that tree
        end
    else
        return;
    end
end

end

%% find_nearest
function[q_near,indexnear] = find_nearest(Ta, q_random)
n = nnodes(Ta); % number of nodes in Tree A
    Ta_mat = zeros(n,3);% magnitude matrix for Tree A initialised to zero
    diff_mat = zeros(1,n);
   
    for i = 1 : n
        Ta.get(i)
         diff_mat(1,i) = norm(limitAngle(Ta.get(i) - q_random))  % array of Tree A
    end
    
    min(diff_mat);
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
delta_q = q_random - q_near;
delta_q = limitAngle(delta_q);
step = step_length * delta_q / norm(delta_q) ;
flag = step_length < norm(delta_q);
if(flag == true)
    q_int  = q_near + step;
else
    q_int  = q_random;
end

end
%% limit Angle
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

    






