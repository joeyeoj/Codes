elim 0.5:10
par show flux

dist 1
cal
par show flux

dist 0.01158 z
com rel 2
cal
par show flux
