function left = get_Left(back,arm,wrist)
left = zeros(5,1);
Qi = [0,1,0,0];
Qj = [0,0,1,0];
Qk = [0,0,0,1];

Vxb = quatmultiply(back,quatmultiply(Qi,quatconj(back)));
Vyb = quatmultiply(back,quatmultiply(Qj,quatconj(back)));
Vzb = quatmultiply(back,quatmultiply(Qk,quatconj(back)));

Vyb_ = -Vyb;
Vzb_ = -Vzb;

% Vxa = quatmultiply(arm,quatmultiply(Qi,quatconj(arm)));
Vya = quatmultiply(arm,quatmultiply(Qj,quatconj(arm)));

% Vxw = quatmultiply(wrist,quatmultiply(Qi,quatconj(wrist)));
% Vyw = quatmultiply(wrist,quatmultiply(Qj,quatconj(wrist)));
% Vzw = quatmultiply(wrist,quatmultiply(Qk,quatconj(wrist)));

Ja = Vya(2:4);

IE = Vxb(2:4);
JE = Vyb_(2:4);
KE = Vzb_(2:4);

V = [dot(Ja,IE) , dot(Ja,JE) , dot(Ja,KE)];

% shoulder extension flexion
left(1,1) = atan2d(V(3),V(1));
if -180<=left(1,1) && left(1,1)<-90
    left(1,1) = 360 + left(1,1);
end

% shoulder abduction adduction 
left(2,1) = atan2d(V(2),V(1));
if -180<=left(2,1) && left(2,1)<-90
    left(2,1) = 360 + left(2,1);
end

% elbow extension flexion

    %JCS_isb mode
Y = [cos(pi/4),Vya(2)*sin(pi/4),Vya(3)*sin(pi/4),Vya(4)*sin(pi/4)];
qRef = quatmultiply(Y,arm);

R = quat2rotm(qRef);
R(:,1) = -R(:,1);
R(:,3) = -R(:,3);
qRef = rotm2quat(R);

R = quat2rotm(wrist);
R(:,1) = -R(:,1);
R(:,3) = -R(:,3);
q = rotm2quat(R);

qRel = quatmultiply(quatconj(qRef),q);
[r1,~,~] = quat2angle(qRel,'ZXY');
left(4,1) = r1*180/pi;
    %JCS mode
%{
Y = [cos(pi/4),Vya(2)*sin(pi/4),Vya(3)*sin(pi/4),Vya(4)*sin(pi/4)];
qRef = quatmultiply(Y,arm);

R = quat2rotm(qRef);
R(:,1) = -R(:,1);
R(:,3) = -R(:,3);
qRef = rotm2quat(R);

R = quat2rotm(wrist);
R(:,1) = -R(:,1);
R(:,3) = -R(:,3);
q = rotm2quat(R);

qRel = quatmultiply(quatconj(qRef),q);
R = quat2rotm(qRel);
left(4,1) = atan2d(-R(1,2),R(2,2));
%}

    %Normal mode
%{
YW = Vyw(2:4) - dot(Vyw(2:4),Vxa(2:4))*Vxa(2:4);
left(4,1) = real(acosd(dot(Vya(2:4),YW)/norm(YW)));
%}

% elbow pronation supination
    %Old algorithm old record
%{
Ref = cross(Vxa(2:4),Vyw(2:4));
Ref = [dot(Ref,Vxw(2:4)),dot(Ref,Vyw(2:4)),dot(Ref,Vzw(2:4))];
left(5,1) = atan2d(-Ref(3),-Ref(1));
%}

% shoulder internal external rotation 

left(3,1) = 666;

% new JCS algorithm
if left(4,1)>=30
    
        %Version 3
    Z = [cos(pi/4),Vzb_(2)*sin(pi/4),Vzb_(3)*sin(pi/4),Vzb_(4)*sin(pi/4)];
    qRef = quatmultiply(Z,back);

    R = quat2rotm(qRef);
    R = [-R(:,1),R(:,2),-R(:,3)];
    qRef = rotm2quat(R);

    R = quat2rotm(arm);
    R = [-R(:,1),R(:,2),-R(:,3)];
    q = rotm2quat(R);

    qRel = quatmultiply(quatconj(qRef),q);
    [r1,~,r3] = quat2angle(qRel,'YZY');
    left(3,1) = (r1+r3)*180/pi;
    
        %Version 2
%{
    Z = [cos(pi/4),Vzb_(2)*sin(pi/4),Vzb_(3)*sin(pi/4),Vzb_(4)*sin(pi/4)];
    qRef = quatmultiply(Z,back);

    R = quat2rotm(qRef);
    R(:,3) = -R(:,3);
    R(:,1) = -R(:,1);
    qRef = rotm2quat(R);

    R = quat2rotm(arm);
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

    left(3,1) = atan2d(R(1,3),R(3,3));
%}
        %Version 1
    %{
    Z = [cos(pi/4),Vzb_(2)*sin(pi/4),Vzb_(3)*sin(pi/4),Vzb_(4)*sin(pi/4)];
    back = quatmultiply(Z,back);

    R = quat2rotm(back);
    R(:,3) = -R(:,3);
    R(:,1) = -R(:,1);
    back = rotm2quat(R);

    Y = Vya(2:4);
    X = cross(Vyw(2:4),Vya(2:4));
    X = X/norm(X);
    Z = cross(X,Y);
    R(:,1) = -X;
    R(:,2) = Y;
    R(:,3) = -Z;
    q = rotm2quat(R);

    qRel = quatmultiply(quatconj(back),q);
    R = quat2rotm(qRel);
    bd = atan2(-R(1,2),R(2,2));
    qZ = [cos(bd/2),0,0,sin(bd/2)];
    q2 = quatmultiply(quatconj(qZ),qRel);
    R = quat2rotm(q2);

    ef = atan2(R(3,2),R(2,2));
    qX = [cos(ef/2),sin(ef/2),0,0];
    q2 = quatmultiply(quatconj(qX),q2);
    R = quat2rotm(q2);

    left(3,1) = atan2d(R(1,3),R(3,3));
    %}

end

% plane algorithm
%{
if left(4,1)>=30
    
    Zref = cross(Vyb(2:4),Vya(2:4));
    Zref = Zref/norm(Zref);
    Yref = cross(Vya(2:4),Zref);
    Na = cross(Vyw(2:4),Vya(2:4));
    Na = Na/norm(Na);
    Va = cross(Vya(2:4),Na);
    left(3,1) = atan2d(dot(Va,Yref),dot(Va,Zref));
end
%}

end