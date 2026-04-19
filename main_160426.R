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

# ---------------------------------------------------------------------
# Factor con niveles ordenados a partir de numeric con atributos
# ---------------------------------------------------------------------

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
z %>% as_factor()
inherits(z, "labelled")


# ---------------------------------------------------------------------
# Creando objeto de clase: haven_labelled
# ---------------------------------------------------------------------

# Clase nueva: "labelled" -> haven
# revisar help(labelled)
# Permite que un numeric tenga labels y label
# Se le asigan una clase
u <- rep(0:2, times = c(3, 5, 2))
attr(u, "labels") <- c("no" = 0, "talvez" = 1, "sí" = 2)
class(u) <- "labelled"

u %>% str()

inherits(u, "labelled")

# Clase haven_labelled
# Crea un objeto a partir de una clase definida en el sistema
library(haven)
h <- labelled(
  rep(0:2, times = c(3, 5, 2)),
  labels = c("Low" = 0, "Medium" = 1, "Hi" = 2),
  label = "Un objeto clase haven"
)

h %>% str()

inherits(h, "haven_labelled")

# ---------------------------------------------------------------------
# Ggplot + haven_labelled
# ---------------------------------------------------------------------

xu <- labelled(
  rep(3:1, times = c(5, 3, 2)),
  labels = c("Sobresaliente" = 3, "Moderado" = 2, "Normal" = 1),
  label = "Score Survey"
)

xu
xu %>% str()
xu %>% class()

yu <- sort(rnorm(length(xu)))

mi <- data.frame(x = xu, y = yu)

af <- \(x){
  as.factor(x)
}

# use_labels es de expss
# Sin importar como, siempre toma los valores de x como numeric
use_labels(mi, {
  mi %>%
    ggplot(aes(x, y, fill = as.factor(x))) +
    geom_boxplot(alpha = .2, width = .2)
})

# convirtiendo a factor
# Soluciona pero se hace pesado estar invocando as.factor cada vez
af <- \(x){
  as.factor(x)
}

mi %>%
  ggplot(aes(af(x), y, fill = af(x))) +
  geom_boxplot(alpha = .2, width = .2)

# ---------------------------------------------------------------------
# Clases S3
# ---------------------------------------------------------------------

# Básico
# La clase es solo un nombre, primero se crea el objeto, sus métodos y
# según el tipo de objeto al invocar el método este devuelve el resultado.

# Creamos la estructura (Clase)
alumno <- function(nm, ap, ed, zon) {
  # Validación
  stopifnot(is.character(nm), is.character(ap))
  stopifnot(is.numeric(ed), ed >= 5, ed <= 17)
  stopifnot(is.character(zon), length(zon) == 1)

  # Estructuura de la Clase
  structure(
    list(nombre = nm, apellido = ap, edad = ed, zona = zon),
    class = "alumno"
  )
}

# Creamos el método para la clase
# Definimos el nombre del método en el sistema
presentacion <- function(x) {
  UseMethod("presentacion")
}

# Creamos la operativa del método
presentacion.alumno <- function(x) {
  paste("Hola, mi nombre es", x$nombre, x$apellido, "y tengo", x$edad, "años.")
}

# Creamos los objetos
a <- alumno("Ana", "Robles", 13, "A")
presentacion(a)

v <- alumno("Vanessa", "Huerta", 15, "B")
presentacion(v)

# Agregando métodos a la estructura (Clase)

print.alumno <- function(x) {
  paste("Soy", x$nombre, x$apellido)
}

# Agregando Método de Mutación Implicita
# como R no permite se debe reasignar
cumpleanios <- function(x) {
  UseMethod("cumpleanios")
}

cumpleanios.alumno <- function(x) {
  x$edad <- x$edad + 1
  x
}

a$ed
a <- cumpleanios(a)
a$ed

# Ejemplo cajero automático

cuenta_bancaria <- function(sd, ti) {
  stopifnot(
    is.numeric(sd), length(sd) == 1, sd >= 0,
    is.character(ti), length(ti) == 1
  )

  structure(
    list(saldo = sd, titular = ti),
    class = "cuenta_bancaria"
  )
}

print.cuenta_bancaria <- function(x, ...) {
  cat("Cuenta bancaria\n")
  cat("Titular:", x$titular, "\n")
  cat("Saldo:", x$saldo, "\n")
}

