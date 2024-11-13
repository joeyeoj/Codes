plot rx 0 : 5
plot
ignore 0 : 2 unit ang
plot
data show
plot rx 0 : 30
plot
plot rx 20 : 30
plot
plot ry 0 : 100
plot
plot rx 24 : 30
plot
plot rx 25 : 30
plot
plot rx 20 : 30
plot
plot rx 25 : 30
plot
plot ry 0 : 100
plot
plot ry 0 : 60
plot
ignore 26 : 30 unit ang
plot
plot rx 2 : 26
plot
plot ry 0 : 350
plot
obin 2 : 26 unit ang
plot
fit
plot
model show
par 1 2 nh status t
par 1 3 norm status f
par 1 3 gamm status f
par 1 4 norm status f
par 1 4 t status f
par show free
fit
plot
par 1 2 nh status f
par 1 2 t status t
fit
par 1 2 t status f
par show free
par 1 2 fcov status t
fit
plot
par 1 2 fcov status f
par 1 2 v status t
fit
plot
par 1 2 v status f
par 1 2 rms status t
fit
plot
par 1 2 rms status f
par 1 2 zv status t
fit
plot
par 1 2 zv value 0
par 1 2 zv status f
par 1 2 v status t
fit
par 1 2 v status f
plot
comp pion
comp delete 7
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 gamm status t
fit
par 1 3 gamm status f
par 1 4 norm status t
fit
plot
par 1 4 norm status f
par 1 4 t status t
fit
par 1 4 t status f
plot
comp pion
comp relation 4 7 , 1 , 2
comp relation 3 5 , 6 , 7 , 1 , 2
model show
par 1 7 xil value 1
calculate
plot
fit
par 1 7 xil value 1
par 1 7 xil status f
par show free
fit
par 1 7 nh status f
par 1 7 xil status t
fit
par 1 7 xil status f
par 1 7 fcov status t
par show free
fit
plot
par 1 7 fcov status f
par 1 7 v status t
fit
par 1 7 v status f
plot
par 1 7 rms status t
fit
plot
par 1 7 rms status f
par 1 7 zv status t
fit
plot
par 1 7 zv status f
par 1 7 nh status t
fit
par show free
plot
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 7 xil value 1.363843
par 1 7 nh status t
fit
plot
par 1 7 xil status t
fit
plot
par 1 7 nh status f
par 1 7 xil status f
par 1 7 xil value 1
calculate
plot
par 1 7 nh value 1e-4
calculate
plot
par 1 7 nh value 1e-3
calculate
plot
par 1 7 nh status f
par 1 7 xil status f
par 1 7 nh status t
fit
plot
par 1 7 nh status f
par 1 7 xil range 0 : 2
fit
par 1 7 xil status t
plot
calculate
plot
fit
par 1 7 nh status t
fit
calculate
plot
model show
comp delete 7
comp pion
comp relation 3 5 , 6 , 7 , 1 , 2
comp relation 4 7 , 1 , 2
calculate
plot
par show 1 7
par 1 7 xil status f
par 1 7 nh value 1e-3
calculate
plot
par show 1 7
par 1 7 nh value 1e-4
calculate
plot
par show 1 7
par 1 7 nh value 5e-3
calculate
plot
par 1 7 nh value 1e-3
calculate
plot
par 1 7 nh value 1e-4
calculate
plot
par 1 7 nh value 5e-4
calculate
plot
par show free
par 1 7 nh status t
fit
plot
par 1 7 nh status f
par 1 7 xil value 1
calculate
plot
par show free
par 1 7 xil value 0.5
calculate
plot
par show free
par 1 7 xil value 1.5
calculate
plot
par 1 7 xil value 1
calculate
plot
par 1 7 xil value 1.3
calculate
plot
par 1 7 xil value 0.8
calculate
plot
par 1 7 xil value 0.7
calculate
plot
par 1 7 xil value 0.8
calculate
plot
par 1 7 xil status f
par 1 7 nh status t
fit
plot
par show free
par 1 7 nh status f
par 1 7 fcov status t
fit
plot
par 1 7 fcov status f
par 1 7 zv status t
fit
plot
par 1 7 zv status f
par 1 7 v status t
fit
plot
