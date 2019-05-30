function fix = fix_B(q)
    qI = [0,1,0,0];
    qJ = [0,0,1,0];
    qK = [0,0,0,1];

    [~,I1,I2,I3] = parts(quaternion(quatmultiply(q,quatmultiply(qI,quatconj(q)))));
    IE = [I1,I2,I3];
    [~,J1,J2,J3] = parts(quaternion(quatmultiply(q,quatmultiply(qJ,quatconj(q)))));
    JE = [J1,J2,J3];
    [~,K1,K2,K3] = parts(quaternion(quatmultiply(q,quatmultiply(qK,quatconj(q)))));
    KE = [K1,K2,K3];
    
    x = 0.072;
    rotx = [cos(x/2),IE(1)*sin(x/2),IE(2)*sin(x/2),IE(3)*sin(x/2)];
    
    fix = quatmultiply(rotx,q);
end