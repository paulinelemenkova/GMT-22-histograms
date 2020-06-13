#!/bin/bash
# Purpose: Make standard histograms of the cross-section profiles (here: Kuril-Kamchatka Trench)
# GMT modules: pshistogram, pstext, logo, psconvert
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
ps=Hist_KKT.ps
# Step-3. Plot histogram
gmt pshistogram table2.txt -i4 -R-9000/6/0/20 -JX4.8i/2.4i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" -Bpyg5a5f2.5+l"Frequency"+u" %" \
    -Bsyg2.5 -UBL/-15p/-35p \
    -BWSne+t"Histograms of the depths frequency distribution: Kuril-Kamchatka Trench, northern part"+gsnow1 -Glightsteelblue1 \
    -D+f6p,Times-Roman -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen -K > $ps
# Step-4. Add subtitle
gmt pstext -R0/10/0/10 -JX10/10 -X0.5c -Y0.0c -N -O -K \
    -F+f9p,Palatino-Roman,black+jLB >> $ps << EOF
    1.0 6.5 Equivalent normal distribution: mean, median and LMS mode
EOF
# Step-5. Add GMT logo
gmt logo -Dx5.0/0.0+o-0.5c/-2.0c+w2c -O >> $ps
# Step-6. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_KKT.ps -A0.2c -E720 -Tj -P -Z

