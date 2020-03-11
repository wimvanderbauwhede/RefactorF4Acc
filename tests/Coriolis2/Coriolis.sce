//*******************************************
// This is the Scilab script for Exercise 4.
//
// Use the help facility for more information 
// on individual functions used.
//
// Author: J. Kaempf, 2008
//********************************************
// Animation of the Coriolis force

clf(); clear;
set("figure_style","new");
a=get("current_axes"); a.parent.figure_size= [600,600];

x=read("output1.txt",-1,3); // read input data

fre = x(1,1); dt = x(1,2); ntot = x(1,3);
radius = 20; xset('pixmap',1);
factor = 0.9; fac2 = factor*radius; // needed for graphics

for n=2:ntot

scf(0);

time = x(n,3); xr = x(n,1); yr = x(n,2);

//xbasc() // clears graphic window
xset('wwpc'); //clears pixmap

// isoview scaling 
plot2d(0,0,-1,"030"," ",[-20,-20,20,20]);

// draw circular, blue dish = our tank 
xset("color",2)
xfarc(-fac2,fac2,2*fac2,2*fac2,0,360*64)

// rotate outer ticks to visualise relative rotation of the tank

xx = radius*sin(fre*time);
yy = radius*cos(fre*time);

x1 = [factor*xx xx];
y1 = [factor*yy yy];
xset("color",5)
xset("thickness",6)
xpoly(x1,y1,"lines",1)

xx = radius*cos(fre*time);
yy = -radius*sin(fre*time);

x2 = [factor*xx xx];
y2 = [factor*yy yy];
xset("color",0)
xset("thickness",6)
xpoly(x2,y2,"lines",1)

xx = -radius*sin(fre*time);
yy = -radius*cos(fre*time);

x3 = [factor*xx xx];
y3 = [factor*yy yy];
xset("color",0)
xset("thickness",6)
xpoly(x3,y3,"lines",1)

xx = -radius*cos(fre*time);
yy = radius*sin(fre*time);

x4 = [factor*xx xx];
y4 = [factor*yy yy];
xset("color",0)
xset("thickness",6)
xpoly(x4,y4,"lines",1)

// inner ticks remain motionless

xset("color",2)
xfarc(-fac2,fac2,2*fac2,2*fac2,0,360*64)

x1 = [0 0];
y1 = [factor*fac2 fac2];
xset("color",5)
xset("thickness",6)
xpoly(x1,y1,"lines",1)

x1 = [0 0];
y1 = [-fac2 -factor*fac2];
xset("color",0)
xset("thickness",6)
xpoly(x1,y1,"lines",1)

y1 = [0 0];
x1 = [factor*fac2 fac2];
xset("color",0)
xset("thickness",6)
xpoly(x1,y1,"lines",1)

y1 = [0 0];
x1 = [-fac2 -factor*fac2];
xset("color",0)
xset("thickness",6)
xpoly(x1,y1,"lines",1)

//draw location
xset("color",1); xfarc(xr-1,yr+1,2.0,2,0,360*64);
xset("color",7); xfarc(xr-0.8,yr+0.8,1.6,1.6,0,360*64);

//draw trajectory
xset('thickness',4)
plot2d(x(2:n,1),x(2:n,2),8,'000','',[-radius,-radius,radius,radius])

//add title
t=a.title; t.foreground=1; t.font_size=12; t.font_style=4;
t.text="Rotating Frame of Reference";

// creation of GIF files (optional)

//if n < 10 then
//  xs2gif(0,'ex100'+string(n)+'.gif')
//else
//  if n < 100 then
//    xs2gif(0,'ex10'+string(n)+'.gif')
//  else
//    xs2gif(0,'ex1'+string(n)+'.gif')
//  end
//end


xpause(5d2); xset('wshow');

end // end of animation

