# 3P - 160426

Proyecto R pkg para reemplazar expss porque requiere convertir a factor en ggplot.

## Notas Generales

- Para factores usar forcats (fct_).
- Para trabajar con expss (solo 2 valores: númerico o caracter) usar recode.
- dbl+lbl es una clase especial creada por haven y tiene atributos @ y sub-atributos attr.

## Links

- [Link principal ChatGPT: Factores y S3](https://chatgpt.com/c/69e0d82a-9d10-83e9-913f-42ded1fc3138)

- [dplyr para filas y columnas básico](https://chatgpt.com/c/69e25833-c968-83e9-9e14-479ded577d77)

- [Como organizar scripts de R](https://chatgpt.com/c/69e24650-4b10-83e9-a235-019ae7e880cb)

## Objetivo Especificos

Reemplazar expss ya que no puede graficar fácilmente con ggplot.

- Crear una clase S3 que use factores con atributos, (Según chatGPT s· es mas sencillo y popular que S7).
- Usar los factores para crear tablas automáticas según el tipo de datos (categórico, ordinal, intervalo, razon).
- Se debe comprobar que el numero de niveles del factor sea poco al convertirlo en un objeto `mi_labelled`.
- Funcione usando %>% o |>. [Ok]
- Los factores deben funcionar con analisis de regresion por ejemplo [Ok].

## Pasos

- Aprender todo sobre factores [Ok].
- Agregar atributos a los factores `attributes()` [Ok].
- Entender todo sobre atributos y sub-atributos por ejemplo en casos como dbl+lbl (de stata con haven) [Ok].
- Crear un factor con niveles ordenados a partir de un vector numérico con atributos [Ok].
- Crear una clase especial similar a dbl+lbl (Haven_labelled), incluirla en un dataframe o tibble y gráficar usando ggplot [Ok].
- Aprender lo básico para crear clases S3 [Ok].
- Crear una clase S3 para manejar factores con atributos, crear métodos que permitan utilizar las caracteristicas que tendrán esos nuevos factores [Ok].
- __Graficar con nuevos factores usando ggplot__ (Objetivo principal, sino funciona cambiar de idea) [Ok].
- Crear tablas para consola R con nuevos factores.
- Tablas con descripción, que muestre % y opciones para mostrar o no (__Manejo de funciones R__).
- Exportar a Excel.
- Exportar a Spss (debe ser automático).
- Exportar a Que.

## Tareas 

### 18/04/26

- Funciones dplyr/ggplot.
- Manejar Datos Perdidos (NA,98,99).

### 17/04/26

- Manejar Factores (forcats, if, case_when).
- Dplyr básico.

### 16/04/26

- Cumplimiento de los "Pasos" marcados al inicio.


