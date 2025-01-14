%% Initialization section
clear all; close all;clc;
prompt1 = 'Please enter the subject ID given for the user: ';
SUBJECTID = input(prompt1);
prompt2 = 'Please enter the ID to be tested: ';
markers = string(input(prompt2,'s'));
% markers = ["lef","lbd","lelb","lelb1","lie","ref","rbd","relb","relb1","rie"];

%Kinect initialization script
addpath('F:\github\wearable-jacket\matlab\KInectProject\Kin2');
addpath('F:\github\wearable-jacket\matlab\KInectProject\Kin2\Mex');
addpath('F:\github\wearable-jacket\matlab\KInectProject');
addpath('F:\github\wearable-jacket\matlab\WISE_KNT');
k2 = Kin2('color','depth','body','face');
outOfRange = 4000;

sz1 = screensize(1);
c_width = sz1(3); c_height = sz1(4);COL_SCALE = 1;
color = zeros(c_height*COL_SCALE,c_width*COL_SCALE,3,'uint8');
c.h = figure('units', 'pixels', 'outerposition', sz1);
c.ax = axes;
color = imresize(color,COL_SCALE);
c.im = imshow(color, 'Parent', c.ax);

set( figure(1) , 'DoubleBuffer', 'on','keypress','k=get(gcf,''currentchar'');' );

%COM Port details
instrreset
ser = serial('COM15','BaudRate',115200);
ser.ReadAsyncMode = 'continuous';
fopen(ser);
k=[];

%Angle initialization for WISE+KINECT system
limuef = 0;rimuef = 0;lkinef = 0;rkinef = 0;
limubd = 0;rimubd = 0;lkinbd = 0;rkinbd = 0;
limuie = 0;rimuie = 10;lkinie = 0;rkinie = 0;
limuelb = 0;rimuelb = 0;lkinelb = 0;rkinelb = 0;
% limuelb1 = 0;rimuelb1 = 0;lkinelb1 = 0;rkinelb1 = 0;
ls = 0;rs = 1350;lw = 475;H = 1080;rw = 570;     
qC = [1,0,0,0];qD = [1,0,0,0];qA = [1,0,0,0];qB = [1,0,0,0];qE = [1,0,0,0];
lshoangle = [0,0,0,0,0]';
rshoangle = [0,0,0,0,0]';


%%  Complete routine for updating data with 10 different angles

sz2 = screensize(2);
figure('units', 'pixels', 'outerposition', sz2)

kinect_ang = zeros(8,1);

arg = char(markers);    
[anline,anline1,fid] = TitleUpdate_red(arg,SUBJECTID);
lc=1;l=0;lflag = 0;telapsed=0;
while (lc) 
   tstart = tic;
   validData = k2.updateData;
   if ser.BytesAvailable && validData
       depth = k2.getDepth;color = k2.getColor;face = k2.getFaces;
       depth8u = uint8(depth*(255/outOfRange));depth8uc3 = repmat(depth8u,[1 1 3]);
       [bodies, fcp, timeStamp] = k2.getBodies('Quat');
       numBodies = size(bodies,2);
       
       if numBodies == 1

       pos2Dxxx = bodies(1).Position; 
       [qA,qB,qC,qD,qE] = DataReceive(ser,qA,qB,qC,qD,qE);

       lshoangle = get_Left(qE,qC,qA);
       limuef = lshoangle(1);
       limubd = lshoangle(2);
       limuie = lshoangle(3); 
       limuelb = lshoangle(4);
%        limuelb1 = lshoangle(5);
       
       rshoangle = get_Right(qE,qD,qB);
       rimuef = rshoangle(1);
       rimubd = rshoangle(2);
       rimuie = rshoangle(3);
       rimuelb = rshoangle(4);
