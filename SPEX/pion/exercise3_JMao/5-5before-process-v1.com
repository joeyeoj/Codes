par show
fit
plot
model show
comp pion
comp relation 4 7 , 1 , 2
comp relation 3 5 , 6 , 7 , 1 , 2
model show
par 1 7 xil value 1
calculate
plot
fit
plot
par 1 7 fcov status t
fit
par 1 7 fcov status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par show 1 7
par 1 7 rms status t
fit
par 1 7 rms status f
par 1 7 zv status t
fit
par 1 7 zv status f
par 1 7 fcov status t
fit
par 1 7 fcov status f
par 1 7 v status t
fit
par 1 7 v status f
par 1 7 rms status t
fit
par 1 7 rms status f
plot
plot rx 10 : 15
plot rx 15 : 20
plot
plot ry 0 : 250
plot
plot rx 10 : 15
plot ry 0 : 350
plot
comp pion
log output 5-5-1pion
par show
log output close
log close output
log output 5-5-1pion overwrite
log close output
comp delete 8
log output 5-5-1pion overwrite
par show
model show
log output close
log close output
comp pion
model show
comp relation 3 5 , 6 , 8 , 7 , 1 , 2
comp relation 4 8 , 7 , 1 , 2
model show
par 1 8 xil value 2
calculate
plot
par show
fit
par 1 8 fcov status t
fit
par 1 8 fcov status f
par 1 8 v status t
fit
par 1 8 v status f
par 1 8 rms status t
fit
par 1 8 rms status f
par 1 8 zv status t
fit
par 1 8 zv status f
plot
par 1 8 fcov status t
fit
par 1 8 fcov status f
par 1 8 v status t
fit
par show 1 8
par 1 8 v status f
plot
par 1 8 rms status t
fit
par 1 8 rms status f
plot
par 1 2 nh status t
fit
par show 1 2
par 1 2 nh status f
par 1 2 t status t
fit
par 1 2 t status f
plot
par show
par 1 2 fcov status t
fit
par show 1 2
par 1 2 fcov status f
plot
par 1 2 v status t
fit
plot
par 1 2 v status f
par 1 2 rms status t
fit
par 1 2 rms status f
par 1 2 zv status t
fit
par 1 2 zv status f
plot
par show
par 1 2 v status t
fit
par 1 2 v status f
par 1 2 rms status t
fit
par 1 2 rms status f
plot
par 1 8 fcov value 0.5
calculate
plot
par 1 8 fcov value 1
calculate
plot
par 1 2 v status t
par 1 7 v status t
par 1 8 v status t
fit
plot
par 1 2 v status f
par 1 7 v status f
par 1 8 v status f
par 1 2 rms status t
par 1 7 rms status t
par 1 8 rms status t
fit
par 1 2 rms status f
par 1 7 rms status f
par 1 8 rms status f
par 1 2 zv status t
par 1 7 zv status t
par 1 8 zv status t
fit
par 1 8 zv status f
par 1 7 zv status f
par 1 2 zv status f
plot
par 1 2 v status t
par 1 7 v status t
par 1 8 v status t
fit
par 1 8 v status f
par 1 7 v status f
par 1 2 v status f
plot
par show
par 1 3 norm status f
par 1 3 gamm status f
par 1 4 norm status f
par 1 4 t status f
par 1 2 nh status t
par 1 2 t status t
par show
fit
par 1 2 nh status f
par 1 2 t status f
fit
par 1 7 nh status f
par 1 7 xil status f
par 1 8 nh status f
par 1 8 xil status f
par 1 7 fcov status t
par 1 8 fcov status t
fit
plot
par 1 8 fcov status f
par 1 7 fcov status f
par 1 7 v status t
par 1 8 v status t
fit
plot
par 1 7 v status f
par 1 8 v status f
par 1 7 rms status t
par 1 8 rms status t
fit
par 1 8 rms status f
par 1 7 rms status f
par 1 7 zv status t
par 1 8 zv status t
fit
par 1 7 zv status f
par 1 8 zv status f
par show
par 1 2 nh status t
fit
par 1 2 nh status f
par 1 2 t status t
fit
par 1 2 t status f
par 1 2 zv status t
fit
par 1 2 zv status f
par 1 2 v status t
fit
par 1 2 v status f
par 1 2 rms status t
fit
par 1 2 rms status f
par 1 2 fcov status t
fit
par 1 2 fcov status f
par 1 7 nh status t
fit
par 1 7 nh status f
par 1 7 xil status t
fit
par 1 7 xil status f
par 1 7 fcov status t
fit
par 1 7 fcov status f
par 1 7 zv status t
fit
par 1 7 zv status f
par 1 7 v status t
fit
par 1 7 v status f
par 1 7 rms status t
fit
par 1 7 rms status f
par 1 8 nh status t
fit
par 1 8 nh status f
par 1 8 xil status t
plot
fit
par 1 8 xil status f
par 1 8 fcov status t
fit
par 1 8 fcov status f
par 1 8 zv status t
fit
par 1 8 zv status f
par 1 8 v status t
fit
par 1 8 v status f
par 1 8 rms status t
fit
par 1 8 rms status f
par show 1 7
par 1 7 dv status t
par show free
fit
par 1 7 dv value 100
par 1 7 dv status f
plot
plot rx 0 : 30
plot
