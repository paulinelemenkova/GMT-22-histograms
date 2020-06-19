#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles (Cascadia Trench, Pacific Ocean)
# GMT modules: gmtset, psrose, pshistogram, pslegend, logo, psconvert

# Step-1. GMT set up
gmt set MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.2c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN thinnest,dimgray \
    FONT_TITLE 10p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 9p,Palatino-Roman,dimgray \
    FONT_LABEL 8p,Palatino-Roman,dimgray \

# Step-2. Generate a file
ps=Hist_CT.ps
# Step-3. Plot histogram
gmt pshistogram tableCT.txt -i4 -R-3000/1500/0/13.5 -JX4.8i/2.4i -X3.6i \
    -Bpxg1000a250f100+l"Bathymetry (m)" \
    -Bpyg4a1f0.5+l"Frequency distribution"+u" %" -Bsyg2 \
    --MAP_TITLE_OFFSET=0.5c \
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_GRID_PEN=thinnest,dimgray \
    -BWSne+t"Cascadia Trench: Histograms of depths on the cross-section profiles"+gghostwhite -Gpowderblue \
    -D+f6p,Times-Roman+o2p -L0.1p,dimgray -Z1 -W100 -N0+pred -N1+pblue -N2+pgreen -K > $ps

# Step-4. Add legend
gmt pslegend -R -J -Dx1.0/-2.6+w5.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=8p -O -K << EOF >> $ps
S 0.3c - 0.7c - 0.5p,red 1.0c Mean and standard deviation
S 0.3c - 0.7c - 0.5p,green 1.0c LMS mode and scale
S 0.3c - 0.7c - 0.5p,blue 1.0c Median and L1 scale
EOF

# Step-5. Add GMT logo
gmt logo -Dx6.0/0.0+o-0.5c/-2.1c+w2c -O >> $ps
# Step-6. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_CT.ps -A0.2c -E720 -P -Tj -Z

