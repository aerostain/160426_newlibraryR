# nolint start

# ---------------------------------------------------------------------
# Factores Base
# ---------------------------------------------------------------------

# Crear factores
x <- LETTERS[1:5]
x %>% str()

y <- rep(7:9, each = 3, times = 5)
y %>% str()

xf <- x %>% as.factor()
yf <- y %>% as.factor()

# R muestra los factores como texto (etiquetas) pero guarda
# sus valores como números, siempre empezando desde el 1 hasta # niveles.
xf %>% as.numeric()
yf %>% as.numeric()

# Para convertir factores:
#
# Caracter a Factor -> factor(x)
# Factor a Caracter -> as.character(f)
# Numeric a Factor -> factor(x)
# Factor a Numeric -> as.numeric(as.character(f))

# Ver niveles
xf %>% levels()
yf %>% levels()

# Asignar niveles
levels(yf) <- LETTERS[5:7]

# Reordenar niveles
factor(yf, levels = c("G", "E", "F"))

# Factores ordenados
w <- c(LETTERS[1:5], "A", "B")
wf <- factor(w, ordered = TRUE, levels = c("E", "B", "C", "D", "A"))
wf[wf == "A"]
wf[4] < wf[6]

prop.table(table(wf))

# ---------------------------------------------------------------------
# Forcats
# ---------------------------------------------------------------------

# Crear factores desde caracteres
q <- rep(letters[1:3], times = c(2, 5, 4))
q %<>% fct

# Reordenar niveles
q %<>% fct_relevel(c("b", "a", "c"))
q %<>% fct_relevel("c", after = 0)
q %<>% fct_relevel("c", after = Inf)

# Reordenar niveles según cantidad
q %<>% fct_infreq

# Reordenar según valor promedio de otraa variable en dataframe


# ---------------------------------------------------------------------
# Contenido adicional
# ---------------------------------------------------------------------

# Cambiar la referencia de los niveles en una regresion
df <- data.frame(
  nombre = c("Ana", "Luis", "Pedro"),
  genero = factor(c("F", "M", "M")),
  y = c(13, 45, 56)
)
lm(y ~ genero, data = df) %>% summary()
df$genero <- relevel(df$genero, ref = "M")
lm(y ~ genero, data = df) %>% summary()

# Eliminar los niveles no usados
droplevels(f)

# ---------------------------------------------------------------------
# Attributes
# ---------------------------------------------------------------------

# Permite ver o modificar los metadatos de un objeto

x <- 1:10
x %>% attributes()
names(x) <- letters[1:10]

# Agregar atributos
attributes(x) <- list(nombre = "Variable Principal", status = 123)
attr(x, "status") <- "Japon"

o <- rep(1:3, times = c(2, 5, 3))
o <- factor(o)
levels(o) <- letters[1:3]
attributes(o)

attr(o, "name") <- c("Sección del aula")
attr(o, "desc") <- c("Intentemos una descripción")
attributes(o)
o %>% str()

k <- rnorm(length(o))
attr(k, "name") <- c("Score promedio")
names(k) <- LETTERS[1:10]

md <- data.frame(mifac = o, miy = k)
md %>% str()
md$miy %>% attributes()
attr(md$miy, "nnames") <- LETTERS[1:10]
md$miy %>% attributes()

# Vector con atributos y sub-atributos
x <- rep(c(1, 0), times = c(4, 9))
attributes(x) <- list(labels = c("No" = 0, "Si" = 1), sname = "ScoreMean")
attributes(x) <- list(labels = c("No" = 0, "Si" = 1), levels = c("No" = 0, "Si" = 1), sname = "ScoreMean")
attributes(x)
x %>% factor()
x %>% as.factor()

attr(x, "labels") %>% names()

# GOLD
# Crear un factor a partir de un numeric con atributo label.
# Los niveles del nuevo factor deben coincidir simpre con los definidos en atributo label

x <- rep(c(1, 0), times = c(4, 9))
y <- rep(c(1, 0), times = c(4, 9))
attributes(x) <- list(labels = c("No" = 0, "Si" = 1), sname = "ScoreMean")
attributes(y) <- list(labels = c("Si" = 1, "No" = 0), sname = "ScoreMean")

x %>% str()
y %>% str()

attr(x, "labels")
attr(x, "labels") %>% names()
attr(y, "labels")
attr(y, "labels") %>% names()

factor(x) %>% str()
factor(y) %>% str()

attributes(x)$labels %>% str()
attributes(x)$labels
attributes(x)$labels %>% names()

xf <- factor(x)
levels(xf) <- attributes(x)$labels %>%
  sort() %>%
  names()

xf %>% str()

attributes(y)$labels %>% str()
attributes(y)$labels
attributes(y)$labels %>%
  sort() %>%
  names()

yf <- factor(y)
levels(yf) <- attributes(y)$labels %>%
  sort() %>%
  names()

yf %>% str()

# GOLD
# Otro ejemplo

z <- rep(c(5, 7, 2), times = c(3, 7, 2))
attributes(z) <- list(labels = c("Alto" = 7, "Medio" = 5, "Bajo" = 2))

z %>% str()
z %>% attributes()

zf <- factor(z)
levels(zf) <- attributes(z)$labels %>%
  sort() %>%
  names()

zf %>% str()
zf %>% unclass()
zf %>% attributes()


z
z %>% as_factor
inherits(z,"labelled")

# Agregamos una clase especial
class(x) <- "dbl+lbl"
x %>% str()

x %>% attributes()

yf %>% attributes()
nyf <- yf
class(nyf) <- "newfactor"
nyf %>% str()

table(yf)
table(nyf)
nyf %<>% as.factor()

# haven
library(haven)
as_factor(x) %>% str()

help(as_factor)



# nolint end
