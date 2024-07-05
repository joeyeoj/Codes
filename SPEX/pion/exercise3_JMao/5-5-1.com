data inst_amo1 bhiw_amo1
plot device xs
    
dist 0.01158 z
comp reds
comp hot
comp pow
com mbb
log exe 5-2-2result
    
com pion
par 1 5 xil val 2
par 1 5 xil s f
par 1 5 nh val 1e-5
com rel 3:4 5,1,2

cal
pl ty model
pl fill disp f
pl ux ang
pl uy ang
pl x lin
pl y log
pl rx 0:30
pl
