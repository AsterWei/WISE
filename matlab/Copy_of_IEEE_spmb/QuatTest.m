%%
q = [ 0.9063078, 0, 0, 0.4226183];% 50 degree rotation in Z axis
X = [1,0,0];
Y = [0,1,0];
Z = [0,0,1];
x = q(1) / sqrt(1-q(4)*q(4));
y = q(2) / sqrt(1-q(4)*q(4));
z = q(3) / sqrt(1-q(4)*q(4));
angle = 2 * acosd(q(4));
p = [x,y,z];
qx = quatmultiply(quatmultiply(q,[0,X]),quatconj(q));
qy = quatmultiply(quatmultiply(q,[0,Y]),quatconj(q));
qz = quatmultiply(quatmultiply(q,[0,Z]),quatconj(q));
hold on
plot3([0,1],[0,0],[0,0],'k');
plot3([0,0],[0,1],[0,0],'k');
plot3([0,0],[0,0],[0,1],'k');
plot3([0,qx(2)],[0,qx(3)],[0,qx(4)],'--','Color',[1 0 0],'LineWidth',1.5);
plot3([0,qy(2)],[0,qy(3)],[0,qy(4)],'--','Color',[0 1 0],'LineWidth',1.5);
plot3([0,qz(2)],[0,qz(3)],[0,qz(4)],'--','Color',[0 0 0.8],'LineWidth',1.5);
plot3([0,p(1)],[0,p(2)],[0,p(3)],'Color',[0.5 0.5 0.75],'LineWidth',1.5);
text(8*tf+g(1),15*tf+g(2),tf+g(3),'Gravity','Rotation',270,'FontSize',15)
text(tf+qx(2),-5*tf+qx(3),10*tf+qx(4),'X','FontSize',15)
text(tf+qy(2),10*tf+qy(3),tf+qy(4),'Y','FontSize',15)
text(8*tf+qz(2),-10*tf+qz(3),tf+qz(4),'Z','FontSize',15)
text(tf+p(1),tf+p(2),5*tf+p(3),'$$\hat{P}$$','Interpreter','Latex','FontSize',15)
% text(-5*tf,tf,-5*tf,'q_S','FontSize',15)
% plot3([0,qsx(2)],[0,qsx(3)],[0,qsx(4)],'-.','Color',[1 0 0],'LineWidth',1.5);
% plot3([0,qsy(2)],[0,qsy(3)],[0,qsy(4)],'-.','Color',[0 1 0],'LineWidth',1.5);
% plot3([0,qsz(2)],[0,qsz(3)],[0,qsz(4)],'-.','Color',[0 0 1],'LineWidth',1.5);
plot3([0,g(1)],[0,g(2)],[0,g(3)],'Color',[0 0 0],'LineWidth',1);
%% Finding the axis after a certain Quat Rot and also the angles in fixed co-ordinate system
clc;clear all;close all;
X = [1,0,0];
Y = [0,1,0];
Z = [0,0,1];
g = [0,0,1];
q = [0.9437144, 0.1276794, 0.1448781, 0.2685358];
x = q(1) / sqrt(1-q(4)*q(4));
y = q(2) / sqrt(1-q(4)*q(4));
z = q(3) / sqrt(1-q(4)*q(4));
q = quatnormalize(q);
angax = quat2axang(q);
qx = quatmultiply(quatmultiply(q,[0,X]),quatconj(q));
qy = quatmultiply(quatmultiply(q,[0,Y]),quatconj(q));
qz = quatmultiply(quatmultiply(q,[0,Z]),quatconj(q));
tf = 0.005;
thetaZ = acosd(dot(X,qx(2:4)));% angle between x and x' 
thetaY = acosd(dot(Y,qy(2:4)));% angle between y and y'
thetaX = acosd(dot(Z,qz(2:4)));% angle between z and z'
p = cross(g,qz(2:4))/norm(cross(g,qz(2:4)));
qp = [cosd(theta/2),p(1)*sind(theta/2),p(2)*sind(theta/2),p(3)*sind(theta/2)];
% qp = [cosd(theta/2),angax(1)*sind(theta/2),angax(2)*sind(theta/2),angax(3)*sind(theta/2)];
qs = quatmultiply(quatconj(qp),q);
qsx = quatmultiply(quatmultiply(qs,[0,X]),quatconj(qs));
qsy = quatmultiply(quatmultiply(qs,[0,Y]),quatconj(qs));
qsz = quatmultiply(quatmultiply(qs,[0,Z]),quatconj(qs));



