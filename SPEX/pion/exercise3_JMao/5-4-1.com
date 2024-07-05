data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
com rel 3:4 1,2
log exe 5-2-2result

com del 2
cal
pl ty model
pl ux kev
pl uy iw
pl fill disp f
pl rx 1e-4:1e4
pl x log
pl y log
pl
