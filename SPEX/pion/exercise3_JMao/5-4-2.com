data inst_amo1 bhiw_amo1
plot device xs

dist 0.01158 z
comp reds
comp pow
com mbb
log exe 5-4-1result

com etau
com etau
com rel 2 5,4,1
com rel 3 1
par 1 4 a val -1
par 1 4 a s f
par 1 4 tau0 val 1.3605E-2
par 1 4 tau0 s f
par 1 5 a val 1
par 1 5 a s f
par 1 5 tau0 val 13.605
par 1 5 tau0 s f
cal
pl ty model
pl ux kev
pl uy iw
pl fill disp f
pl rx 1e-4:1e4
pl ry 1e-20:1e-10
pl x log
pl y log
pl