figure(2)
hold on
axis([-1 1 -1 1 -1 1])
view([83,26])
% plot3([0,X(1)],[0,X(2)],[0,X(3)],'Color',[0.5 0 0]);
% plot3([0,Y(1)],[0,Y(2)],[0,Y(3)],'Color',[0 0.5 0]);
% plot3([0,Z(1)],[0,Z(2)],[0,Z(3)],'Color',[0 0 0.5]);

plot3([0,1],[0,0],[0,0],'k');
plot3([0,0],[0,1],[0,0],'k');
plot3([0,0],[0,0],[0,1],'k');
plot3([0,x],[0,y],[0,z],'c','LineWidth',1.5);
plot3([0,qx(2)],[0,qx(3)],[0,qx(4)],'--','Color',[1 0 0],'LineWidth',1.5);
plot3([0,qy(2)],[0,qy(3)],[0,qy(4)],'--','Color',[0 1 0],'LineWidth',1.5);
plot3([0,qz(2)],[0,qz(3)],[0,qz(4)],'--','Color',[0 0 0.8],'LineWidth',1.5);
plot3([0,p(1)],[0,p(2)],[0,p(3)],'Color',[0.5 0.5 0.75],'LineWidth',1.5);
text(8*tf+g(1),15*tf+g(2),tf+g(3),'Gravity','Rotation',270,'FontSize',15)
text(tf+qx(2),-5*tf+qx(3),10*tf+qx(4),'X','FontSize',15)
text(tf+qy(2),10*tf+qy(3),tf+qy(4),'Y','FontSize',15)
text(8*tf+qz(2),-10*tf+qz(3),tf+qz(4),'Z','FontSize',15)
text(tf+p(1),tf+p(2),5*tf+p(3),'$$\hat{P}$$','Interpreter','Latex','FontSize',15)
% text(-5*tf,tf,-5*tf,'q_S','FontSize',15)
% plot3([0,qsx(2)],[0,qsx(3)],[0,qsx(4)],'-.','Color',[1 0 0],'LineWidth',1.5);
% plot3([0,qsy(2)],[0,qsy(3)],[0,qsy(4)],'-.','Color',[0 1 0],'LineWidth',1.5);
% plot3([0,qsz(2)],[0,qsz(3)],[0,qsz(4)],'-.','Color',[0 0 1],'LineWidth',1.5);
plot3([0,g(1)],[0,g(2)],[0,g(3)],'Color',[0 0 0],'LineWidth',1);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'ZTick',[]);
set(gca,'Yticklabel',[]); 
set(gca,'Xticklabel',[]);
set(gca,'Zticklabel',[]); 
hold off


figure(1)
hold on
axis([-1 1 -1 1 -1 1])
view([83,26])
% plot3([0,X(1)],[0,X(2)],[0,X(3)],'Color',[0.5 0 0]);
% plot3([0,Y(1)],[0,Y(2)],[0,Y(3)],'Color',[0 0.5 0]);
% plot3([0,Z(1)],[0,Z(2)],[0,Z(3)],'Color',[0 0 0.5]);


