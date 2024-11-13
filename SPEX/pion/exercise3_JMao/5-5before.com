data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
log exe 5-2-2result
com etau
com etau
par 1 5 a val -1
par 1 5 a s f
par 1 5 tau0 val 1.3605E-2
par 1 5 tau0 s f
par 1 6 a val 1
par 1 6 a s f
par 1 6 tau0 val 0.0735
par 1 6 tau0 s f
com rel 4 1,2
com rel 3 5,6,1,2

cal
plot type data
pl ux ang
pl uy fang
pl ry 0:350
pl

