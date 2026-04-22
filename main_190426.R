# nolint start

# ---------------------------------------------------------------------
# Expss
# ---------------------------------------------------------------------

?apply_labels
data(product_test)
p <- product_test
p %>% str()
fix(p)

quantile(p$s2a, c(.1, .25, .5, .75, .9))

# ---------------------------------------------------------------------
# Funcion Histograma
# ---------------------------------------------------------------------

y <- round(abs(rnorm(100, 10, 25)), 2)

rango <- max(y) - min(y)
k <- 1 + 3.3 * log(length(y), 10)

min(y)

k <- sqrt(100)
A <- rango / k

intervalos <- function(y) {
  n <- length(y)
  mn <- min(y)
  mx <- max(y)

  k <- ceiling(1 + 3.3 * log(n, 10))
  A <- round((mx - mn) / k, 2)

  li <- rep(0, length.out = k)
  ls <- rep(0, length.out = k)
  interv <- rep(0, length.out = k)
  freq <- rep(0, length.out = k)

  for (i in seq_len(k - 1)) {
    ls[i] <- mn + i * A
    li[i] <- mn + (i - 1) * A
    interv[i] <- c(paste0("[", li[i], "  ;  ", ls[i], ">"))
    freq[i] <- sum(ifelse(y >= li[i] & y < ls[i], TRUE, FALSE))
  }

  li[k] <- ls[k - 1]
  ls[k] <- mx
  interv[k] <- c(paste0("[", li[k], "  ;  ", ls[k], "]"))
  freq[k] <- sum(ifelse(y >= li[k] & y <= ls[k], TRUE, FALSE))

  tabf <- data.frame(Intervalos = interv, FreqAbs = freq, FreqRel = round(freq / n, 2))

  print(tabf)

  tabf %>%
    ggplot(aes(Intervalos, FreqAbs)) +
    geom_col()
}

help(format)

# for (i in seq_len(k - 1)) {
#   print(paste0("[", li[i], " ; ", ls[i], "> : ", freq[i]))
# }
# print(paste0("[", li[k], " ; ", ls[k], "] : ", freq[k]))


read_csv %>% str()
z <- read_csv(file.choose(), col_names = FALSE)

intervalos(z$X1)

y <- rpois(240, 25)
intervalos(y)


intervalos2 <- function(y) {
  n <- length(y)
  mn <- min(y)
  mx <- max(y)

  # Número de clases (Sturges)
  k <- ceiling(1 + 3.3 * log10(n))

  # Amplitud
  A <- (mx - mn) / k

  # Límites de clase
  breaks <- seq(mn, mx, length.out = k + 1)

  # Intervalos como factor
  clases <- cut(y, breaks = breaks, include.lowest = TRUE, right = FALSE)

  # Frecuencias
  freq <- as.vector(table(clases))

  # Tabla
  tabf <- data.frame(
    Intervalos = levels(clases),
    FreqAbs = freq,
    FreqRel = round(freq / n, 2)
  )

  print(tabf)

  # Histograma tipo columnas
  barplot(freq,
    names.arg = levels(clases), las = 2,
    main = "Histograma", ylab = "Frecuencia",
    col = "lightblue", border = "black"
  )
}

intervalos2(y)
intervalos2(z$X1)

intervalos3 <- function(y, dec = 2) {
  n <- length(y)
  mn <- min(y)
  mx <- max(y)

  # Número de clases (Sturges)
  k <- ceiling(1 + 3.3 * log10(n))

  # Límites
  breaks <- seq(mn, mx, length.out = k + 1)

  # Intervalos
  clases <- cut(y, breaks = breaks, include.lowest = TRUE, right = FALSE)

  # Frecuencias
  freq <- as.vector(table(clases))

  # Frecuencia acumulada
  fac <- cumsum(freq)

  # Porcentajes
  perc <- round(100 * freq / n, dec)
  perc_acum <- round(100 * fac / n, dec)

  # Mejorar etiquetas
  li <- head(breaks, -1)
  ls <- tail(breaks, -1)

  etiquetas <- paste0(
    "[", round(li, dec), ", ", round(ls, dec),
    ifelse(seq_along(ls) == length(ls), "]", ")")
  )

  # Tabla
  tabf <- data.frame(
    Intervalos = etiquetas,
    FreqAbs = freq,
    FreqAcum = fac,
    Porcentaje = paste0(perc, "%"),
    PorcAcum = paste0(perc_acum, "%")
  )

  print(tabf)

  # Gráfico
  barplot(freq,
    names.arg = etiquetas,
    las = 2,
    col = "lightblue",
    border = "black",
    main = "Histograma",
    ylab = "Frecuencia"
  )
}

intervalos3(y)
intervalos3(z$X1)

