#!/bin/bash
# Purpose: Plot two histograms of the cross-section profiles
# here: Ninety East Ridge
# GMT modules: gmtset, psrose, pshistogram, pslegend, logo, psconvert
# Step-1. GMT set up
gmt set MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.2c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN thinnest,dimgray \
    FONT_ANNOT_PRIMARY 10p,Palatino-Roman,black \
    FONT_LABEL 10p,Palatino-Roman,black \

# Generate a file
ps=Hist_NER.ps

# NORTH
# Plot histogram
gmt pshistogram tableNER1.txt -i4 -R-6000/6/0/15 -JX4.8i/2.4i -X3.6i \
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_GRID_PEN=thinnest,dimgray \
    --FONT_ANNOT_PRIMARY=11p,Helvetica,black \
    --FONT_LABEL=11p,Helvetica,black \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+gsnow1 -Glightsteelblue1 \
    -D+f9p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -UBL/8.5c/-1.8c -K > $ps
echo "-500 10 C" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
echo "-6000 28 Southern segment" | gmt pstext -R -J -F+jBL+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Add legend
gmt pslegend -R -J -Dx0.5/-3.2+w6.0c+o-1.0/0.5c \
    -F+pthick+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=10p -O -K << EOF >> $ps
S 0.3c - 0.8c - 0.5p,red 1.0c Mean and standard deviation
S 0.3c - 0.8c - 0.5p,green 1.0c LMS mode and scale
S 0.3c - 0.8c - 0.5p,blue 1.0c Median and L1 scale
EOF

# CENTER
# Plot histogram
gmt pshistogram tableNER2.txt -i4 -R-6000/6/0/10 -JX4.8i/2.4i -Y7.5c\
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_GRID_PEN=thinnest,dimgray \
    --FONT_ANNOT_PRIMARY=11p,Helvetica,black \
    --FONT_LABEL=11p,Helvetica,black \
    -Bpxg500a1000f100+l"Bathymetry (m)" \
    -Bpyg5a2f2+l"Frequency"+u" %" -Bsyg2 \
    -BWSne+gsnow1 -Glightsteelblue1 \
    -D+f9p,Times-Roman,black -L0.1p,dimgray -Z1 -W100 -N0+pred -N1+pblue -N2+pgreen \
    -O -K >> $ps
echo "-500 7 B" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
echo "-2700 13 Central segment" | gmt pstext -R -J -F+jBL+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps

# SOUTH
# Plot histogram
gmt pshistogram tableNER3.txt -i4 -R-6000/6/0/15 -JX4.8i/2.4i -Y7.5c\
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_GRID_PEN=thinnest,dimgray \
    --FONT_ANNOT_PRIMARY=11p,Helvetica,black \
    --FONT_LABEL=11p,Helvetica,black \
    --MAP_TITLE_OFFSET=0.5c \
    --FONT_TITLE=13p,Helvetica,black \
    -Bpxg1000a1000f100+l"Bathymetry (m)" \
    -Bpyg5a5f2.5+l"Frequency"+u" %" -Bsyg2.5 \
    -BWSne+t"Ninety East Ridge: histograms on bathymetry"+gsnow1 -Glightsteelblue1 \
    -D+f9p,Times-Roman,black -L0.1p,dimgray -Z1 -W250 -N0+pred -N1+pblue -N2+pgreen \
    -O -K >> $ps
echo "-500 10 A" | gmt pstext -R -J -F+jBR+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
echo "-2500 18 Northen segment" | gmt pstext -R -J -F+jBL+f15p,black -Gfloralwhite -W0.5p -O -K >> $ps
# Add GMT logo

gmt logo -Dx6.0/0.0+o-0.0c/-17.5c+w2c -O >> $ps
# Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Hist_NER.ps -A4.5c -E720 -P -Tj -Z
