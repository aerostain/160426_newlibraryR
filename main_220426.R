# nolint start

# ---------------------------------------------------------------------
# PCA
# ---------------------------------------------------------------------

library(tidyverse)
library(emmeans)
library(FactoMineR)
library(factoextra)
library(expss)

set.seed(123)

# 240 evaluaciones (como mencionaste)
n <- 240

data <- data.frame(
  Producto = factor(rep(paste0("Prod", 1:5), each = n / 5)),
  Dulzor = rnorm(n, mean = 5, sd = 1),
  Acidez = rnorm(n, mean = 4, sd = 1),
  Amargor = rnorm(n, mean = 3, sd = 1),
  Aroma = rnorm(n, mean = 6, sd = 1),
  Textura = rnorm(n, mean = 5, sd = 1),
  Aceptacion = rnorm(n, mean = 6, sd = 1)
)

write.csv(data, "Files/SuperdataProducto.csv")

head(data)

pca_res <- PCA(data[, -1], scale.unit = TRUE, graph = FALSE, axes = 1:6)$var
w <- pca_res

pca_res %>% str()
pca_res
pca_res$eig
pca_res$var
apply(pca_res$var$contrib, 2, sum)

pca_res$ind %>% str()
lapply(pca_res$ind, head)
apply(pca_res$ind$contrib, 1, sum)
pca_res$ind$dist
pca_res$ind$coord[, 1] %>% quantile()
pca_res$ind$coord[, 1] %>% hist()
apply(pca_res$var$cos2, 1, sum)

id1 <-
  sheet(
    cos2 = round(pca_res$ind$cos2[, 1], 5),
    coord = pca_res$ind$coord[, 1],
    data
  )

id1 %>% head()
id1 %>% dim()

id1 %<>%
  mutate(id = 1:240, lsigDim1 = ifelse(coord > 0, "Positivo", "Negativo"))

id1 %>%
  filter(cos2 > .3) %>%
  group_by(lsigDim1) %>%
  aggregate(cbind(Dulzor, Aceptacion, Aroma) ~ lsigDim1, FUN = mean, data = .)

id1 %>%
  filter(cos2 > .3) %>%
  group_by(lsigDim1) %>%
  count(Producto)

id1 %>%
  filter(cos2 < .3) %>%
  group_by(lsigDim1) %>%
  aggregate(cbind(Dulzor, Aceptacion, Aroma) ~ lsigDim1, FUN = mean, data = .)

id1 %>%
  filter(cos2 < .3) %>%
  group_by(lsigDim1) %>%
  count(Producto)

id1 %>%
  filter(cos2 > .3) %>%
  count(lsigDim1)

fviz_pca_ind(
  pca_res,
  col.ind = data$Producto
)

id1 %>% select()

idim1 <- pca_res$ind$cos2[, 1]
a <- case_when(idim1 >= .3 ~ 1, TRUE ~ 0)
table(a)

pca_res$ind$coord[1:10]
pca_res$ind$coord[, 1]

fviz_eig(pca_res, addlabels = TRUE, ylim = c(0, 50))

head(pca_res$ind$coord)

data %>% str()
anova_dulzor <- aov(Dulzor ~ Producto, data = data)
summary(anova_dulzor)
lm(Dulzor ~ Producto, data = data) %>% summary()
lm(Dulzor ~ Producto, data = data) %>% emmeans(., pairwise ~ Producto)

scores <- as.data.frame(pca_res$ind$coord)
scores$Producto <- data$Producto

anova_pc1 <- aov(Dim.1 ~ Producto, data = scores)
summary(anova_pc1)

lm(Dim.1 ~ Producto, data = scores) %>% summary()
lm(Dim.1 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)
lm(Dim.2 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)
lm(Dim.3 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)
lm(Dim.4 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)
lm(Dim.5 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)

scores %>%
  tab_cells(Dim.1, Dim.2, Dim.3, Dim.4, Dim.5) %>%
  tab_cols(Producto) %>%
  tab_stat_mean() %>%
  tab_pivot()


hc <- hclust(dist(scores[, 1:2]))
plot(hc)

?hclust

scores[, 1:2] %>% head()
scores[, 1:2] %>%
  dist() %>%
  str()

