# 160426

Hoy haremos una libería para R:

## Notas

- Para factores usar forcats (fct_).
- Para trabajar con expss (solo 2 valores: númerico o caracter) usar recode.
- dbl+lbl es una clase especial creada por haven y tiene atributos @ y sub-atributos attr.

## Objetivo

Reemplazar expss ya que no puede graficar fácilmente con ggplot.

- Crear una clase s7 que use factores con atributos.
- Usar los factores para crear tablas automáticas según el tipo de datos (categórico, ordinal, intervalo, razon).
- Funcione usando %>% o |>.
- Los factores deben funcionar con analisis de regresion por ejemplo.
- Se debe comprobar que el numero de niveles del factor sea poco.

## Pasos

- Aprender todo sobre factores [Ok].
- Agregar atributos a los factores [Ok].
- Entender todo sobre atributos y sub-atributos por ejemplo en casos como dbl+lbl (de stata con haven) [Ok].
- Crear un factor con niveles ordenados a partir de un vector numérico con atributos [Ok].
- Crear una clase especial similar a dbl+lbl (Haven_labelled), incluirla en un dataframe o tibble y gráficar usando ggplot [Ok].
- Aprender lo básico para crear clases S3 [Ok].
- Crear una clase S3 para manejar (métodos que permitan utilizar las caracteristicas que tendrán esos nuevos factores) factores con atributos [Ok].
- __Graficar con nuevos factores usando ggplot__ (Objetivo principal, sino funciona cambiar de idea)[Ok].
- Crear tablas para consola R con nueos factores.
- Tablas con descripción, % y opciones para mostrar o no (__Manejo de funciones R__).
- Exportar a Excel.
- Exportar a Spss (debe ser automático).
- Exportar a Que.



## Desarrollo

### Factores