# Los ... permite extensibilidad
# cada clase decide qué hacer con esos argumentos
# no es el método el que decide los argumentos sino la clase
# print(x, digits = 3)
retirar <- function(x, monto, ...) {
  UseMethod("retirar")
}

retirar.cuenta_bancaria <- function(x, monto) {
  stopifnot(is.numeric(monto), monto > 0)

  if (monto > x$saldo) {
    stop("Fondos insuficientes")
  }

  x$saldo <- x$saldo - monto
  x
}

depositar <- function(x, monto, ...) {
  UseMethod("depositar")
}

depositar.cuenta_bancaria <- function(x, monto) {
  stopifnot(is.numeric(monto), monto > 0)

  x$saldo <- x$saldo + monto
  x
}

saldo <- function(x) {
  UseMethod("saldo")
}

saldo.cuenta_bancaria <- function(x) {
  x$saldo
}

# Para uso interno
format.cuenta_bancaria <- function(x, ...) {
  paste0(x$titular, " (Saldo: ", x$saldo, ")")
}


cliente1 <- cuenta_bancaria(2500, "Ana Robles")
print(cliente1)
cliente1 <- retirar(cliente1, 300)
print(cliente1)
cliente1 <- depositar(cliente1, 500)
print(cliente1)
saldo(cliente1)
format(cliente1)

help(labelled)
help(length)



# ---------------------------------------------------------------------
# Temporal
# ---------------------------------------------------------------------

library(vctrs)
library(dplyr)
library(ggplot2)


new_porcentaje <- function(x = double(), label = NULL) {
  # Normalizar SIEMPRE
  x <- vec_cast(x, double())

  # Validar tipo
  vec_assert(x, double())

  # Validar rango
  if (any(x < 0 | x > 1, na.rm = TRUE)) {
    stop("Valores deben estar entre 0 y 1")
  }

  structure(
    x,
    label = label,
    class = c("porcentaje", "vctrs_vctr")
  )
}

porcentaje <- function(x, label = NULL) {
  new_porcentaje(x, label)
}

format.porcentaje <- function(x, ...) {
  paste0(round(unclass(x) * 100, 1), "%")
}

print.porcentaje <- function(x, ...) {
  cat(format(x), "\n")
}

vec_ptype2.porcentaje.porcentaje <- function(x, y, ...) {
  new_porcentaje()
}

vec_cast.porcentaje.porcentaje <- function(x, to, ...) {
  x
}

vec_ptype2.porcentaje.double <- function(x, y, ...) double()
vec_ptype2.double.porcentaje <- function(x, y, ...) double()

vec_cast.double.porcentaje <- function(x, to, ...) {
  unclass(x)
}

vec_cast.porcentaje.double <- function(x, to, ...) {
  new_porcentaje(x)
}

`+.porcentaje` <- function(e1, e2) {
  # convertir e2 correctamente
  if (inherits(e2, "porcentaje")) {
    e2 <- vec_cast(e2, e1)
    val <- unclass(e1) + unclass(e2)
  } else {
    e2 <- vec_cast(e2, double())
    val <- unclass(e1) + e2
  }

  new_porcentaje(val, label = attr(e1, "label"))
}

x <- porcentaje(c(0.2, 0.5, 0.8))

x + 0.1

df <- tibble(
  categoria = c("A", "B", "C"),
  valor = porcentaje(c(0.2, 0.5, 0.8))
)

df %>%
  mutate(
    valor2 = valor + 0.1
  )

scale_y_porcentaje <- function() {
  scale_y_continuous(labels = function(x) paste0(x * 100, "%"))
}

ggplot(df, aes(x = categoria, y = valor)) +
  geom_col() +
  scale_y_porcentaje()


# ---------------------------------------------------------------------
# summarise
# ---------------------------------------------------------------------

x <- porcentaje(.15)

x %>% unclass()
x %>% str()

factor(1:3) %>% unclass() + 1


mean.porcentaje <- function(x, ..., na.rm = FALSE) {
  val <- mean(unclass(x), ..., na.rm = na.rm)
  new_porcentaje(val)
}

sum.porcentaje <- function(x, ..., na.rm = FALSE) {
  val <- sum(unclass(x), ..., na.rm = na.rm)
  new_porcentaje(val)
}

