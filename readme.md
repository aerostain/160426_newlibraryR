# 160426

Hoy haremos una libería para R:

## Notas

- Para factores usar forcats (fct_).
- Para trabajar con expss (solo 2 valores: númerico o caracter) usar recode.

## Objetivo

Reemplazar expss ya que no puede graficar fácilmente con ggplot.

- Crear una clase s7 que use factores con atributos.
- Usar los factores para crear tablas automáticas según el tipo de datos (categórico, ordinal, intervalo, razon).
- Funcione usando %>% o |>.
- Los factores deben funcionar con analisis de regresion por ejemplo.
- Se debe comprobar que el numero de niveles del factor sea poco.

## Pasos

- Aprender todo sobre factores.
- Agregar atributos a los factores.
- Crear una clase s7 para manejar (métodos que permitan utilizar las caracteristicas que tendrán esos nuevos factores) factores con atributos.
- __Graficar con nuevos factores usando ggplot__ (Objetivo principal, sino funciona cambiar de idea).
- Crear tablas para consola R con nueos factores.
- Tablas con descripción, % y opcionespara mostrar o no (__Manejo de funciones R__).
- Exportar a Excel.
- Exportar a Spss (debe ser automático).
- Exportar a Que.

## Desarrollo

### Factores

