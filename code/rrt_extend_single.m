% rrt_extend_single
% lineage = tree.example;
% disp(lineage.tostring)

%% find random numbers between 0 to 2pi
clc;

q_random= random_node_gen();
q_randomInDegrees = rad2deg(q_random);

%% make a tree with many values like these
 Ta  = tree([0,0,0]);
 n = 3 ;
 for i = 1 : n
     node = random_node_gen();
     Ta = Ta.addnode(i,node);
 end
 % visual representation of tree
 disp(Ta.tostring);
 
Ta;
q_target= [];
q_near = find_nearest(Ta, q_random);
step_length = 1;
q_int = limit( q_random, q_near, step_length) % be careful about angle correction
step_size = 0.25;
result = local_planner(q_near, q_int, step_size)
if (result == true)
n = nnodes(Ta)
Ta = Ta.addnode( n, q_int)
q_target = q_int
end
% return (result, Ta, q_target)

 
%% random node generator
function[q_rand] = random_node_gen()
a = 0;
b = 2 * pi;
q_rand = a + (b-a).* rand(1,3);
angleInDegrees = rad2deg(q_rand);  
end


%% find_nearest
function[q_near] = find_nearest(Ta, q_random)
% go through each node of the tree
n = nnodes(Ta);
mag_mat = zeros(1,n);
 for i = 1 : n
      Ta.get(i) %%% my tree
      mag_mat(1,i) = norm(Ta.get(i));
 end
 mag_mat;
 q_random  %%% random config
 mag_random = norm(q_random);
 diff_mat = zeros(1,n);
  for i = 1 : n       
      diff_mat(1,i) = abs(mag_random - mag_mat(1,i) );
  end
diff_mat;
min(diff_mat);
result = find(diff_mat == min(diff_mat));
q_near = Ta.get(result) %%% nearest one
% find the magnitude of each
% compare with the magnitude of q_random
end
%% limit
% The LIMIT function finds an intermediate configuration q_int from between q_near and q_target, 
% such that q_int is at a distance of step_length from q_near. 
% If the distance between q_near and q_target is less than step_length, it would return q_target
function [q_int] = limit( q_random, q_near, step_length)
delta_q = q_random - q_near;
step = step_length * delta_q / norm(delta_q) ;
if(step < delta_q)
    q_int = q_random ; 
else
    q_int  = q_near + step;
end
end

