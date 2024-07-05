data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
com pion
com rel 3:4 5,1,2
log exe 5-5-3result
cal
pl ty data
pl ux ang
pl uy fang
pl
