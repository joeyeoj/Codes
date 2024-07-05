data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
com pion
log exe 5-5-1result
com rel 3:4 5,1,2
cal
pl ty data
pl ux ang
pl uy fang
pl
