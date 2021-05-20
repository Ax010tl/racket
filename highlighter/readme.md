# Proyecto: JSON Highlighter

Lourdes Badillo, A01024232 <br>
Valeria Pineda, A01023979 <br>
Eduardo Villalpando, A01023646 <br>

Para este proyecto se seleccionó la sintaxis de JSON (JavaScript Object Notation). Primero se definieron los tokens a identificar.

## Encontrar tipos de datos
Utilizando **expresiones regulares**, se pueden identificar los siguientes tipos de dato correspondientes al estándar de JSON. 

### Números
Los números pueden ser valores `enteros`, `fraccionarios`, con `notación científica` y con `signo`.
```regex
[^"\w:](\-)?\d+(?:\.\d)?(((?:[Ee])?(?:[+\-])?(?:\d*)))?
```
### Booleanos
Hay tres valores booleanos posibles: `true`, `null` y `false`.
```regex
\b(?:true|false|null)\b
```
### Llaves
Las llaves son cadenas de texto delimitados entre comillas `"`. Tienen dos puntos `:` al final.
```regex
(")(.*?")(:)
```
### Cadenas de texto
Las cadenas de texto son secuencias de caracteres, que se encuentran entre comillas `"`.
```regex
(?:"(?:.*?)")
```
### Caracteres
Los caracteres son identificados con comillas simples `'` y un solo caracter alfanumérico o de puntuación.
```regex
'[\w\W]'
```
### Decoradores (?)
Los decoradores fue la forma en la que nombramos a los elementos claves de la sintaxis de JSON, tales como **llaves** `{}` para delimitar objetos, **corchetes** `[]` para delimitar arreglos, y **comas** `,` para delimitar propiedades.
```regex
[,\[\]{}:]
```

## Reflexión

Reflexión sobre la solución planteada, los algoritmos implementados y sobre el tiempo de ejecución de estos.

- La solución planteada nos pareció muy interesante, ya que pudimos entender lo poderosas y complejas que son las expresiones regulares. 
- Los resaltadores de sintaxis son algo que usamos casi diariamente en esta carrera, ha sido muy enriquecedor entender cómo funcionan y cómo podemos implementar uno. 
- Otra cosa que nos sorprendió fue el darnos cuenta de cómo varios lenguajes de programación y herramientas tecnológicas pueden interactuar entre sí. No habíamos pensado que un lenguaje de la familia Lisp podría utilizarse para generar una página web. Nos gustó mucho esta oportunidad de interactuar con un lenguaje Lisp ya que creemos que nos permitió entender mejor cómo funcionan los lenguajes de programación y nos hizo mejorar nuestras habilidades para resolver problemas. 

    <a href="https://xkcd.com/297/"><img src="lisp_cycles.png" width="400px"> </a>

- Utilizar Racket fue un gran reto para nosotros, tuvimos que cambiar la manera en la que pensamos al programar. Nos pareció muy interesante adoptar este nuevo paradigma de programación funcional, aprendiendo de sus posibilidades y múltiples retos. 

- El algoritmo completo tiene un tiempo de ejecución de 6.78 milisegundos. 
    - La función `replace-match` tomó 3.29 milisegundos
    - Por lo que el resto del algoritmo tomó 3.49 milisegundos

- Nos parece que es un algoritmo bastante eficiente, pensamos que iba a tomar más tiempo debido a las expresiones regulares. Esto nos hizo apreciar aun más lo poderosas que son. 

### Complejidad
Calcular la complejidad del algoritmo basada en el número de iteraciones y contrástala con el tiempo obtenido.

- La solución planteada lee cada línea del archivo de manera recursiva: **O(n)**
- Para cada línea, realiza 6 reemplazos usando sustituciones de expresiones regulares: **O(1)**
- Posteriormente la nueva línea es añadida a una nueva lista: **O(1)**
- La lista es devuelta en el caso base de la función recursiva: **O(1)**

Al leerse el archivo solamente una vez, podemos obtener una complejidad de **O(n)** (donde __n__ es la cantidad de líneas en el archivo).

El tiempo de ejecución fue 6.78 milisegundos. Teniendo una complejidad **O(n)**, consideramos que es un algoritmo eficiente; solo se realizan operaciones la cantidad de veces necesarias, reduciendo el malgasto de recursos.