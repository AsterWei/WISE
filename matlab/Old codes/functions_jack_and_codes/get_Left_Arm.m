function leftarm = get_Left_Arm(back,arm)
leftarm = zeros(3,1);
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
% Vza = quatmultiply(arm,quatmultiply(Qk,quatconj(arm)));

Ja = Vya(2:4);

IE = Vxb(2:4);
JE = Vyb_(2:4);
KE = Vzb_(2:4);

V = [dot(Ja,IE) , dot(Ja,JE) , dot(Ja,KE)];

% shoulder extension flexion
leftarm(1,1) = atan2d(V(3),V(1));
if -180<=leftarm(1,1) && leftarm(1,1)<-90
    leftarm(1,1) = 360 + leftarm(1,1);
end

% shoulder abduction adduction 
leftarm(2,1) = atan2d(V(2),V(1));
if -180<=leftarm(2,1) && leftarm(2,1)<-90
    leftarm(2,1) = 360 + leftarm(2,1);
end

% shoulder internal external rotation 



%JCS algorithm
%{
th = -pi/2;
Qz = [cos(th/2),Vzb(2)*sin(th/2),Vzb(3)*sin(th/2),Vzb(4)*sin(th/2)];
Qback = quatmultiply(Qz,back);
Qr = quatmultiply(quatconj(Qback),arm);
R = quat2rotm(Qr);
leftarm(3,1) = atan2d(R(1,3),R(3,3));
%}

%first algorithm
%{ 
Xb = [dot(Vxb(2:4),Vxa(2:4)),dot(Vxb(2:4),Vya(2:4)),dot(Vxb(2:4),Vza(2:4))];
Yb = [dot(Vyb(2:4),Vxa(2:4)),dot(Vyb(2:4),Vya(2:4)),dot(Vyb(2:4),Vza(2:4))];
Zb = [dot(Vzb(2:4),Vxa(2:4)),dot(Vzb(2:4),Vya(2:4)),dot(Vzb(2:4),Vza(2:4))];

PP = [Xb(2),Yb(2),Zb(2)];
AbsPP = abs(PP);
[~,ind] = min(AbsPP);
switch ind
    case 1
        Xb = -Xb;
        leftarm(3,1) = atan2d(Xb(3),Xb(1));
    case 2
        Yb = -Yb;
        leftarm(3,1) = atan2d(Yb(3),Yb(1));
    case 3
        leftarm(3,1) = atan2d(-Zb(1),Zb(3));
end
%}
end