xmax <- 15
ymax <- 15
z <- 4

combos <- merge(1:xmax, 1:ymax)
outdir <- 'image tiles'

for(i in 1:nrow(combos)){
  
  url <- paste0("http://api.gbif.org/v1/map/density/tile.png?x=",
                combos[i,1],
                "&y=",
                combos[i,2],
                "&z=",
                z,
                "&saturation=true&key=1&layer=SP_PRE_1900&layer=SP_1900_1910&layer=SP_1910_1920&layer=SP_1920_1930&layer=SP_1930_1940&layer=SP_1940_1950&layer=SP_1950_1960&layer=SP_1960_1970&layer=SP_1970_1980&layer=SP_1980_1990&layer=SP_1990_2000&layer=SP_2000_2010&layer=SP_2010_2020&layer=OBS_PRE_1900&layer=OBS_1900_1910&layer=OBS_1910_1920&layer=OBS_1920_1930&layer=OBS_1930_1940&layer=OBS_1940_1950&layer=OBS_1950_1960&layer=OBS_1960_1970&layer=OBS_1970_1980&layer=OBS_1980_1990&layer=OBS_1990_2000&layer=OBS_2000_2010&layer=OBS_2010_2020&layer=OTH_PRE_1900&layer=OTH_1900_1910&layer=OTH_1910_1920&layer=OTH_1920_1930&layer=OTH_1930_1940&layer=OTH_1940_1950&layer=OTH_1950_1960&layer=OTH_1960_1970&layer=OTH_1970_1980&layer=OTH_1980_1990&layer=OTH_1990_2000&layer=OTH_2000_2010&layer=OTH_2010_2020&layer=FOSSIL&layer=LIVING&type=ALL&resolution=1")
  download.file(url = url, mode = 'wb',
                destfile = file.path(outdir,
                                     paste0('GBIF_tile', i, '.png')))
  
}

# Read in the tiles and save as one big png
library(png)

# setup plot
par(mar = rep(0, 4)) # no margins

# layout the plots into a matrix w/ 12 columns, by row
layout(matrix(1:nrow(combos),
              ncol = xmax,
              byrow = TRUE))

# do the plotting
for(i in 1:nrow(combos)) {
  
  # example image
  img <- readPNG(file.path(outdir,
                           paste0('GBIF_tile', i, '.png')))
  
  plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n",bty="n",xaxs = 'i',yaxs='i')
  rasterImage(img,0,0,1,1)
  
}

dev.print(pdf, "Occurrence_map.pdf")
