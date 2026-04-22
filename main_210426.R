# nolint start

# Librerías
library(tidyverse)
library(magrittr)
library(ggplot2)
library(gridExtra)
library(haven)
library(expss)
library(sf)

# ---------------------------------------------------------------------
# Import json
# ---------------------------------------------------------------------

# jsonlite no sirve para geojson

# "C:\\Users\\R1ck7\\Downloads\\BaseDeDatos\\geoIsoTest.geojson"
mypath <- file.choose()

geo <- sf::st_read(mypath)
geo %>% str()
geo
sf::st_crs(geo)

plot(geo$value)

geo$group_index %<>% factor()
geo$value %<>% factor()
geo$value %<>% fct_rev()

geo %>%
  ggplot() +
  geom_sf(aes(fill = value, group = value), alpha = c(.8, .3, .2))

library(leaflet)

st_crs(geo)
geo <- st_transform(geo, crs = 4326)

geo %>%
  filter(group_index == 0) %>%
  leaflet() %>%
  addProviderTiles(providers$Esri.WorldStreetMap) %>%
  addPolygons()

geo %>%
  filter(group_index == 0) %>%
  leaflet() %>%
  addTiles(urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png") %>%
  addPolygons()

o <- c(
  grep("Carto", providers %>% names()),
  grep("Esri", providers %>% names()),
  grep("Open", providers %>% names())
)

prov <- providers %>% names()
names <- prov[o]




# ---------------------------------------------------------------------
# PCA Ezequiel Multivariada
# ---------------------------------------------------------------------




# ---------------------------------------------------------------------
# SensMap
# ---------------------------------------------------------------------

install.packages("SensMap")
library(SensMap)

data(hedo_biscuit)


# ---------------------------------------------------------------------
# SensoMineR
# ---------------------------------------------------------------------

library("SensoMineR")
data(JAR)

JAR(
  x = JAR,
  col.p = 13, col.j = 1, col.pref = 2, jarlevel = "jar"
)

res <- CA_JAR(
  x = JAR,
  col.p = 13, col.j = 1, col.pref = 2, jarlevel = "jar"
)

JAR %>% count(Text)

plot.CA(res$res.CA, invisible = "row", cex = 0.8)

JAR %>% str()
JAR %>% head()
JAR %>% dim()
JAR[, 1] %>% cro()

JAR %>%
  tab_cells(AG) %>%
  tab_rows(Juge) %>%
  tab_cols(Produit) %>%
  tab_stat_mean() %>%
  tab_pivot()

47 * 3

JAR %>% cross_cases(Juge, Produit)
JAR %>%
  filter(Juge == 101) %>%
  cross_cases(AG, Produit)

JAR$AG %>% is.na()

JAR %>%
  filter(Juge == 101) %>%
  help(JAR)
res


# nolint end
