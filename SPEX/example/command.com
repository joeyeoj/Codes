# This is a command file that creates a plot with residuals.
plot dev xs
plot type data
plot x log
plot y log
plot rx 0.2:10.
plot ry 0.0001:10.
plot back disp t
plot set 1
plot data col 1
plot model col 2
plot back col 1
plot set all
plot frame new
plot frame 2
plot type chi
plot uy rel
plot x log
plot rx 0.2:10.
plot ry -0.5:0.5
plot view def f
plot view x 0.08:0.92
plot view y 0.1:0.3
plot cap y text "Rel. Error"
plot cap ut disp f
plot cap lt disp f
plot cap id disp f
plot frame 1
plot view def f
plot view x 0.08:0.92
plot view y 0.3:0.9
plot cap x disp f
plot cap id disp f
plot cap ut disp f
plot box numlab bot f
