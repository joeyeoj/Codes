data inst_amo1 bhiw_amo1
plot device xs
# use different x- ang y-axis unit.
plot type data
plot ux ang
plot uy fang
plot
plot ux kev
plot uy fkev
plot
plot ux ang
plot uy ang
plot
plot ux kev
plot uy kev
plot

plot type data
plot ux ang
plot uy fang
plot
dist 0.01158 z 
comp reds
par 1 1 z value 0.01158
par 1 1 z status f
comp hot
par 1 2 nh value 8.5e-3
par 1 2 nh status f
par 1 2 t s f
comp pow
ign 5:30 unit ang
par 1 3 norm val 5e8
fit
use 5:30 unit ang
pl ux ang
pl uy fang
pl
comp mbb
com rel 3:4 1,2
par 1 3 norm val 7.66e7
par 1 3 gamm val 0.57
par 1 4 norm val 2.89e6
par 1 4 t val 0.49
cal
pl
fit
com pion
com pion
com rel 3:4 6,5,1,2
