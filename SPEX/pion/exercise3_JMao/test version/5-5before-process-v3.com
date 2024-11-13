ignore 0 : 2 unit ang
ignore 26 : 30 unit ang
plot
par show
plot rx 20 : 26
plot
plot ry 0 : 150
plot
par 1 4 norm status t
par 1 4 norm status f
par 1 4 t status f
par 1 3 gamm status f
calculate
plot
fit
plot
plot rx 2 : 26
plot
plot ry 0 : 350
plot
par 1 3 norm value 1e8
calculate
plot
par 1 3 norm value 5e8
calculate
plot
par 1 3 norm value 6e8
calculate
plot
par 1 3 norm value 5.5e8
calculate
plot
par 1 3 norm value 5.1e8
calculate
plot
par 1 3 norm value 5.2e8
par 1 3 norm value 5e8
calculate
plot
fit
par 1 3 norm status f
par 1 3 gamm status t
par 1 3 gamm value 2
calculate
plot
par 1 3 gamm value 1
calculate
plot
par 1 3 gamm value 1.5
calculate
plot
par 1 3 gamm value 1.6
calculate
plot
par 1 3 gamm value 1.55
calculate
plot
par 1 3 gamm value 1.65
calculate
plot
par 1 3 gamm value 1.6
calculate
plot
fit
par 1 3 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 gamm status t
fit
plot
par 1 3 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 gamm status t
calculate
fit
plot
par 1 3 gamm value 1.7
calculate
plot
par 1 3 gamm value 1.62
calculate
plot
par 1 3 gamm value 1.59
calculate
plot
par 1 3 gamm value 1.58
calculate
plot
par 1 3 norm value 5e8
calculate
plot
par 1 3 norm value 4.8e8
calculate
plot
par 1 3 norm value 4.6e8
calculate
plot
par 1 3 gamm value 1.6
calculate
plot
par 1 3 gamm value 1.56
calculate
plot
par 1 3 gamm value 1.55
calculate
plot
par show free
fit
plot
par 1 3 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 4 norm status t
par 1 4 norm value 1e9
calculate
plot
par 1 4 norm value 1.5e9
calculate
plot
par 1 4 t value 0.1
calculate
plot
par 1 4 t value 0.2
calculate
plot
par 1 4 t value 0.15
calculate
plot
par 1 4 t value 0.12
calculate
plot
par 1 4 t value 0.15
calculate
plot
par 1 4 t value 0.16
calculate
plot
par 1 4 t value 0.17
calculate
plot
par 1 4 t value 0.165
calculate
plot
par show free
fit
plot
par 1 4 norm status f
par 1 4 t status t
fit
par 1 4 t status f
plot
par 1 2 nh status t
par 1 2 nh value 1e-3
calculate
plot
par 1 2 nh value 5e-3
calculate
plot
par 1 2 nh value 8e-3
calculate
plot
par 1 2 nh value 8.5e-3
calculate
plot
par 1 2 t value 1e-5
calculate
plot
par 1 2 t value 1e-6
calculate
plot
par 1 2 t value 1e-1
calculate
plot
par 1 2 t value 1e-2
calculate
plot
par 1 2 t value 1e-3
calculate
plot
par 1 2 t value 1e-4
calculate
plot
par 1 2 t value 1e-5
calculate
plot
par 1 2 t value 1e-4
calculate
plot
par 1 2 t value 5e-5
calculate
plot
par show free
fit
par 1 2 nh status f
par 1 2 t status t
plot
fit
plot
par 1 2 t value 1e6
par 1 2 t value 1e5
par 1 2 t value 1e-5
calculate
plot
par 1 2 t value 5e-5
calculate
plot
par 1 2 t value 5e-6
calculate
plot
fit
par 1 2 t status f
par 1 2 nh status t
fit
plot
par 1 2 nh status f
par 1 2 t status t
fit
plot
par 1 2 nh value 1e4
calculate
par 1 2 nh value 1e-4
calculate
plot
par 1 2 nh value 1e-3
calculate
plot
par 1 2 nh value 8.5458485E-03
calculate
plot
par 1 2 nh value 8E-03
calculate
plot
par 1 2 t value 1e-4
calculate
plot
par 1 2 nh value 7.8E-03
calculate
plot
par 1 2 t value 5e-4
calculate
plot
par 1 2 t value 1e-4
calculate
plot
par 1 2 t value 2e-4
calculate
plot
par 1 2 t value 1e-4
calculate
plot
par 1 2 t status f
par show free
par 1 2 rt status t
par 1 2 rt status f
par 1 2 fcov status t
fit
par 1 2 fcov status f
par 1 2 v status t
fit
plot
par 1 2 v value 0
calculate
plot
par 1 2 v value 100
calculate
plot
par 1 2 rms status t
par show free
par 1 2 v status f
fit
plot
par 1 2 rms status f
par 1 2 zv status t
fit
plot
par 1 2 zv status f
comp pion
model show
comp relation 3 5 , 6 , 7 , 1 , 2
comp relation 4 7 , 1 , 2
par 1 7 xil value 1
calculate
plot
par show 1 7
par 1 7 nh value 1e-4
calculate
plot
par 1 7 nh value 1e-3
calculate
plot
par 1 7 nh value 1e-5
calculate
plot
par 1 7 nh value 5e-5
calculate
plot
par 1 7 xil status f
fit
plot
par show 1 7
plot rx 15 : 20
plot
par 1 7 xil value 1.2
calculate
plot
par 1 7 xil value 1
calculate
plot
par 1 7 xil value 0.8
calculate
plot
par 1 7 xil value 1
calculate
plot
fit
plot
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 7 nh status t
fit
plot
par 1 7 nh status f
par 1 7 fcov status t
fit
par 1 7 fcov status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 zv status t
fit
plot
par 1 7 zv status f
par 1 7 z status t
fit
plot
par 1 7 nh status t
par 1 7 v status f
par show free
par 1 7 zv status f
fit
plot
par show free
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 gamm status t
fit
plot
