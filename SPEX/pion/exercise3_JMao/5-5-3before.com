data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
log exe 5-2-2result

com pion
com rel 3:4 5,1,2
par 1 5 xil val 1
cal
pl ty data
pl ux ang
pl uy fang
pl
fit
pl
