data inst_amo1 bhiw_amo1
plot device xs

ignore 5:30 unit ang
dist 0.01158 z
comp reds
comp hot
comp pow
log exe 5-2-1result
com rel 3 1,2

cal
plot type data
plot ux ang
plot uy fang
pl
