# GMT Histograms — Bathymetric Depth Distribution Statistics Scripts

A collection of over 25 GMT (Generic Mapping Tools) shell scripts for the statistical analysis and plotting of bathymetric depth distributions along ocean-trench cross-section profiles. Each script draws a frequency histogram of the sampled depths, annotated with central-tendency and dispersion statistics, and a companion rose diagram of the profile data. The scripts have been used to generate figures across the author's marine-geomorphological and cartographic publications.

## What the scripts do

Each script builds a complete statistical figure, typically chaining:

- histogram of the depth values with percentage frequency (pshistogram), including mean and standard deviation, median and L1 scale, and LMS mode and scale overlays
- a rose diagram of the cross-section data distribution (psrose)
- a legend identifying the statistical estimators (pslegend)
- GMT logo (logo)
- export to raster (psconvert) at high resolution

The input tables are the stacked cross-track profile files produced by the companion cross-section profiling scripts.

## Data source

Depth values sampled from ETOPO1 relief along trench cross-section profiles (see the companion GMT cross-section profiling repository). Input as GMT table files (tableXX.txt).

## File naming

Scripts follow GMT-22-hist-XX.sh, where XX is an ocean-trench tag (e.g. MAT = Middle America Trench, JT = Japan Trench, IBT = Izu-Bonin Trench, KKT/KTT, RT, MnT, NER, VVT, YPT). A north/south suffix (RTn, RTs, -north, -south) marks trench-segment variants; GMT-22-hist-rose_diagram.sh isolates the rose plot.

## Requirements

- GMT 6.x (Generic Mapping Tools): https://www.generic-mapping-tools.org
- A POSIX shell (bash)
- The stacked cross-section profile table(s) available locally

## Usage

Place the required profile table in the working directory, adjust the -R ranges at the top of the chosen script, then run:

    bash GMT-22-hist-MAT.sh

The script writes a PostScript file and converts it to a raster image (JPG/PNG) via psconvert.

## Author and citation

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

These scripts accompany figures in the author's marine-geomorphological and cartographic papers; please cite the specific article a given figure appears in. The full publication list is available via the ORCID record above.

## License

See the LICENSE file in this repository.
