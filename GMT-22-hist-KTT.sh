#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles (here: Kermadec and Tonga trenches)
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
ps=Hist_KTT.ps
# Kermadec
# gmt pshistogram tableK.txt -i4 -R-10000/6/0/20 -JX4.8i/2.4i -X3.6i \
# Step-4. Plot histogram
gmt pshistogram tableK.txt -i4 -R-10000/6/0/20 -JX4.8i/2.4i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Histograms of the bathymetry: Kermadec Trench (A) and Tonga Trench (B)"+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pblack -N1+p..- -N2+p. \
    -UBL/8.5c/-1.8c -K > $ps
echo "-9500 18 A" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-5. Add legend
gmt pslegend -R -J -Dx0.5/-3.0+w6.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=10p -O -K << EOF >> $ps
S 0.3c - 0.8c - 0.5p,black 1.0c Mean and standard deviation
S 0.3c - 0.8c - 0.5p,. 1.0c LMS mode and scale
S 0.3c - 0.8c - 0.5p,..- 1.0c Median and L1 scale
EOF
# Tonga
# Plot histogram
gmt pshistogram tableT.txt -i4 -R-10000/6/0/20 -JX4.8i/2.4i -X15.0c\
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pblack -N1+p..- -N2+p. \
    -O -K >> $ps
echo "-9500 18 B" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Step-6. Add GMT logo
gmt logo -Dx6.0/0.0+o-0.0c/-2.5c+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_KTT.ps -A0.5c -E720 -Tj -Z
