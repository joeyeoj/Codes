data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
log exe 5-2-2result
com rel 3:4 1,2

cal
plot type data
pl ux ang
pl uy fang
pl ry 0:350
pl

