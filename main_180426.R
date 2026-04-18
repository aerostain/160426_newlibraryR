# nolint start

# 180426

# ---------------------------------------------------------------------
# Funciones dplyr
# ---------------------------------------------------------------------

mif <- function(df, g, x) {
  resum <-
    df %>%
    group_by({{ g }}) %>%
    summarise(xp = mean({{ x }}))

  return(resum)
}

mif(mpg, drv, displ)
mif(mpg, fl, displ)

mpg %>% str()
mpg$cyl %>% cro()
mpg$fl %>% cro()


# ---------------------------------------------------------------------
# Reorganizar valores (factor, numeric, chr)
# ---------------------------------------------------------------------

mpg %>% str()

# Factores
# fct_collapse funciona con factores y character
# Se puede usar setdiff dentro de fct_collapse pero solo es úitl
# cuando quiero agrupar a solo 2 categorías (trans: auto/manual)
# mejor usar case_when
# fct_ funciona con data frames y con vectores (m$class)
m <- mpg

m %<>% mutate(fl = fct_collapse(fl, "p" = c("c", "d", "e")))
m %<>% mutate(cyl = fct_collapse(cyl, "8" = "5"))

m %>% distinct(class)
m %>% count(class)

m %<>% mutate(nclass = fct_collapse(class,
  "mini" = c("compact", "2seater", "subcompact"),
  "normal" = c("midsize", "minivan"),
  other_level = "tall"
))

# Al crear un factor los niveles se ordenan en orden alfabético
# fct_infreq ordena niveles de mayor a menor según frecuencia
# fct_lump_min junta todos los niveles con frecuencias pequeñas
# fct_reorder reordena los niveles según otra variable (median)
# fct_rev cambia e orden de los factores, útil para gráficos
# fct_explicit_na crea un nuevo nivel para los Missing funciona
# pero se ha reemplazado por fct_na_value_to_level
m %>% str()
m$fl %>% levels()
m$fl %>% str()
m %>% count(fl)
fct_infreq %>% str()

# fct_infreq ordena niveles de mayor a menor según frecuencia
m %>%
  mutate(fl = fct_infreq(fl)) %>%
  count(fl)

# fct_lump_min junta todos los niveles con frecuencias pequeñas
m %>%
  count(class) %>%
  arrange(n)

m %>%
  mutate(fclass = factor(class)) %>%
  mutate(fclass = fct_lump_min(fclass, 40, other_level = "varios")) %>%
  count(fclass) %>%
  arrange(n)

# fct_reorder reordena los niveles según otra variable (median)
# usar fct_reorder %>% str
m %>% str()
m %>%
  group_by(cyl) %>%
  summarise(xp = median(displ))
m %>%
  group_by(cyl) %>%
  summarise(xp = length(displ))

m %>%
  mutate(tmp = fct_reorder(cyl, displ)) %>%
  count(tmp)
m %>%
  mutate(tmp = fct_reorder(cyl, displ, .fun = length)) %>%
  count(tmp)

# fct_rev cambia e orden de los factores, útil para gráficos
m %>% count(cyl)
m %>%
  mutate(tmp = fct_rev(cyl)) %>%
  count(tmp)

# fct_explicit_na crea un nuevo nivel para los Missing funciona
# pero se ha reemplazado por fct_na_value_to_level
m %<>% mutate(ncyl = case_when(
  displ > 6 ~ NA,
  TRUE ~ cyl
))

m %>% count(ncyl)

m %>%
  mutate(ncyl = fct_na_value_to_level(ncyl, level = "(Missing)")) %>%
  count(ncyl)

# Character
# Se puede convertir a factores pero puede tener muchos niveles (max 5)
# Los textos pueden ser largos y complejos para convertir a factores
# ifelse y case_when permite usar otra variable en la condicional
m <- mpg
m %>% distinct(manufacturer)
m %>% count(manufacturer)

# Opcionales
m %>% reframe(unique(manufacturer))
m$manufacturer %>% unique()
m %>% distinct(manufacturer)
m %>% count(manufacturer)

# ifelse y case_when mantienen como texto
# si se desea al final se puede convertir en factores
m %<>% mutate(
  nman =
    ifelse(manufacturer %in%
      c("hyundai", "honda", "nissan", "subaru", "toyota"),
    "asian", manufacturer
    )
)

m %<>% mutate(
  nman =
    case_when(
      nman %in% c("audi", "volkswagen") ~ "european",
      TRUE ~ nman
    )
)

m %<>% mutate(
  nman = ifelse(nman %in% c("asian", "european"), nman, "american")
)

m %>% count(nman)
m$nman %<>% as.factor()

# Nueva variable texto, se dee convertir a factor
m %>%
  mutate(tmp = case_when(
    displ > mean(displ) ~ "Hi",
    TRUE ~ "Low",
  )) %>%
  count(tmp)

# Numeric
m <- mpg

# case_when funciona incluso con números
m %>%
  mutate(tmp = case_when(
    displ > mean(displ) ~ 1,
    TRUE ~ 2,
  )) %>%
  count(tmp)

m$displ %>% quantile()

m %>%
  mutate(tmp = case_when(
    displ <= 2.4 ~ 1,
    displ > 2.4 & displ <= 4.6 ~ 2,
    TRUE ~ 3
  )) %>%
  count(tmp)

(quantile(m$displ, .9) - quantile(m$displ, .1)) %>% as.numeric()

# recode/expss






# nolint end