plot3([0,1],[0,0],[0,0],'k');
plot3([0,0],[0,1],[0,0],'k');
plot3([0,0],[0,0],[0,1],'k');
plot3([0,x],[0,y],[0,z],'c','LineWidth',1.5);
plot3([0,qsx(2)],[0,qsx(3)],[0,qsx(4)],'--','Color',[1 0 0],'LineWidth',1.5);
plot3([0,qsy(2)],[0,qsy(3)],[0,qsy(4)],'--','Color',[0 1 0],'LineWidth',1.5);
plot3([0,qsz(2)],[0,qsz(3)],[0,qsz(4)],'--','Color',[0 0 0.8],'LineWidth',1.5);
plot3([0,p(1)],[0,p(2)],[0,p(3)],'Color',[0.5 0.5 0.75],'LineWidth',1.5);
text(8*tf+g(1),15*tf+g(2),tf+g(3),'Gravity','Rotation',270,'FontSize',15)
text(tf+qsx(2),-5*tf+qsx(3),10*tf+qsx(4),'X','FontSize',15)
text(tf+qsy(2),10*tf+qsy(3),tf+qsy(4),'Y','FontSize',15)
text(8*tf+qsz(2),-10*tf+qsz(3),tf+qsz(4),'Z','FontSize',15)
text(tf+p(1),tf+p(2),5*tf+p(3),'$$\hat{P}$$','Interpreter','Latex','FontSize',15)
% text(-5*tf,tf,-5*tf,'q_S','FontSize',15)
% plot3([0,qsx(2)],[0,qsx(3)],[0,qsx(4)],'-.','Color',[1 0 0],'LineWidth',1.5);
% plot3([0,qsy(2)],[0,qsy(3)],[0,qsy(4)],'-.','Color',[0 1 0],'LineWidth',1.5);
% plot3([0,qsz(2)],[0,qsz(3)],[0,qsz(4)],'-.','Color',[0 0 1],'LineWidth',1.5);
plot3([0,g(1)],[0,g(2)],[0,g(3)],'Color',[0 0 0],'LineWidth',1);
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'ZTick',[]);
set(gca,'Yticklabel',[]); 
set(gca,'Xticklabel',[]);
set(gca,'Zticklabel',[]); 
hold off

%%

Yrot = [cos((pi-0.1)/4),qsy(2)*sin((pi-0.1)/4),qsy(3)*sin((pi-0.1)/4),qsy(4)*sin((pi-0.1)/4)];
qsd = quatmultiply(quatconj(Yrot),qs);
qsdx = quatmultiply(quatmultiply(qsd,[0,X]),quatconj(qsd));
qsdy = quatmultiply(quatmultiply(qsd,[0,Y]),quatconj(qsd));
qsdz = quatmultiply(quatmultiply(qsd,[0,Z]),quatconj(qsd));

figure(2)
hold on
axis([-1 1 -1 1 -1 1])
view([35,8])
plot3([0,qsdx(2)],[0,qsdx(3)],[0,qsdx(4)],'-.','Color',[1 0 0],'LineWidth',1.5);
plot3([0,qsdy(2)],[0,qsdy(3)],[0,qsdy(4)],'-.','Color',[0 1 0],'LineWidth',1.5);
plot3([0,qsdz(2)],[0,qsdz(3)],[0,qsdz(4)],'-.','Color',[0 0 1],'LineWidth',1.5);
plot3([0,g(1)],[0,g(2)],[0,g(3)],'Color',[0 0 0],'LineWidth',1);
text(tf+qsdx(2),-5*tf+qsdx(3),10*tf+qsdx(4),'X''','FontSize',15)
text(15*tf+qsdy(2),10*tf+qsdy(3),tf+qsdy(4),'Y''','FontSize',15)
text(-8*tf+qsdz(2),tf+qsdz(3),tf+qsdz(4),'Z''','FontSize',15)
text(-10*tf+g(1),5*tf+g(2),tf+g(3),'Gravity','Rotation',270,'FontSize',15)
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'ZTick',[]);
set(gca,'Yticklabel',[]); 
set(gca,'Xticklabel',[]);
set(gca,'Zticklabel',[]); 
hold off