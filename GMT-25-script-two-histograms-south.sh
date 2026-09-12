#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles (here: Kuril-Kamchatka Trench)
# GMT modules: gmtset, psrose, pshistogram, pslegend, logo, psconvert
# Step-1. GMT set up
gmt set
    MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.2c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_CROSS_PEN thinnest,dimgray \
    MAP_GRID_CROSS_PEN thinnest,dimgray \
    MAP_GRID_PEN thinnest,dimgray \
    FONT_TITLE 8p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 9p,Palatino-Roman,dimgray \
    FONT_LABEL 8p,Palatino-Roman,dimgray \
# Step-2. Generate a file
ps=Hist_two_KKT_south.ps
# Step-3. Plot rose diagram
gmt psrose table1.txt -i1,4 -R0/1/0/360 \
    -A7r -S1.0in \
    -Gthistle -Bx0.2g0.2 \
    -By30g30+l"Cross-section profiles pf the Kuril-Kamchatka Trench, southern part" \
    -B+t"Rose diagram of the bathymetric data distribution"+givory1 \
    -M0.5c+e+gred+n1c -W0.1p,red -Cm \
    -UBL/-15p/-58p -Vv -K > $ps
# Step-4. Plot histogram
gmt pshistogram table1.txt -i4 -R-9000/6/0/20 -JX4.8i/2.4i -X3.6i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Histograms of the depths frequency distribution"+gsnow1 -Glightsteelblue1 \
    -D+f6p,Times-Roman -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -O -K >> $ps
# Step-5. Add legend
gmt pslegend -R -J -Dx1.0/-2.6+w5.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=8p -O -K << EOF >> $ps
S 0.3c v 0.5c red 0.01c 0.6c Mean and standard deviation
S 0.3c v 0.5c green 0.01c 0.6c LMS mode and scale
S 0.3c v 0.5c blue 0.01c 0.6c Median and L1 scale
EOF
# Step-6. Add GMT logo
gmt logo -Dx6.0/0.0+o-0.5c/-2.0c+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_two_KKT_south.ps -A0.2c -E720 -P -Tj -Z
