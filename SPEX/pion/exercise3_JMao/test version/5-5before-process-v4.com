data inst_amo1 bhiw_amo1
plot device xs
plot type data
plot ux ang
plot uy fang
plot
plot rx 0 : 5
plot
plot ry 0 : 200
plot
plot ry 0 : 350
plot
ignore 0 : 2 unit ang
plot
plot rx 25 : 30
plot
plot ry 0 : 200
plot
plot ry 0 : 100
plot
plot ry 0 : 50
plot
plot rx 20 : 30
plot
ignore 25 : 30 unit ang
plot
plot rx 2 : 25
plot
plot ry 0 : 350
plot
comp pow
calculate
plot
par show
comp delete 1
comp reds
distance 0.01158 z
par show
par 1 1 z value 0.01158
comp pow
model show
comp relation 2 1
calculate
plot
par show
par 1 2 norm value 1e10
calculate
plot
par 1 2 norm value 1e5
calculate
plot
par 1 2 norm value 1e7
calculate
plot
par 1 2 norm value 1e15
calculate
plot
par 1 2 norm value 1e8
calculate
plot
par 1 2 norm value 1e10
calculate
plot
par 1 2 norm value 1e9
calculate
plot
par 1 2 gamm value 4
calculate
plot
par 1 2 gamm value 3
calculate
plot
par 1 2 gamm value 3.5
calculate
plot
par 1 2 gamm status f
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
par 1 2 gamm status f
par 1 2 norm status t
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
comp mbb
par show 1 3
comp delete 2
comp relation 2 1
calculate
plot
par 1 2 norm value 1e8
calculate
plot
par 1 2 norm value 1e6
calculate
plot
par 1 2 norm value 1e7
calculate
plot
par 1 2 norm value 2e6
calculate
plot
par 1 2 norm value 1.5e6
calculate
plot
par 1 2 t value 1e1
calculate
plot
par 1 2 t value 1e2
calculate
plot
par 1 2 t value 5
calculate
plot
par 1 2 t value 1
calculate
plot
par 1 2 t value 5
calculate
plot
par 1 2 norm value 1e6
calculate
plot
par 1 2 norm value 1e5
calculate
plot
par 1 2 t value 10
calculate
plot
par 1 2 t value 1e2
calculate
plot
par 1 2 t value 2e2
calculate
plot
par 1 2 norm value 1e4
calculate
plot
par 1 2 norm value 5e4
calculate
plot
par 1 2 norm value 6e4
calculate
plot
par 1 2 norm value 5.5e4
calculate
plot
par 1 2 norm value 5.3e4
calculate
plot
par 1 2 t value 1e2
calculate
plot
par 1 2 t value 1.5e2
calculate
plot
par 1 2 t value 1.2e2
calculate
plot
par 1 2 t value 1e1
calculate
plot
par 1 2 t value 1e2
calculate
plot
par show free
comp delete 2
comp pow
comp mbb
comp relation 2 1
comp relation 3 1
calculate
plot
par 1 2 norm value 1e5
calculate
plot
par 1 2 norm value 1e6
calculate
plot
par 1 2 norm value 1e7
calculate
plot
par 1 2 norm value 5e7
calculate
plot
par 1 2 norm value 1e8
calculate
plot
par 1 2 norm value 1e10
calculate
plot
par 1 2 norm value 1e9
calculate
plot
par 1 2 gamm value 3
calculate
plot
par 1 2 gamm value 3.5
calculate
plot
par 1 3 norm value 1e4
calculate
plot
par 1 3 norm value 1e6
calculate
plot
par 1 3 norm value 1e4
calculate
plot
par 1 3 t value 5
calculate
plot
par 1 3 t value 10
calculate
plot
par 1 3 norm value 1e3
calculate
plot
par 1 3 t value 1e2
calculate
plot
par 1 3 t value 1e3
calculate
plot
par 1 3 t value 2e2
calculate
plot
par 1 3 norm value 1e2
calculate
plot
par 1 3 t value 10
calculate
plot
par 1 3 t value 20
calculate
plot
par 1 3 t value 1e3
calculate
plot
par 1 3 t value 1e4
par 1 3 norm value 1e3
calculate
plot
par 1 3 norm value 5e2
calculate
plot
par 1 3 norm value 3e2
calculate
plot
par 1 3 t value 5
calculate
plot
par 1 3 t value 10
calculate
plot
par 1 3 t value 1e2
calculate
plot
par 1 3 norm value 4e2
calculate
plot
par 1 3 t value 5
calculate
plot
par show
par 1 3 norm value 1e5
calculate
plot
par 1 3 norm value 1e10
calculate
plot
par 1 3 norm value 1e5
calculate
plot
par 1 3 norm value 1e6
calculate
plot
par 1 3 norm value 1e4
calculate
plot
par 1 3 t value 9.9e2
calculate
plot
par 1 3 t value 1e2
calculate
plot
par 1 3 t value 5e1
calculate
plot
par 1 3 t value 4e1
calculate
plot
par 1 3 norm value 5e3
calculate
plot
par show
par 1 2 gamm status f
par 1 3 norm status f
par 1 3 t status f
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
par 1 2 gamm status f
par 1 2 norm status t
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
par 1 2 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 t status t
fit
plot
par 1 3 t status f
par show free
par 1 2 norm status t
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
par 1 2 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 t status t
fit
plot
par show
par 1 2 norm status t
par 1 2 gamm status t
par 1 3 norm status t
par show free
fit
plot
par 1 2 gamm status f
par 1 3 norm status f
par 1 3 t status f
fit
plot
par 1 2 norm status f
par 1 2 gamm status t
fit
plot
par 1 2 gamm status f
par 1 3 norm status t
fit
plot
par 1 3 norm status f
par 1 3 t status t
fit
plot
