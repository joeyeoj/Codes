data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
com rel 3:4 1,2
log exe 5-2-2result
cal
pl ty data
pl ux ang
pl uy fang
pl
