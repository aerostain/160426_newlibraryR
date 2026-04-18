# nolint start

# ---------------------------------------------------------------------
# Factores
# ---------------------------------------------------------------------

fs <- rep(1:5, times = c(3, 2, 4, 2, 2))

fs %<>% as.factor
levels(fs) <- LETTERS[1:5]

fs %>% str()
fs

# Desde Vector
fct_collapse(fs, "A" = "B")

# Desde Data.frame
m <- data.frame(fs)
m %>% mutate(fs = fct_collapse(fs, "A" = "B", "B" = c("C", "D", "E")))

setdiff(levels(fs), c("A", "B"))

gl(3, 5, labels = LETTERS[1:3])

replicate(3, fs)

choose(5, 2)

grep("A", month.abb)
grep("A", month.abb, ignore.case = TRUE)

str_detect("Holaaa", "a")

iris %>% names()

# ---------------------------------------------------------------------
# dplyr
# ---------------------------------------------------------------------

iris %<>% tibble

# select + contains
iris %>% select(contains("Petal"))

iris %>% select(contains("Petal") | contains("th"))

iris %>% select(starts_with("s"))

iris %>% select(ends_with("s"))

iris %>% select(matches("w."))

# across solo se usa en mutate o summarise
# aplicar operaciones en múltiples columnas
# contains se puede usar dentro de across

# reemplaza por la media las columnas seleccionadas
iris %>% mutate(across(contains("Pet"), mean))

iris %>% mutate(across(contains("al"), length))

iris %>% summarise(across(contains("Pet"), list(xp = mean, ss = sum)))

iris %>% summarise(across(contains("Pet"), mean, .names = "mean_{.col}"))

# where siempre dentro de select o across
mpg %>% select(where(is.character))
mpg %>% mutate(across(where(is.character), as.factor))

mpg %>% summarise(across(where(is.numeric), mean))

mpg %>% summarise(across(where(is.character), \(x){
  sum(is.na(x))
}))

mpg %>% summarise(across(where(is.character), ~ sum(is.na(.x))))


# ---------------------------------------------------------------------
# DataExplorer Library
# ---------------------------------------------------------------------

install.packages("nycflights13")
install.packages("DataExplorer")
library(nycflights13)
library(DataExplorer)

weather %>% plot_str(type="r")
weather %>% introduce() %>% t
weather %>% plot_intro()
weather %>% plot_missing()
weather %>% plot_bar()
weather %>% create_report()
dir() %>% matrix
shell.exec(getwd())






# nolint end
