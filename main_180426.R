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
# No incluir por el momento, intentar usando ifelse y case_when

# ---------------------------------------------------------------------
# expss
# ---------------------------------------------------------------------

s <- mtcars
s %>% str()

s %<>% apply_labels(
  mpg = "Miles/(US) gallon",
  cyl = "Number of cylinders",
  disp = "Displacement (cu.in.)",
  hp = "Gross horsepower",
  drat = "Rear axle ratio",
  wt = "Weight (1000 lbs)",
  qsec = "1/4 mile time",
  vs = "Engine",
  vs = c(
    "V-engine" = 0,
    "Straight engine" = 1
  ),
  am = "Transmission",
  am = c(
    "Automatic" = 0,
    "Manual" = 1
  ),
  gear = "Number of forward gears",
  carb = "Number of carburetors"
)

attributes(s)
attributes(s$am)
attributes(m$cyl)
s %>% str()

attr(s$vs, "niveles") <- c("A" = 0, "B" = 1)

s %>% cross_cases(vs, am)
s %>% cross_cases(vs)
attributes(s$vs)

st <- mtcars
attributes(st$vs)
attributes(st$am)
attr(st$vs, "label") <- "Engine"
attr(st$vs, "labels") <- c("V-Engine" = 0, "Straight-Engine" = 1)
attr(st$am, "label") <- "Transmición"
attr(st$am, "labels") <- c("Automatica" = 0, "Manual" = 1)
st %>% cross_cases(vs, am)

st %>% str()

st %>%
  tab_cells(vs) %>%
  tab_cols(total(), am) %>%
  tab_stat_cases() %>%
  tab_pivot()

# >>>
# Funciones
# >>>

mi <- function(data, fila, col) {
  eval(substitute(
    data %>%
      tab_cells(fila) %>%
      tab_cols(col) %>%
      tab_stat_cpct() %>%
      tab_pivot()
  ))
}

mi(st, am, vs)

# >>>
# Respuesta multiple
# >>>

w <- product_test

w %>% str()

# Automatizando
# Asignando atributo usando eval(parse(text=txt))

vs <- w %>%
  names() %>%
  grep("a1", ., value = TRUE)
vs

for (i in seq_along(vs)) {
  txt <- paste0("attr(w$", vs[i], ",'respmult')<-'a1'")
  print(txt)
  eval(parse(text = txt))
}

vs <- w %>%
  names() %>%
  grep("b1", ., value = TRUE)
vs

for (i in seq_along(vs)) {
  txt <- paste0("attr(w$", vs[i], ",'respmult')<-'b1'")
  print(txt)
  eval(parse(text = txt))
}

attributes(w$a1_1)
attributes(w$b1_1)
w %>% str()

wt<-w

wt <-
  wt %>%
  let_if(cell == 1,
    h1_1 %to% h1_6 := recode(a1_1 %to% a1_6, other ~ copy),
    p1_1 %to% p1_6 := recode(b1_1 %to% b1_6, other ~ copy),
    h22 := recode(a22, other ~ copy),
    p22 := recode(b22, other ~ copy),
    c1r = c1
  ) %>%
  let_if(
    cell == 2,
    p1_1 %to% p1_6 := recode(a1_1 %to% a1_6, other ~ copy),
    h1_1 %to% h1_6 := recode(b1_1 %to% b1_6, other ~ copy),
    p22 := recode(a22, other ~ copy),
    h22 := recode(b22, other ~ copy),
    c1r := recode(c1, 1 ~ 2, 2 ~ 1, other ~ copy)
  )

wt %>% str

wt<-
wt %>%
  mutate(
    # recode age by groups
    # age_cat = recode(s2a, lo %thru% 25 ~ 1, lo %thru% hi ~ 2),
    # count number of likes
    # codes 2 and 99 are ignored.
    # h_likes = count_row_if(1 | 3 %thru% 98, h1_1 %to% h1_6),
    p_likes = count_row_if(1 | 3 %thru% 98, p1_1 %to% p1_6)
  )

codeframe_likes = num_lab("
    1 Liked everything
    2 Disliked everything
    3 Chocolate
    4 Appearance
    5 Taste
    6 Stuffing
    7 Nuts
    8 Consistency
    98 Other
    99 Hard to answer
")

overall_liking_scale = num_lab("
    1 Extremely poor 
    2 Very poor
    3 Quite poor
    4 Neither good, nor poor
    5 Quite good
    6 Very good
    7 Excellent
")

view(wt)

wt = apply_labels(wt, 
    c1r = "Preferences",
    c1r = num_lab("
        1 VSX123 
        2 SDF456
        3 Hard to say
    "),
    
    age_cat = "Age",
    age_cat = c("18 - 25" = 1, "26 - 35" = 2),
    
    h1_1 = "Likes. VSX123",
    p1_1 = "Likes. SDF456",
    h1_1 = codeframe_likes,
    p1_1 = codeframe_likes,
    
    h_likes = "Number of likes. VSX123",
    p_likes = "Number of likes. SDF456",
    
    h22 = "Overall quality. VSX123",
    p22 = "Overall quality. SDF456",
    h22 = overall_liking_scale,
    p22 = overall_liking_scale
)


product_test = product_test %>%
let(
# recode age by groups
age_cat = recode(s2a, lo %thru% 25 ~ 1, lo %thru% hi ~ 2),
wgt = runif(.N, 0.25, 4),
wgt = wgt/sum(wgt)*.N
) %>%
apply_labels(
age_cat = "Age",
age_cat = c("18- 25" = 1, "26- 35" = 2),
a1_1 = "Likes. VSX123",
b1_1 = "Likes. SDF456",
a1_1 = codeframe_likes,
b1_1 = codeframe_likes
)


product_test %<>% mutate(age_cat=case_when(
  s2a<25~1,TRUE~2
))

product_test = product_test %>% 
 apply_labels(
        age_cat = "Age",
        age_cat = c("18 - 25" = 1, "26 - 35" = 2),
        a1_1 = "Likes. VSX123",
        b1_1 = "Likes. SDF456",
        a1_1 = codeframe_likes,
        b1_1 = codeframe_likes
    )

product_test %>% 
    tab_cells(mrset(a1_1 %to% a1_6), mrset(b1_1 %to% b1_6)) %>% 
    tab_cols(total(), age_cat) %>%     
    tab_stat_cpct() %>% 
    tab_sort_desc() %>% 
    tab_pivot() %>% 
    tab_caption("Multiple-response variables with weighting")

library(data.table)






# nolint end
