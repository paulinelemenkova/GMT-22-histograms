#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles (here: Ryukyu Trench)
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
ps=Hist_RTs.ps
# Step-3. Plot rose diagram
gmt psrose tableRTs.txt -i1,4 -R0/1/0/360 \
    -A7r -S1.0in \
    -Gthistle -Bx0.2g0.2 \
    -By30g30+l"Cross-section profiles of the trench, northern part" \
    -B+t"Rose diagram of the bathymetric data distribution"+givory1 \
    -M0.5c+e+gred+n1c -W0.1p,red -Cm \
    -UBL/-1.4c/-2.3c -Vv -K > $ps
# Step-4. Plot histogram
gmt pshistogram tableRTs.txt -i4 -R-8000/6/0/15 -JX4.8i/2.4i -X3.6i \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Histograms of the depths frequency distribution: northern part"+gsnow1 -Glightsteelblue1 \
    -D+f7p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -O -K >> $ps
# Step-5. Add legend
gmt pslegend -R -J -Dx1.0/-3.0+w12.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=10p -O -K << EOF >> $ps
S 0.3c - 0.8c - 0.5p,red 1.0c Mean and standard deviation
S 0.3c - 0.8c - 0.5p,green 1.0c LMS mode and scale
S 0.3c - 0.8c - 0.5p,blue 1.0c Median and L1 scale
EOF
# Step-6. Add GMT logo
gmt logo -Dx7.0/0.0+o-0.5c/-2.3c+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_RTs.ps -A0.2c -E720 -P -Tj -Z
