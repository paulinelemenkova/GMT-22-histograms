#!/bin/bash
# Purpose: Make rose histograms of the cross-section profiles (here: Kuril-Kamchatka Trench)
# GMT modules: gmtset, psrose, logo, psconvert
# Step-1. GMT set up
gmt set
    MAP_TITLE_OFFSET 0.2c \
    MAP_ANNOT_OFFSET 0.2c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_CROSS_PEN thinnest,dimgray \
    MAP_GRID_CROSS_PEN thinnest,dimgray \
    MAP_GRID_PEN thinnest,dimgray \
    FONT_TITLE 8p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 9p,Palatino-Roman,dimgray \
    FONT_LABEL 8p,Palatino-Roman,dimgray \
# Step-2. Generate a file
ps=Rose_KKT.ps
# Step-3. Plot rose histogram
gmt psrose table2.txt -i1,4 -R0/1/0/360 \
    -A7r -S1.8in \
    -Gthistle -X2.5i -Bx0.2g0.2 \
    -By30g30+l"Cross-section profiles pf the Kuril-Kamchatka Trench, northern part" \
    -B+t"Rose diagram of the bathymetric data distribution"+givory1 \
    -M0.5c+e+gred+n1c -W0.1p,red -Cm -K \
    -P -UBL/-15p/-58p -Vv > $ps
# Step-4. Add GMT logo
gmt logo -Dx3.8/0.0+o0.0c/-2.7c+w2c -O >> $ps
# Step-5. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Rose_KKT.ps -A0.2c -E720 -Tj -P -Z
