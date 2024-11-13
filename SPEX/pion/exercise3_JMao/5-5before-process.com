fit
plot
comp pion
comp relation 4 7 , 1 , 2
comp relation 3 5 , 6 , 7 , 1 , 2
model show
par show 7
par show
par 1 7 xil value 1
calculate
plot
fit
plot
par 1 7 fcov status t
fit
plot
par 1 7 fcov status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 rms status t
fit
par show 1 7
par 1 7 rms status f
par 1 7 zv status t
fit
plot
par 1 7 zv status f
par 1 7 fcov status t
fit
par 1 7 fcov status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 rms status t
fit
par 1 7 rms status f
plot rx 10 : 20
plot
plot rx 15 : 20
plot
plot ry 0 : 250
plot
plot rx 10 : 15
plot
plot ry 0 : 350
plot
plot rx 20 : 25
plot
plot ry 0 : 100
plot
plot ry 0 : 350
plot rx 10 : 15
plot
comp pion
par show
model show
log close outputpa
par write 5-5-1pion
comp delete 8
log output 5-5-1pion overwrite
par show
model show
log output close
par write 5-5-1pion overwrite
log close output
comp pion
comp relation 3 5 , 6 , 8 , 7 , 1 , 2
comp relation 4 8 , 7 , 1 , 2
par show 1 8
par show 1 7
par 1 8 xil value 2
calculate
plot
plot rx 0 : 30
plot
fit
plot
par 1 8 fcov status t
fit
par 1 8 fcov status f
par 1 8 v status t
fit
plot
par 1 8 v status f
par 1 8 rms status t
fit
par 1 8 rms status f
par 1 8 zv status t
fit
par 1 8 zv status f
plot
par 1 8 v status t
fit
par 1 8 v status f
plot
par 1 8 rms status t
fit
par 1 8 rms status f
plot
fit
plot
par 1 2 nh status t
fit
par 1 2 nh status f
par 1 2 t status t
fit
par 1 2 t status f
plot
model show
par show 1 5
par show 1 6
par 1 6 tau0 value 1/13.605
calculate
plot
par show 1 6
par 1 6 tau0 value 0.0735
calculate
plot
par show 1 6