%        rimuelb1 = rshoangle(5);

       kinect_ang = get_Kinect(pos2Dxxx);
       lkinef = kinect_ang(1);
       rkinef = kinect_ang(2);
       lkinbd = kinect_ang(3);
       rkinbd = kinect_ang(4);
       lkinie = kinect_ang(5);
       rkinie = kinect_ang(6);
       lkinelb = kinect_ang(7);
       rkinelb = kinect_ang(8); 
           
       figure(1)
       color = imresize(color,COL_SCALE);c.im = imshow(color, 'Parent', c.ax);
       rectangle('Position',[0 0 475 1080],'LineWidth',3,'FaceColor','k');  
       rectangle('Position',[1350 0 620 1080],'LineWidth',3,'FaceColor','k');
       k2.drawBodies(c.ax,bodies,'color',3,2,1);k2.drawFaces(c.ax,face,5,false,20);
       
           switch arg
                case 'lef'
                    kin = lkinef; imu = limuef;
                    lim = kin;
%                     tlow = 10; thigh=120;
                case 'lbd'
                    kin = lkinbd; imu = limubd;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'lelb'
                    kin = lkinelb; imu = limuelb;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'lelb1'
                    kin = lkinelb; imu = limuelb;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'lie'
                    kin = lkinie; imu = limuie;
                    lim = imu;
%                     tlow = -40; thigh=40;
                case 'ref'
                    kin = rkinef; imu = rimuef;
                    lim = kin;
%                     tlow = 10; thigh=120;
                case 'rbd'
                    kin = rkinbd; imu = rimubd;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'relb'
                    kin = rkinelb; imu = rimuelb;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'relb1'
                    kin = rkinelb; imu = rimuelb;
                    lim = kin;
%                     tlow = 30; thigh=100;
                case 'rie'
                    kin = rkinie; imu = rimuie;
                    lim = imu;
%                     tlow = -40; thigh=40;
           end
           updateWiseKinect_red(arg,kin,imu,telapsed,anline,anline1)
           %'Timestamp','Kinect_LeftShoulder_Ext.-Flex.','IMU_LeftShoulder_Ext.-Flex.','Kinect_LeftShoulder_Abd.-Add.','IMU_
           % LeftShoulder_Abd.-Add.','Kinect_LeftShoulder_Int.-Ext.','IMU_LeftShoulder_Int.-Ext.','Kinect_LeftElbow_Ext.-Flex.','IMU_LeftElbow_Ext.-Flex.',
           %'Kinect_RightShoulder_Ext.-Flex.','IMU_RightShoulder_Ext.-Flex.','Kinect_RightShoulder_Abd.-Add.','IMU_RightShoulder_Abd.-Add.',
           %'Kinect_RightShoulder_Int.-Ext.','IMU_RightShoulder_Int.-Ext.','Kinect_RightElbow_Ext.-Flex.','IMU_RightElbow_Ext.-Flex.');
           fprintf( fid, '%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f\n',telapsed,...
           lkinef,limuef,lkinbd,limubd,lkinie,limuie,lkinelb,limuelb,rkinef,rimuef,...
           rkinbd,rimubd,rkinie,rimuie,rkinelb,rimuelb);
       
           
       end

       if numBodies == 0
           figure(1)
           s1 = strcat('No persons in view');   
           text((1920/2) - 250,100,s1,'Color','red','FontSize',30,'FontWeight','bold');
       end      
       if numBodies > 1
           while numBodies > 1
           validData = k2.updateData;
            if validData
               depth = k2.getDepth;color = k2.getColor;face = k2.getFaces;
               depth8u = uint8(depth*(255/outOfRange));depth8uc3 = repmat(depth8u,[1 1 3]);
               [bodies, fcp, timeStamp] = k2.getBodies('Quat');
               numBodies = size(bodies,2);
               figure(1)
               s1 = strcat('Too many people in view');
               text(1920/2,100,s1,'Color','red','FontSize',30,'FontWeight','bold');
            end
           end
       end
       if ~isempty(k)
           if strcmp(k,'q') 
               fclose(fid);
               k=[];
               break; 
           end
       end
   end

pause(0.02);
telapsed = telapsed+toc(tstart);
end
disp(telapsed);

%% Closing everything 

close figure 1 figure 2
fclose(ser);
delete(ser);
close all;clear all;
instrreset

