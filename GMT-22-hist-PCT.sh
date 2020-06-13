#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles (here: Peru-Chile trench)
# GMT modules: gmtset, psrose, pshistogram, pslegend, logo, psconvert
# Step-1. GMT set up
gmt set MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.2c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN thinnest,dimgray \
    FONT_TITLE 12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 10p,Palatino-Roman,black \
    FONT_LABEL 10p,Palatino-Roman,black \
# Step-2. Generate a file
ps=Hist_PCT.ps
#
# PERU
# Step-4. Plot histogram
gmt pshistogram tablePCTn.txt -i4 -R-7000/6/0/25 -JX4.8i/2.4i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Histogram of the bathymetry across Peruvian (A) segment"+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pgreen -N2+pblue -K > $ps
echo "-6700 22.5 A" | gmt pstext -R -J -F+jBL+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-5. Add legend
gmt pslegend -R -J -Dx0.5/-3.0+w6.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=10p -O -K << EOF >> $ps
S 0.3c - 0.8c - 0.5p,red 1.0c Mean and standard deviation
S 0.3c - 0.8c - 0.5p,blue 1.0c LMS mode and scale
S 0.3c - 0.8c - 0.5p,green 1.0c Median and L1 scale
EOF
#
# CHILE
# Plot histogram
gmt pshistogram tablePCTs.txt -i4 -R-8000/6/0/20 -JX4.8i/2.4i -X15.0c\
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Histogram of the bathymetry across Chilean (B) segment"+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pgreen -N2+pblue \
     -UBL/8.5c/-1.8c -O -K >> $ps
echo "-7700 18 B" | gmt pstext -R -J -F+jBL+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-6. Add GMT logo
gmt logo -Dx0.0/0.0+o-2.5c/-2.5c+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_PCT.ps -A0.5c -E720 -Tj -Z