mean(c(x, x + .5))
sum(c(x, x + .5))

x <- porcentaje(c(0.2, 0.5, 0.8))

mean(x)
sum(x)

df %>%
  summarise(
    prom = mean(valor)
  )

x <- sample(seq(0, 1, 0.1), 15, replace = T)
g <- rep(LETTERS[1:3], each = 5)
m <- data.frame(x = porcentaje(x), g = g)

m %>%
  group_by(g) %>%
  summarise(xp = mean(x))

# Regresion

vec_cast.double.porcentaje <- function(x, to, ...) {
  unclass(x)
}

vec_arith.porcentaje <- function(op, x, y, ...) {
  UseMethod("vec_arith.porcentaje", y)
}

vec_arith.porcentaje.porcentaje <- function(op, x, y, ...) {
  x_val <- unclass(x)
  y_val <- unclass(y)

  out <- switch(op,
    "+" = x_val + y_val,
    "-" = x_val - y_val,
    "*" = x_val * y_val,
    "/" = x_val / y_val,
    stop("Operación no soportada")
  )

  new_porcentaje(out)
}

vec_arith.porcentaje.double <- function(op, x, y, ...) {
  x_val <- unclass(x)

  out <- switch(op,
    "+" = x_val + y,
    "-" = x_val - y,
    "*" = x_val * y,
    "/" = x_val / y,
    stop("Operación no soportada")
  )

  new_porcentaje(out)
}

vec_arith.double.porcentaje <- function(op, x, y, ...) {
  y_val <- unclass(y)

  out <- switch(op,
    "+" = x + y_val,
    "-" = x - y_val,
    "*" = x * y_val,
    "/" = x / y_val,
    stop("Operación no soportada")
  )

  new_porcentaje(out)
}

df2 <- tibble(
  x = 1:3,
  y = porcentaje(c(0.2, 0.5, 0.8))
)

lm(y ~ x, data = df2)
lm(as.numeric(y) ~ x, data = df2)


# ---------------------------------------------------------------------
# Crear tipo labelled de haven
# ---------------------------------------------------------------------

library(vctrs)

new_mi_labelled <- function(x = double(), labels = NULL, label = NULL) {
  x <- vec_cast(x, x) # flexible

  # validar labels
  if (!is.null(labels)) {
    if (!is.numeric(labels) && !is.character(labels)) {
      stop("labels deben ser numeric o character")
    }
  }

  structure(
    x,
    labels = labels,
    label = label,
    class = c("mi_labelled", "vctrs_vctr")
  )
}


mi_labelled <- function(x, labels = NULL, label = NULL) {
  new_mi_labelled(x, labels, label)
}

x <- mi_labelled(
  c(1, 2, 1, NA),
  labels = c("Sí" = 1, "No" = 2),
  label = "Pregunta 1"
)

print.mi_labelled <- function(x, ...) {
  cat("<mi_labelled>\n")
  cat("Label:", attr(x, "label"), "\n")
  cat("Values:\n")
  print(unclass(x))
  cat("Labels:\n")
  print(attr(x, "labels"))
}

get_labels <- function(x) {
  attr(x, "labels")
}

get_label <- function(x) {
  attr(x, "label")
}

as_factor.mi_labelled <- function(x, ...) {
  labs <- attr(x, "labels")
  vals <- unclass(x)
  
  factor(
    vals,
    levels = labs,
    labels = names(labs)
  )
}

x
x %>% as_factor
x %>% get_label()
x %>% get_labels()
x %>% class()
x %>% str()

vec_ptype2.mi_labelled.mi_labelled <- function(x, y, ...) {
  x
}

vec_cast.mi_labelled.mi_labelled <- function(x, to, ...) {
  x
}

vec_cast.double.mi_labelled <- function(x, to, ...) {
  unclass(x)
}

vec_arith.mi_labelled <- function(op, x, y, ...) {
  val <- vec_arith(op, unclass(x), y)
  new_mi_labelled(val, attr(x, "labels"), attr(x, "label"))
}

to_factor <- function(x, drop_na = TRUE) {
  f <- as_factor(x)
  
  if (drop_na) {
    f <- droplevels(f)
  }
  
  f
}

vec_restore.mi_labelled <- function(x, to, ...) {
  structure(
    x,
    labels = attr(to, "labels"),
    label = attr(to, "label"),
    class = class(to)
  )
}

