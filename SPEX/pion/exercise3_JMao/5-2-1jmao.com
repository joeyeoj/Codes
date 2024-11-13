data inst_amo1 bhiw_amo1
plot device xs

ignore 5:30 unit ang
dist 0.01158 z
comp reds
par 1 1 z value 0.01158
par 1 1 z status f
comp hot
par 1 2 nh value 8.5e-3
par 1 2 nh status f
par 1 2 t s f
comp pow
par 1 3 norm val 5e8
com rel 3 1,2
cal
plot type data
plot ux ang
plot uy fang
pl
fit
pl
model show
par show free
quit