intervalos4 <- function(y, dec = 2, superponer = FALSE) {
  n <- length(y)
  mn <- min(y)
  mx <- max(y)

  # Número de clases
  k <- ceiling(1 + 3.3 * log10(n))

  # Límites
  breaks <- seq(mn, mx, length.out = k + 1)

  # Clases
  clases <- cut(y, breaks = breaks, include.lowest = TRUE, right = FALSE)

  # Frecuencias
  freq <- as.vector(table(clases))
  fac <- cumsum(freq)

  # Porcentajes
  perc <- round(100 * freq / n, dec)
  perc_acum <- round(100 * fac / n, dec)

  # Límites inferior y superior
  li <- head(breaks, -1)
  ls <- tail(breaks, -1)

  # Marca de clase
  mc <- round((li + ls) / 2, dec)

  # Etiquetas
  etiquetas <- paste0(
    "[", round(li, dec), ", ", round(ls, dec),
    ifelse(seq_along(ls) == length(ls), "]", ")")
  )

  # Tabla
  tabf <- data.frame(
    Intervalos = etiquetas,
    MarcaClase = mc,
    FreqAbs = freq,
    FreqAcum = fac,
    Porcentaje = paste0(perc, "%"),
    PorcAcum = paste0(perc_acum, "%")
  )

  print(tabf)

  # =========================
  # GRÁFICOS
  # =========================
  library(ggplot2)

  df <- data.frame(y = y)

  g_hist <- ggplot(df, aes(x = y)) +
    geom_histogram(
      breaks = breaks,
      fill = "lightblue",
      color = "black"
    ) +
    labs(title = "Histograma", y = "Frecuencia")

  g_dens <- ggplot(df, aes(x = y)) +
    geom_density(fill = "lightgreen", alpha = 0.5) +
    labs(title = "Densidad", y = "Densidad")

  if (superponer) {
    # Escalamos densidad a frecuencia
    g_sup <- ggplot(df, aes(x = y)) +
      geom_histogram(aes(y = ..count..),
        breaks = breaks,
        fill = "lightblue",
        color = "black"
      ) +
      geom_density(aes(y = ..density.. * n * (breaks[2] - breaks[1])),
        color = "red", linewidth = 1
      ) +
      labs(
        title = "Histograma + Densidad",
        y = "Frecuencia"
      )

    print(g_sup)
  } else {
    # Dos gráficos lado a lado
    par(mfrow = c(1, 2))
    print(g_hist)
    print(g_dens)
    par(mfrow = c(1, 1))
  }
}

intervalos4(y, superponer = TRUE)
intervalos4(z$X1, superponer = TRUE)

# ---------------------------------------------------------------------
# Tablas expss con guíones
# ---------------------------------------------------------------------

print_tabla <- function(df) {
  # Convertir todo a texto
  df[] <- lapply(df, as.character)

  # Nombres de columnas
  headers <- names(df)

  # Combinar headers + datos
  tabla <- rbind(headers, as.matrix(df))

  # Calcular ancho máximo por columna
  ancho <- apply(tabla, 2, function(col) max(nchar(col)))

  # Función para formatear fila
  fmt_fila <- function(fila) {
    paste0(
      "| ",
      paste(
        mapply(
          function(x, w) format(x, width = w, justify = "left"),
          fila, ancho
        ),
        collapse = " | "
      ),
      " |"
    )
  }

  # Línea separadora
  linea <- paste0(
    "+-",
    paste(sapply(ancho, function(w) paste(rep("-", w), collapse = "")),
      collapse = "-+-"
    ),
    "-+"
  )

  # Imprimir
  cat(linea, "\n")
  cat(fmt_fila(headers), "\n")
  cat(linea, "\n")

  for (i in 1:nrow(df)) {
    cat(fmt_fila(df[i, ]), "\n")
  }

  cat(linea, "\n")
}

print_tabla(tabf)
print_tabla(mtcars %>% head())

library(scales)
x <- c(0.1, 0.555, 1.2)

# Standard formatting
percent(x)
# Output: "10%" "56%" "120%"

# Adjusting accuracy (e.g., 2 decimal places)
percent(x, accuracy = 0.01)
# Output: "10.00%" "55.50%" "120.00%"

rpois(100, 5) %>% unique()

attr(x, "type") <- "intervalo"
x


path <- "C:\\Users\\R1ck7\\Downloads\\BaseDeDatos\\Analizing Sensory Data with R\\dataset book"
dir(path) %>% matrix()

npath <- file.path(path, "lipsticks.csv")
lipsticks <- read.csv(npath)
lipsticks %>% str()
lipsticks %>%
  names() %>%
  matrix()
lipsticks %>% dim()
lipsticks %>% view()
lipsticks %>% fix()
lp <- lipsticks

lp[, 41] %>% str()
lp[, 41] %>% unique()
lp[, 41] %>% cro()
nf <- lp[, 41] %>% factor(, levels = c("not at all", "very little", "slightly", "moderatly", "a lot"))
nf %>% cro()
nf %>% attributes()

lp[, 1] %>% hist()
lp[, 156] %>% hist()
lp[, 64] %>% cro()
lp[, 97] %>% cro()

npath <- file.path(path, "perfumes_liking_small.csv")
perf <- read.csv(npath)
perf %>% str()
perf

npath <- file.path(path, "perfumes_liking.csv")
shell.exec(npath)
perfull <- read.csv(npath, header = TRUE, sep = ",", quote = "\"", fileEncoding = "latin1")
perfull %>% str()
perfull %>% count(consumer)


# Objeto .rda
tmp <- sapply(lp, class)
a <- tmp %>% names()
b <- tmp %>% as.character()
z <- cbind(a, b)
save(lipsticks, file = "Files/lipsticks.rda")




# Opciones de Consola
options("width" = 10000)
getOption("width")

# Procesamiento
mtcars %>% str()
mtcars %>% info()

# nolint end