x %>% to_factor

df <- tibble::tibble(
  sexo = mi_labelled(
    c(1,2,1,NA),
    labels = c("Hombre" = 1, "Mujer" = 2)
  )
)

df %>%
  dplyr::mutate(
    sexo = as_factor(sexo)
  )


print(df)

# ---------------------------------------------------------------------
# mi_labelled  + ggplot sin convertir a factor
# ---------------------------------------------------------------------

library(vctrs)

new_mi_labelled <- function(x, labels = NULL, label = NULL) {
  x <- vec_cast(x, double()) 
  
  structure(
    x,
    labels = labels,
    label = label,
    class = c("mi_labelled", "vctrs_vctr")
  )
}

mi_labelled <- function(x, labels = NULL, label = NULL) {
  new_mi_labelled(x, labels, label)
}

vec_proxy.mi_labelled <- function(x, ...) {
  labs <- attr(x, "labels")
  vals <- unclass(x)
  
  factor(
    vals,
    levels = labs,
    labels = names(labs)
  )
}

print.mi_labelled <- function(x, ...) {
  print(vec_proxy(x))
}

library(ggplot2)
library(tibble)

df <- tibble(
  sexo = mi_labelled(
    c(1, 2, 1, NA),
    labels = c("Hombre" = 1, "Mujer" = 2)
  )
)

sexo %>% class
sexo %>% str

ggplot(df, aes(x = sexo)) +
  geom_bar()

ggplot(df, aes(x = factor(sexo))) +
  geom_bar()

vec_proxy(df$sexo)
vec_proxy(sexo) %>% class

plot(cars)

# ---------------------------------------------------------------------
# labelled
# ---------------------------------------------------------------------

new_mi_labelled <- function(x = double(), labels = NULL, label = NULL) {
  x <- vctrs::vec_cast(x, double())
  
  structure(
    x,
    labels = labels,
    label = label,
    class = c("mi_labelled", "vctrs_vctr")
  )
}

x <- mi_labelled(
  c(1, 2, 99, NA),
  labels = c(
    "Sí" = 1,
    "No" = 2,
    "No sabe" = 99
  )
)


is_labelled_na <- function(x) {
  labs <- attr(x, "labels")
  vals <- unclass(x)
  
  vals %in% labs[grepl("No sabe|No responde", names(labs))]
}

is_labelled_na(x)

as.factor.mi_labelled <- function(x) {
  labs <- attr(x, "labels")
  vals <- vctrs::vec_data(x)  #  mejor que unclass
  
  base::factor(
    vals,
    levels = labs,
    labels = names(labs),
    exclude = NULL
  )
}

x %>% as.factor
x %>% class

as.character.mi_labelled <- function(x, ...) {
  f <- as.factor(x)
  
  out <- as.character(f)
  
  out[is.na(x)] <- "Missing"
  
  out
}

scale_x_labelled <- function(...) {
  ggplot2::scale_x_discrete(
    drop = FALSE,  # no eliminar niveles
    ...
  )
}

scale_x_labelled <- function(na.translate = TRUE, ...) {
  ggplot2::scale_x_discrete(
    na.translate = na.translate,
    drop = FALSE,
    ...
  )
}

df <- tibble(
  sexo = x
)

ggplot(df, aes(x = sexo)) +
  geom_bar() +
  scale_x_labelled()

as.factor(x)
as.factor.mi_labelled(x)


# ---------------------------------------------------------------------
# Test
# ---------------------------------------------------------------------

mpg %>% sapply(.,class)
mpg %>% lapply(.,class)

x %>% sapply(.,class)
x %>% lapply(.,class)

apply(mpg,2,class)


apropos("lm")
RSiteSearch("table")
sessionInfo()

object.size(mpg)

apply %>% str

mpg %>% str

mpg %>% split(.$year) %>% 
map(dim)

with(mpg,tapply(displ,year,mean))

mpg %>% summarise(across(everything(), length))


help(tapply)

# ---------------------------------------------------------------------
# do.call
# ---------------------------------------------------------------------

ms<-list(mpg,mpg,mpg)
do.call(rbind,ms)

do.call(rbind,lapply(ms,\(x){mean(x$displ)}))

do.call()

mpg %>% is.factor()














# nolint end
