function[q_rand] = random_node_gen1()
a = 0;
b = 2 * pi;
q_rand = a + (b-a).* rand(1,3);
for i = 1: length(q_rand)
    if (q_rand(1,i) > pi)
        q_rand(1,i) = -( b - q_rand(1,i));
    end
end
%%% 
angleInDegrees = rad2deg(q_rand);  
end