dist(cars[1:5, ])

fviz_pca_biplot(
  pca_res,
  geom.ind = "point",
  col.ind = data$Producto,
  palette = "jco",
  addEllipses = TRUE,
  label = "var"
)

fviz_contrib(pca_res, choice = "var", axes = 1)
fviz_contrib(pca_res, choice = "var", axes = 2)

data %>%
  names() %>%
  matrix()

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Acidez"]), method = lm, col = "red")

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Textura"]), method = lm, col = "red")

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Dulzor"]), method = lm, col = "red")

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aroma"]), method = lm, col = "red")

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_point(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), alpha = .2, col = "blue") +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Amargor"]), method = lm, col = "red") +
  geom_point(aes(pca_res$ind$coord[, 1], data[, "Amargor"]), alpha = .2, col = "red")

pca_res$var

d1 <-
  ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Acidez"]), method = lm, col = "orange") +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Textura"]), method = lm, col = "red") +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Dulzor"]), method = lm, col = "green") +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Aroma"]), method = lm, col = "yellow") +
  geom_smooth(aes(pca_res$ind$coord[, 1], data[, "Amargor"]), method = lm, col = "violet") +
  geom_vline(aes(xintercept = median(pca_res$ind$coord[, 1])))

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Aceptacion"]), method = lm) +
  geom_point(aes(pca_res$ind$coord[, 2], data[, "Aceptacion"])) +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Acidez"]), method = lm, col = "orange") +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Textura"]), method = lm, col = "red") +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Dulzor"]), method = lm, col = "green") +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Aroma"]), method = lm, col = "yellow") +
  geom_smooth(aes(pca_res$ind$coord[, 2], data[, "Amargor"]), method = lm, col = "violet")

ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Acidez"]), method = lm, col = "orange") +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Textura"]), method = lm, col = "red") +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Dulzor"]), method = lm, col = "green") +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Aroma"]), method = lm, col = "yellow") +
  geom_smooth(aes(pca_res$ind$coord[, 3], data[, "Amargor"]), method = lm, col = "violet")


d5 <-
  ggplot() +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Aceptacion"]), method = lm) +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Acidez"]), method = lm, col = "orange") +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Textura"]), method = lm, col = "red") +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Dulzor"]), method = lm, col = "green") +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Aroma"]), method = lm, col = "yellow") +
  geom_smooth(aes(pca_res$ind$coord[, 5], data[, "Amargor"]), method = lm, col = "violet") +
  geom_vline(aes(xintercept = median(pca_res$ind$coord[, 5])))

library(gridExtra)
gridExtra::grid.arrange(d1, d5, ncol = 2)

tmp <- data.frame(dim1 = pca_res$ind$coord[, 1], data)

tmp$dim5 <- pca_res$ind$coord[, 5]
tmp %<>% mutate(gdim5 = ifelse(dim5 <= median(dim5), 0, 1))
tmp %>% head()

tmp %>%
  group_by(gdim1) %>%
  summarise(mDulzor = mean(Dulzor), mAceptacion = mean(Aceptacion), n = n())
tmp %>%
  group_by(gdim5) %>%
  summarise(mDulzor = mean(Dulzor), mAceptacion = mean(Aceptacion), n = n())

ggplot() +
  geom_point(aes(pca_res$ind$coord[, 2], data[, "Aceptacion"]))
ggplot() +
  geom_point(aes(pca_res$ind$coord[, 5], data[, 6]))


data %>% count(d1)

data %<>%
  mutate(d1 = ifelse(Dulzor < median(Dulzor) & Aroma < median(Aroma) & Acidez < median(Acidez) & Textura < median(Textura), 1, NA))

data %<>%
  mutate(d1 = ifelse(Dulzor > median(Dulzor) & Aroma > median(Aroma) & Acidez > median(Acidez) & Textura > median(Textura), 2, d1))

data %<>%
  mutate(d1 = ifelse(Acidez < median(Acidez) & Textura < median(Textura), 2, d1))

data %>%
  group_by(d1) %>%
  summarise(aceptacion = mean(Aceptacion))



fviz_eig(pca_res, addlabels = TRUE, ylim = c(0, 50))

