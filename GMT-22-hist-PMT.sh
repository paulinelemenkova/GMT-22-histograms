#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles
# here: Philippine and Mariana trenches
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
ps=Hist_PMT.ps
#
# Philippine
# Step-4. Plot histogram
gmt pshistogram tableP.txt -i4 -R-11000/6/0/25 -JX4.8i/2.4i -X3.6i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -UBL/8.5c/-1.8c -K > $ps
echo "-10000 20 B" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-5. Add legend
gmt pslegend -R -J -Dx0.5/-3.0+w6.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=10p -O -K << EOF >> $ps
S 0.3c - 0.8c - 0.5p,red 1.0c Mean and standard deviation
S 0.3c - 0.8c - 0.5p,green 1.0c LMS mode and scale
S 0.3c - 0.8c - 0.5p,blue 1.0c Median and L1 scale
EOF
#
# Mariana
# Plot histogram
gmt pshistogram tableM.txt -i4 -R-11000/6/0/12 -JX4.8i/2.4i -Y7.5c\
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg4a2f2+l"Frequency"+u" %" -Bsyg2 \
    -BWSne+t"Histograms of the bathymetry, Mariana (A) and Philippine (B) trenches"+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -O -K >> $ps
echo "-10000 10 A" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-6. Add GMT logo
gmt logo -Dx6.0/0.0+o-0.0c/-10.0c+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_PMT.ps -A0.5c -E720 -P -Tj -Z
