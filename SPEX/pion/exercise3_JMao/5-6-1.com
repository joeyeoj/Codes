data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
com pion
log exe 5-5-3result

com pion
com rel 3:4 6,5,1,2
par 1 5 xil val 2.7
cal
pl ty data
pl ux ang
pl uy fang
pl
fit
pl
