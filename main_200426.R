# nolint start


# ---------------------------------------------------------------------
# pivot long-wider
# ---------------------------------------------------------------------

Sys.Date() %>% class()
Sys.time() %>% class()

as.Date("2026-12-23")
as.Date("2026/12/23")

# ---------------------------------------------------------------------
# Rpackage Data Book: Analyzing Sensory Data with R
# ---------------------------------------------------------------------

# Crear .rda

path <- file.path("C:\\Users\\R1ck7\\Downloads\\BaseDeDatos\\Analizing Sensory Data with R\\Dataset book")
namefiles <- dir(path)
n <- length(namefiles)
importfiles <- file.path(path, namefiles, fsep = "\\")
namesobjects <- str_replace_all(namefiles, ".csv", "")
namesobjects <- str_replace_all(namesobjects, " ", "_")
tmpnames <- LETTERS[1:n]
sheet(tmpnames, namesobjects)

n
setdiff(1:n, c(c(4, 17, 18), c(2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 19, 20)))

for (i in c(1:n)) {
  if (i == 1) {
    txt <- paste0(namesobjects[i], " <- read.csv(importfiles[i],sep=';')")
  } else if (i %in% c(4, 17, 18)) {
    txt <- paste0(namesobjects[i], " <- read.csv(importfiles[i],header = TRUE,sep = '\t',quote = '',fileEncoding = 'latin1')")
  } else {
    txt <- paste0(namesobjects[i], " <- read.csv(importfiles[i],sep=',',fileEncoding = 'latin1')")
  }
  print(paste0(i, "_", txt))
  eval(parse(text = txt))
  # eval(parse(text = paste0("fix(", namesobjects[i], ")")))
}

namesobjects %>% matrix()

exp <- perfumes_qda_experts
exp %>% str()

# Session es porque un panelista es evaluado 2 veces
# Rank es el orden de presentacion de los productos
exp$Rank %<>% factor
exp$Session %<>% factor

exp %>% count(Panelist, Session, Rank)
exp %>% cross_cases(Panelist %nest% Session, list(Rank, total()))
exp %>% cross_cases(Product, Panelist %nest% Session)

exp %>%
  tab_cells(Spicy) %>%
  tab_rows(Product) %>%
  tab_cols(Panelist %nest% Session) %>%
  tab_stat_mean() %>%
  tab_pivot()

exp %>%
  filter(Panelist == "CM", Session == 1) %>%
  select(Product, Spicy) %>%
  arrange(Product)

exp %>% head(24)

attr(exp$Rank, "Desc") <- "Orden de presentación"

attributes(exp$Rank)

# Histograma

exp %>% ggplot(aes(Spicy)) +
  geom_histogram()

exp %>% ggplot(aes(Wrapping)) +
  geom_histogram()

exp %>% ggplot(aes(Product, Wrapping, fill = Product)) +
  geom_boxplot(width = .4, alpha = .2)

exp %>% ggplot(aes(Product, Spicy, fill = Product)) +
  geom_boxplot(width = .4, alpha = .2)

library(SensoMineR)
data(chocolates)
SensoMineR::graphinter(sensochoc, col.p = 4, col.j = 2, firstvar = 5, lastvar = 12,numr = 1, numc = 1)


# importar Json
jar<-jsonlite::fromJSON("https://husson.r-universe.dev/SensoMineR/data/JAR/json")

namesobjects

library(FactoMineR)
data(wines)


# ---------------------------------------------------------------------
# Rpackage Data Book: Ezequiel
# ---------------------------------------------------------------------




# ---------------------------------------------------------------------
# Dplyr ordnenado data sensorial expss
# ---------------------------------------------------------------------


# ---------------------------------------------------------------------
# Nuevo tipo de datos similar a haven_labelled
# ---------------------------------------------------------------------


# ---------------------------------------------------------------------
# Funciones para numeric, factor, charater
# ---------------------------------------------------------------------



# nolint end
