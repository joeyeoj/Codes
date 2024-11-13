plot
calculate
plot
par show
par 1 4 norm status f
par 1 4 t status f
fit
plot
par 1 3 norm status f
par 1 3 gamm status f
par 1 2 nh status t
fit
plot
par 1 2 nh status f
par 1 2 t status f
par 1 2 t status t
fit
plot
par 1 2 t status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 gamm status f
fit
plot
par 1 3 gamm status t
fit
plot
par 1 3 gamm status f
par 1 4 norm status t
fit
plot
par 1 4 norm status f
par 1 4 t status t
fit
plot
par 1 4 t status f
par 1 3 norm value 1e9
calculate
plot
par 1 3 norm value 4.0980195E+08
calculate
plot
par 1 3 gamm value 2
calculate
plot
par 1 3 gamm value 1.456977
par 1 4 norm value 1e8
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 4 norm value 1.5e9
calculate
plot
par 1 4 t value 0.18
calculate
plot
par 1 4 t value 0.19
calculate
plot
par 1 4 norm value 1e9
calculate
plot
par 1 4 norm value 8e8
calculate
plot
par 1 4 norm value 5e8
calculate
plot
par 1 4 norm value 7e8
calculate
plot
par 1 4 norm value 1e9
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 4 t value 0.16
calculate
plot
par 1 4 t value 0.17
calculate
plot
par 1 4 t value 0.18
calculate
plot
par 1 4 t value 0.19
calculate
plot
par 1 4 t value 0.2
calculate
plot
par 1 4 norm value 1e8
calculate
plot
par 1 4 norm value 1e9
calculate
plot
par 1 4 norm value 8e8
calculate
plot
par 1 3 norm value 1e8
calculate
plot
par 1 3 norm value 4.0980195E+08
calculate
plot
par 1 4 t value 0.1673702
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 3 norm value 1e8
calculate
plot
par 1 3 norm value 4.0980195E+08
calculate
plot
par 1 3 norm value 5e8
calculate
plot
par 1 3 norm value 4.0980195E+08
calculate
plot
par 1 3 gamm value 1.456977
calculate
plot
par 1 3 gamm value 2
calculate
plot
par 1 3 gamm value 1
calculate
plot
par 1 3 gamm value 1.456977
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 4 norm value 1.5e9
calculate
plot
par 1 4 norm value 3e9
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 4 t value 0.1673702
calculate
plot
par 1 4 t value 0.2
calculate
plot
par 1 4 t value 0.18
calculate
plot
par 1 4 t value 0.22
calculate
plot
par 1 4 norm value 1e9
calculate
plot
par 1 4 norm value 9e8
calculate
plot
par 1 4 norm value 7e8
calculate
plot
par 1 4 norm value 6e8
calculate
plot
par 1 4 norm value 5e8
calculate
plot
par 1 4 t value 0.2
calculate
plot
par 1 4 t value 0.1673702
calculate
plot
par 1 4 norm value 1.2709729E+09
calculate
plot
par 1 4 norm value 1.4e9
calculate
plot
par 1 4 norm value 1.5e9
calculate
plot
par 1 4 norm value 1.7e9
calculate
plot
par 1 4 norm value 1.8e9
calculate
plot
par 1 4 norm value 2e9
calculate
plot
par 1 4 norm value 3e9
calculate
plot
par 1 4 t value 0.14
calculate
plot
par 1 4 t value 0.15
calculate
plot
par 1 4 norm value 2e9
calculate
plot
par 1 4 t value 0.153
calculate
plot
par 1 4 t value 0.16
calculate
plot
par 1 4 norm value 2.5e9
calculate
plot
par 1 4 t value 0.155
calculate
plot
par 1 4 t value 0.16
calculate
plot
par 1 4 t value 0.158
calculate
plot
par 1 4 norm value 2.5e9
par 1 4 norm value 2.7e9
calculate
plot
par 1 4 norm value 2.8e9
calculate
plot
par 1 4 t value 0.157
calculate
plot
par 1 4 t value 0.156
calculate
plot
par 1 4 t value 0.155
calculate
plot
par show
par 1 4 t value 0.154
calculate
plot
par 1 4 t value 0.153
calculate
plot
par 1 4 norm value 2.9E+09
calculate
plot
par 1 4 norm value 2.8E+09
calculate
plot
par 1 4 norm value 2.9E+09
calculate
plot
par 1 4 t value 0.152
calculate
plot
par 1 4 norm value 3E+09
calculate
plot
par 1 4 norm value 2.9E+09
calculate
plot
par 1 4 norm value 3E+09
calculate
plot
par write 5-5nopion-v1
comp pion
comp relation 4 7 , 1 , 2
comp relation 3 5 , 6 , 7 , 1 , 2
par 1 7 xil value 1
par show free
model show
fit
plot
par 1 4 norm value 3e9
calculate
plot
par 1 4 norm value 3.1e9
calculate
plot
par 1 4 norm value 3.2e9
calculate
plot
par 1 4 norm value 3.5e9
calculate
plot
fit
plot
comp delete 7
calculate
plot
par 1 4 norm value 3e9
calculate
plot
par 1 4 t value 0.15
calculate
plot
par 1 4 norm value 3.5e9
calculate
plot
par 1 4 norm value 3.3e9
calculate
plot
par 1 4 norm value 3.5e9
calculate
plot
par 1 4 norm value 3.6e9
calculate
plot
par 1 4 norm value 3.8e9
calculate
plot
par 1 4 norm value 4e9
calculate
plot
par 1 4 t value 0.148
calculate
plot
par 1 4 t value 0.14
calculate
plot
par 1 4 norm value 4.5e9
calculate
plot
par 1 4 norm value 5e9
calculate
plot
par 1 4 norm value 3e9
calculate
plot
par 1 4 t value 0.15
calculate
plot
par 1 4 t value 0.152
calculate
plot
par show free
par 1 2 zv status t
fit
plot
par 1 2 zv status f
par write 5-5nopion-v1 overwrite
comp pion
comp relation 4 7 , 1 , 2
comp relation 3 5 , 6 , 7 , 1 , 2
par 1 7 xil value 1
calculate
plot
fit
plot
par 1 4 norm value 3.2e9
calculate
plot
par 1 4 norm value 3.5e9
calculate
plot
fit
plot
plot rx 15 : 20
plot
plot rx 2 : 26
plot
par 1 7 xil status f
fit
plot
par 1 7 xil status f
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
par 1 7 v status f
plot
par 1 4 norm value 3.6e9
calculate
plot
par 1 4 norm value 3.8e9
calculate
plot
fit
plot
par 1 7 nh status t
fit
plot
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 rms status t
fit
plot
par 1 7 rms status f
par 1 7 zv status t
fit
plot
par 1 7 zv status f
plot rx 15 : 20
plot
plot rx 2 : 26
plot
par write 5-51pion
comp pion
comp relation 3 5 , 6 , 8 , 7 , 1 , 2
comp relation 4 8 , 7 , 1 , 2
calculate
par 1 8 xil value 2
calculate
plot
par show free
fit
plot
par 1 8 nh status f
par 1 8 xil status f
par 1 8 fcov status t
fit
plot
par 1 8 fcov status f
par 1 8 zv status t
fit
plot
par 1 8 zv status f
par 1 8 v status t
fit
plot
par 1 8 v status f
par 1 8 rms status t
fit
par 1 8 rms status f
par 1 8 nh status t
fit
plot
par 1 8 nh status f
par 1 8 xil status t
fit
plot
par 1 8 xil status f
plot rx 0 : 30
plot
par 1 4 norm value 4e9
calculate
plot
par 1 4 norm value 5e9
calculate
plot
par 1 4 norm value 8e9
calculate
plot
par 1 4 norm value 7e9
calculate
plot
par 1 4 norm value 6e9
calculate
plot
par 1 4 norm value 5e9
calculate
plot
par 1 4 t value 1.5
calculate
plot
par 1 4 t value 1.45
calculate
plot
par 1 4 t value 1.55
calculate
plot
par 1 4 t value 1.6
calculate
plot
par 1 4 t value 0.1520000
calculate
plot
par 1 4 t value 0.1500000
calculate
plot
par 1 4 t value 0.149
calculate
plot
par show free
par 1 3 norm status t
par 1 3 gamm status t
fit
plot
par 1 3 gamm status f
par 1 3 norm status f
par 1 4 norm status t
par 1 4 t status t
fit
plot
par 1 4 t status f
par 1 4 t status f
par 1 7 nh status t
plot rx 15 : 20
plot
fit
plot
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
par 1 7 v status t
fit
plot
par 1 7 v status f
par 1 7 rms status t
fit
par 1 7 rms status f
par 1 7 zv status t
fit
par 1 7 zv status f
par 1 8 nh status t
fit
plot rx 10 : 15
plot
par 1 8 nh status f
par 1 8 xil status t
fit
plot
par 1 8 xil status f
par 1 8 v status t
fit
plot
par 1 8 v status f
par 1 8 rms status t
fit
par 1 8 rms status f
par 1 8 zv status t
fit
plot
par 1 8 zv status f
par 1 3 norm status t
fit
plot rx 0 : 30
plot
plot rx 2 : 26
plot
par 1 3 norm status f
par 1 3 gamm status t
fit
plot
par 1 3 gamm status f
par 1 4 norm status t
fit
par 1 4 norm status f
plot
par 1 4 t status t
fit
par 1 4 t status f
par 1 7 nh status t
par show free
fit
plot
par 1 7 nh status f
par 1 7 xil status t
fit
plot
par 1 7 xil status f
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
par 1 7 zv status t
fit
plot
par 1 7 zv status f
par 1 8 nh status t
fit
plot
par 1 8 nh status f
par 1 8 xil status t
fit
plot
par 1 8 xil status f
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
plot
par 1 8 zv status t
fit
plot
par 1 8 zv status f
par write 5-52pion
log output 5-52pion
par show
model show
log close output
par 1 2 nh status t
par show free
fit
plot
par 1 2 nh status f
par 1 2 t status t
fit
par 1 2 t status f
par 1 2 fcov status t
fit
par 1 2 fcov status f
par 1 2 v status t
fit
par 1 2 v status f
par 1 2 rms status t
fit
par 1 2 rms status f
par 1 2 zv status t
fit
plot
par write 5-52pion
par write 5-52pion overwrite
log output 5-52pion overwrite
par show
model show
log close output
