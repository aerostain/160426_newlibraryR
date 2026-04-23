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

JAR %>% cross_cases(Text)
JAR$Text %>% levels()

JAR %>%
  tab_cells(AG) %>%
  tab_cols(Text) %>%
  tab_stat_mean() %>%
  tab_pivot()

JAR %>%
  tab_cells(Text) %>%
  tab_cols(Produit) %>%
  tab_stat_cases() %>%
  tab_pivot()

JAR %>%
  filter(Text != "jar") %>%
  tab_cells(Text) %>%
  tab_cols(Produit) %>%
  tab_stat_cases() %>%
  tab_pivot()

29.7 + 41.8 + 20.9 + 1.1 + 2.2 + 4.4

with(JAR, tapply(AG, Text, FUN = \(x) mean(x, na.rm = TRUE)))
tmp <- with(JAR, aggregate(AG ~ Text, FUN = mean))
tmp[, 2] - tmp[1, 2]

with(
  JAR,
  tapply(AG, Text,
    FUN = \(x) paste0(round(mean(x, na.rm = TRUE), 4), "-", length(x))
  )
)


data(JAR)
res.jar <- JAR(JAR, col.p = 13, col.j = 1, col.pref = 2)
plot.JAR(res.jar, name.prod = "284", model = 1)


JAR %>%
  select(AG, Text)

JAR %>% cross_cases(Teinte)
JAR$Text %>% levels()

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


# ---------------------------------------------------------------------
# Regresion
# ---------------------------------------------------------------------

n <- 100
data <- data.frame(
  edad = runif(n, 20, 60),
  experiencia = runif(n, 0, 40),
  educ_sup = sample(0:1, n, replace = TRUE),
  empleado = sample(0:1, n, replace = TRUE),
  region = sample(c("Costa", "Sierra", "Selva"), n, replace = TRUE),
  nivel_soc = sample(c("Bajo", "Medio", "Alto"), n, replace = TRUE)
)

data$educ_sup <- as.factor(data$educ_sup)
data$empleado <- as.factor(data$empleado)
data$region <- as.factor(data$region)
data$nivel_soc <- factor(data$nivel_soc,
  levels = c("Bajo", "Medio", "Alto"),
  ordered = TRUE
)

data$ingreso <- 1000 +
  20 * data$edad +
  30 * data$experiencia +
  ifelse(data$educ_sup == 1, 500, 0) +
  ifelse(data$empleado == 1, 800, 0) +
  ifelse(data$region == "Sierra", -200, 0) +
  ifelse(data$region == "Selva", -100, 0) +
  ifelse(data$nivel_soc == "Medio", 300, 0) +
  ifelse(data$nivel_soc == "Alto", 700, 0) +
  rnorm(n, 0, 200)

data %>% dim()
data <- data[, c(7, 1:6)]
data %>% str()

modelo <- lm(
  ingreso ~ edad + experiencia +
    educ_sup + empleado +
    region + nivel_soc,
  data = data
)

summary(modelo)

library(emmeans)
emmeans(modelo, pairwise ~ region)
emmeans(modelo, pairwise ~ nivel_soc)

?lm

data(perfume)
fix(perfume)
perfume %>% str()
res <- WordCountAna(base = perfume, sep.word = ";")













# nolint end
