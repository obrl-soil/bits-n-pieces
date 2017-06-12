####

library(sf) # 0.4-3
library(sp) # 1.2-4
library(rmapshaper) # 0.2.0

testmap <- st_read(file.path(getwd(), 'BER_polygons_src.gpkg'), quiet = TRUE) %>%
  st_transform(., crs = 28355) # UTM Zone 55S

plot(st_geometry(testmap))

# rmapshaper
tm_mssimp <- ms_simplify(as(testmap, 'Spatial'), keep = 0.25, keep_shapes = TRUE) %>%
  st_as_sf()
st_write(tm_mssimp, file.path(getwd(), 'mapshaper_test_25.gpkg'))

tm_mssimp_5 <- ms_simplify(as(testmap, 'Spatial'), keep = 0.05, keep_shapes = TRUE) %>%
  st_as_sf()
st_write(tm_mssimp_5, file.path(getwd(), 'mapshaper_test_5.gpkg'))

# st_simplify (obvs hard to compare exactly due to diff btwn 'tolerance' and 'keep',
# but even the 25m tolerance introduces gaps and overlaps within the layer extent)

tm_stsimp_25 <- st_simplify(testmap, preserveTopology = TRUE, dTolerance = 25)
st_write(tm_stsimp_25, file.path(getwd(), 'stsimp_test_25m.gpkg'))

tm_stsimp_100 <- st_simplify(testmap, preserveTopology = TRUE, dTolerance = 100)
st_write(tm_stsimp_100, file.path(getwd(), 'stsimp_test_100m.gpkg'))

tm_stsimp_250 <- st_simplify(testmap, preserveTopology = TRUE, dTolerance = 250)
st_write(tm_stsimp_250, file.path(getwd(), 'stsimp_test_250m.gpkg'))
