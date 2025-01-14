function ang = JCS(char,qRef,q)
ang = [0,0,0];
qK = [0 0 0 1];
qJ = [0 0 1 0];

switch char
    case 'LA'
        Z = quatmultiply(qRef,quatmultiply(-qK,quatconj(qRef)));
        Z = [cos(pi/4),Z(2)*sin(pi/4),Z(3)*sin(pi/4),Z(4)*sin(pi/4)];
        qRef = quatmultiply(Z,qRef);
        
        R = quat2rotm(qRef);
        R(:,3) = -R(:,3);
        R(:,1) = -R(:,1);
        qRef = rotm2quat(R);
        
        R = quat2rotm(q);
        R(:,3) = -R(:,3);
        R(:,1) = -R(:,1);
        q = rotm2quat(R);
        
        qRel = quatmultiply(quatconj(qRef),q);
        R = quat2rotm(qRel);
        bd = atan2(-R(1,2),R(2,2));
        qZ = [cos(bd/2),0,0,sin(bd/2)];
        q2 = quatmultiply(quatconj(qZ),qRel);
        R = quat2rotm(q2);
        
        ef = atan2(R(3,2),R(2,2));
        qX = [cos(ef/2),sin(ef/2),0,0];
        q2 = quatmultiply(quatconj(qX),q2);
        R = quat2rotm(q2);
        
        ie = atan2(R(1,3),R(3,3));
        ang = [bd,ef,ie];
        
    case 'LF'
        Y = quatmultiply(qRef,quatmultiply(qJ,quatconj(qRef)));
        Y = [cos(pi/4),Y(2)*sin(pi/4),Y(3)*sin(pi/4),Y(4)*sin(pi/4)];
        qRef = quatmultiply(Y,qRef);
        
        R = quat2rotm(qRef);
        R(:,1) = -R(:,1);
        R(:,3) = -R(:,3);
        qRef = rotm2quat(R);
        
        R = quat2rotm(q);
        R(:,1) = -R(:,1);
        R(:,3) = -R(:,3);
        q = rotm2quat(R);
        
        qRel = quatmultiply(quatconj(qRef),q);
        R = quat2rotm(qRel);
        ef = atan2(-R(1,2),R(2,2));
        qZ = [cos(ef/2),0,0,sin(ef/2)];
        q2 = quatmultiply(quatconj(qZ),qRel);
        R = quat2rotm(q2);
        
        mo = atan2(R(3,2),R(2,2));
        qX = [cos(mo/2),sin(mo/2),0,0];
        q2 = quatmultiply(quatconj(qX),q2);
        R = quat2rotm(q2);
        
        ps = atan2(R(1,3),R(3,3));
        ang = [ef,mo,ps];
        
    case 'RA'
        Z = quatmultiply(qRef,quatmultiply(-qK,quatconj(qRef)));
        Z = [cos(pi/4),Z(2)*sin(pi/4),Z(3)*sin(pi/4),Z(4)*sin(pi/4)];
        qRef = quatmultiply(Z,qRef);
        
        R = quat2rotm(qRef);
        R(:,1) = -R(:,1);
        R(:,2) = -R(:,2);
        qRef = rotm2quat(R);
        
        R = quat2rotm(q);
        R(:,1) = -R(:,1);
        R(:,2) = -R(:,2);
        q = rotm2quat(R);
        
        qRel = quatmultiply(quatconj(qRef),q);
        R = quat2rotm(qRel);
        bd = atan2(-R(1,2),R(2,2));
        qZ = [cos(bd/2),0,0,sin(bd/2)];
        q2 = quatmultiply(quatconj(qZ),qRel);
        R = quat2rotm(q2);
        
        ef = atan2(R(3,2),R(2,2));
        qX = [cos(ef/2),sin(ef/2),0,0];
        q2 = quatmultiply(quatconj(qX),q2);
        R = quat2rotm(q2);
        
        ie = atan2(R(1,3),R(3,3));
        ang = [bd,ef,ie];
    case 'RF'
        Y = quatmultiply(qRef,quatmultiply(-qJ,quatconj(qRef)));
        Y = [cos(pi/4),Y(2)*sin(pi/4),Y(3)*sin(pi/4),Y(4)*sin(pi/4)];
        qRef = quatmultiply(Y,qRef);
        
        R = quat2rotm(qRef);
        R(:,1) = -R(:,1);
        R(:,2) = -R(:,2);
        qRef = rotm2quat(R);
        
        R = quat2rotm(q);
        R(:,1) = -R(:,1);
        R(:,2) = -R(:,2);
        q = rotm2quat(R);
        
        qRel = quatmultiply(quatconj(qRef),q);
        R = quat2rotm(qRel);
        ef = atan2(-R(1,2),R(2,2));
        qZ = [cos(ef/2),0,0,sin(ef/2)];
        q2 = quatmultiply(quatconj(qZ),qRel);
        R = quat2rotm(q2);
        
        mo = atan2(R(3,2),R(2,2));
        qX = [cos(mo/2),sin(mo/2),0,0];
        q2 = quatmultiply(quatconj(qX),q2);
        R = quat2rotm(q2);
        
        ps = atan2(R(1,3),R(3,3));
        ang = [ef,mo,ps];
end