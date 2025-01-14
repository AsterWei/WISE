clc
clear all
close all
t = 0 ;
x = 0 ;
startSpot = 0;
interv = 100; % No. of samples
step = 0.5 ; % lowering step has a number of cycles and then acquire more data
while ( t <interv )
    b = sin(t)+5;
    x = [ x, b ];
    plot(x) ;
      if ((t/step)-500 < 0)
          startSpot = 0;
      else
          startSpot = (t/step)-500;
      end
      axis([ startSpot, (t/step+50), 0 , 10 ]);
      grid off
      t = t + step;
      drawnow;
      pause(0.01)
  end