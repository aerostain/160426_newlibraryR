# 3P - 160426

Proyecto R pkg para reemplazar expss porque requiere convertir a factor en ggplot.

## Notas Generales

- Para factores usar forcats (fct_).
- Para trabajar con expss (solo 2 valores: númerico o caracter) usar recode.
- dbl+lbl es una clase especial creada por haven y tiene atributos @ y sub-atributos attr.

## Pendientes

- reframe - dplyr.

## Links

- [Link principal - ChatGPT: Factores, attributes y S3](https://chatgpt.com/c/69e0d82a-9d10-83e9-913f-42ded1fc3138)

- [Link principal - ChatGPT: Análisis de Penalidades JAR](https://chatgpt.com/c/69e838fc-4064-83e9-95a5-3228aca77a93)

- [Link principal - ChatGPT: Regresion con R variables ordinales y JAR](https://chatgpt.com/c/69e85dd9-7c48-83e9-9b87-2270d5111931)

- [ChatGPT: dplyr para filas y columnas básico](https://chatgpt.com/c/69e25833-c968-83e9-9e14-479ded577d77)

- [ChatGPT: Como organizar scripts de R](https://chatgpt.com/c/69e24650-4b10-83e9-a235-019ae7e880cb)

- [ChatGPT: Funciones dplyr, ggplot y expss básicas sin S3 (usa {{ }}) o eval(substitute(...))](https://chatgpt.com/c/69e36a3d-0194-83e9-bb1e-34990481e2ce)

- [ChatGPT: NA, 98, 99 y Regex, grep, gsub, str_, exportar/importar .sav con NA](https://chatgpt.com/c/69e4552e-671c-83e9-b0cd-9dcbe228f7d1)

- [Videos sobre JAR y otros](https://www.youtube.com/@aurorapintor2236)

- [Diccionario de terminos en Evaluación Sensorial](https://www.sensorysociety.org/knowledge/sspwiki/Pages/Title-List.aspx)

- [XLSTAT lista de análisis](https://www.xlstat.com/solutions/features/penalty-analysis)

- [XLSTAT análisis de penalidades](https://community.lumivero.com/s/article/6651-penalty-analysis-excel-tutorial?language=en_US)

- [PCA separa la data en 2 para probar el modelo, correlación entre Rank y Points de de -60%](https://rpubs.com/JGC/840482)

## Links Secundarios

- [ChatGPT: Solución a errores al crear Rpkg de datos (tíldes y check()) y atributos na_values y format.spss](https://chatgpt.com/c/69e47433-5c90-83e9-9478-2b8fbaebe180)

- [Atributos para exportar .sav](https://chatgpt.com/c/69e48c8c-ec04-83e9-b912-1369d6d5aa20)

- [Función histograma, tabla similar a expss con guiones](https://chatgpt.com/c/69e5420d-8a04-83e9-a35d-05f2a1293fa1)

[- Conversion data producto de expss usando dplyr - pivot longer](https://chatgpt.com/c/69e4f476-0d30-83e9-887a-4c89e4a0983c)

## Objetivo Especificos

Reemplazar expss ya que no puede graficar fácilmente con ggplot.

- Crear una clase S3 que use factores con atributos, (Según chatGPT S3 es mas sencillo y popular que S7).
- Usar los factores para crear tablas automáticas según el tipo de datos (categórico, ordinal, intervalo, razón).
- Se debe comprobar que el numero de niveles del factor sea poco al convertirlo en un objeto `mi_labelled`.
- Funcione usando %>% o |>. [Ok]
- Los factores deben funcionar con análisis de regresion por ejemplo [Ok].

## Pasos

- Aprender todo sobre factores [Ok].
- Agregar atributos a los factores `attributes()` [Ok].
- Entender todo sobre atributos y sub-atributos por ejemplo en casos como dbl+lbl (de stata con haven) [Ok].
- Crear un factor con niveles ordenados a partir de un vector numérico con atributos [Ok].
- Crear una clase especial similar a dbl+lbl (haven_labelled), incluirla en un dataframe o tibble y gráficar usando ggplot [Ok].
- Aprender lo básico para crear clases S3 [Ok].
- Crear una clase S3 para manejar factores con atributos, crear métodos que permitan utilizar las caracteristicas que tendrán esos nuevos factores [Ok].
- __Graficar con nuevos factores usando ggplot__ (Objetivo principal, sino funciona cambiar de idea) [Ok].
- Crear tablas para consola R con nuevos factores.
- Tablas con descripción, que muestre % y opciones para mostrar o no (__Manejo de funciones R__).
- Exportar a Excel.
- Exportar a Spss (debe ser automático).
- Exportar a Que.

## Tareas / Avances

### 20/04/26

- Funciones expss.
- respuesta multiple expss.
- pivot_wider, pivot_longer.
- join.
- Rpkg data.
- Rpkg funciones.
- Rpkg data + funciones + S3.
- Formato para exportar dataframe a .sav (labelled_spss).
- Función para organizar la data después de importar de spss.
- Función para organizar la data antes de exportar de spss.

### 19/04/26

- Función histograma experto.
- Crear tabla para consola similar a expss.
- Formatos para mostrar valores (%).

### 18/04/26

- Funciones dplyr/ggplot.
- Funciones expss eval(substitute(...)).
- Funciones dinámicas usando eval(parse(text=txt)).
- Manejar Datos Perdidos (NA,98,99).
- Regex, grep, gsub, str_.
- Rpkg data.
- Rpkg función ggplot.
- Exportar e importar .sav con NA (labelled_spss)

### 17/04/26

- Manejar Factores (forcats, if, case_when).
- Dplyr básico.

### 16/04/26

- Repaso de factores.
- Attributes.
- Transformar un numeric con atributos a un factor con levelss.
- Clase similar a haven_labelled para manejar factores usando S3 
- S3 básico/intermedio.
- Crear una clase similar a haven_labelled para que grafique automáticamente en ggplot.


