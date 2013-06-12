#!/usr/bin/gnuplot

set terminal postscript
set output "test.ps"
set autoscale
unset log
unset label
set xtic auto
set ytic auto

set title "test title"
set xlabel "test xlabel"
set ylabel "test ylabel"

#plot 	"test.dat" using 2:3 title 'index' with histograms 

set style histogram rowstacked
set boxwidth 0.6 relative
plot 'test.dat' using 3:xticlabels(2) title columnheader