fviz_pca_biplot(
  pca_res,
  geom.ind = "point",
  col.ind = data$Producto,
  palette = "jco",
  addEllipses = TRUE,
  label = "var"
)

fviz_pca_biplot(
  pca_res,
  geom.ind = "point",
  col.ind = data$Producto,
  palette = "jco",
  label = "var"
)

fviz_contrib(pca_res, choice = "var", axes = 1)
fviz_contrib(pca_res, choice = "var", axes = 2)
fviz_contrib(pca_res, choice = "var", axes = 3)

library("corrplot")
corrplot(pca_res$var$cos2, method = "number", is.corr = FALSE)

head(pca_res$ind$coord)

anova_dulzor <- aov(Dulzor ~ Producto, data = data)
summary(anova_dulzor)

lm(Dulzor ~ Producto, data = data) %>% emmeans::emmeans(., pairwise ~ Producto)

manova_res <- manova(cbind(Dulzor, Acidez, Amargor, Aroma, Textura, Aceptacion) ~ Producto, data = data)
summary(manova_res)

scores <- as.data.frame(pca_res$ind$coord)
scores$Producto <- data$Producto

anova_pc1 <- aov(Dim.1 ~ Producto, data = scores)
summary(anova_pc1)

lm(Dim.1 ~ Producto, data = scores) %>% emmeans(., pairwise ~ Producto)

hc <- hclust(dist(scores[, 1:2]))
plot(hc)

hclust(dist(scores[1:10, 1:2]))

fviz_pca_ind(pca_res,
  col.ind = "cos2",
  gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
  repel = TRUE
)

fviz_pca_ind(pca_res)

fviz_pca_ind(pca_res,
  geom.ind = "point",
  col.ind = data$Producto,
  addEllipses = TRUE,
  ellipse.type = "confidence",
  legend.tittle = "Groups"
)

fviz_pca_biplot(pca_res,
  col.ind = data$Producto, palette = "jco",
  addEllipses = TRUE, label = "var",
  col.var = "black", repel = TRUE,
  ellipse.type = "confidence",
  legend.title = "Species"
)

# ---------------------------------------------------------------------
#
# ---------------------------------------------------------------------

library(tidyverse)
library(expss)
data(decathlon2)
decathlon2 %>% str()
e <- decathlon2
e %>% str()

e %>% cross_cases(Rank, Competition)
e %>% head()

e %>%
  tab_cells(X100m) %>%
  tab_rows(Rank) %>%
  tab_cols(Competition) %>%
  tab_stat_mean() %>%
  tab_pivot()

e %>%
  group_by(Competition, Rank) %>%
  summarise(xp = mean(X100m))


e$Ind <- e %>% rownames()

e %>%
  filter(Competition != "Decastar") %>%
  select(Competition, Rank, Points) %>%
  arrange(-Points)

e %<>% mutate(Ind = str_to_title(Ind))
e %<>% select(everything(), -nInd)
e %>% str()

e %>%
  select(Competition, Rank, Ind, Points) %>%
  arrange(Competition, -Points) %>%
  sheet()

cor(scale(e$Points), scale(e$Rank))

data()
?scale

# ---------------------------------------------------------------------
# PCA iris
# ---------------------------------------------------------------------

i <- iris
i %>% str()
pca <- PCA(i[, -5], scale.unit = TRUE, graph = FALSE)

pca$eig
apply(pca$var$cos2, 1, sum)


# ---------------------------------------------------------------------
# PCA Ezequiel
# ---------------------------------------------------------------------
library(haven)
m <- expss::read_spss(file.choose())
m %>% head
m %>% dim
m %>% str
m %>% fix

sheet(apply(m,2,\(x)sum(is.na(x))) %>% matrix,names(m))

m %>% str
m %<>% mutate(capital=ifelse(is.na(capital),mean(capital,na.rm=TRUE),capital))
m %<>% mutate(benefico=ifelse(is.na(benefico),mean(benefico,na.rm=TRUE),benefico))
m %<>% mutate(plantill=ifelse(is.na(plantill),mean(plantill,na.rm=TRUE),plantill))

pca <- PCA(m[, -c(1,2)], scale.unit = TRUE, graph = FALSE)
pca $eig
pca $var


# nolint end
