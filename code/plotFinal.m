% plotFinal(success, q_connect, Ta, Tb);

disp("plotFinal called")


if success == true
    nodesA = nnodes(Ta);
    nodesB = nnodes(Tb);
    path = zeros(nodesA + nodesB -1 ,3)
    
    for i =   nodesB : -1 :1
%         Tresult.addnode(i, Tb.get(i))
        Tb.getparent(i);
    end
    
    for j =  nodesA : -1 :1
        Tresult.addnode(j)
        Ta.get(j)
    end
    
    nodesfinal = nnodes(Tresult);
    for  k= 1 : nodesfinal
        Tresult.get(k)
    end
else
    disp("no plot");
end
end