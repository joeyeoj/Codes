data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com rel 3 1,2
log exe 5-2-1result
cal
plot type data
pl ux ang
pl uy fang
pl

com mbb
par 1 3 norm val 7.66e7
par 1 3 gamm val 0.57
par 1 4 norm val 2.89e6
par 1 4 t val 0.49
com rel 3:4 1,2
cal
fit
pl
