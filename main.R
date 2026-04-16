# nolint start

# ---------------------------------------------------------------------
# Factores
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


#
# Cambiar la referencia de los niveles en una regresion
#
df <- data.frame(
  nombre = c("Ana", "Luis", "Pedro"),
  genero = factor(c("F", "M", "M")),
  y = c(13, 45, 56)
)
lm(y ~ genero, data = df) %>% summary()
df$genero <- relevel(df$genero, ref = "M")
lm(y ~ genero, data = df) %>% summary()


#
# Eliminar los niveles no usados
#
droplevels(f)

# nolint end
