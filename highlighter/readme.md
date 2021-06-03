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
([^"\w:](\-)?\d+(?:\.\d)?(((?:[Ee])?(?:[+\-])?(?:\d*)))?)(?=([^"]*"[^"]*")*[^"]*$)
```
### Booleanos
Hay tres valores booleanos posibles: `true`, `null` y `false`.
```regex
\b(?:true|false|null)\b
```
### Llaves
Las llaves son cadenas de texto delimitados entre comillas `"`. Tienen dos puntos `:` al final.
```regex
(<span class='strings'>)(.*?)(<\/span>)([\s]*:)
```
### Cadenas de texto
Las cadenas de texto son secuencias de caracteres, que se encuentran entre comillas `"`.
```regex
(?:"(?:.*?)")
```
### Caracteres
Los caracteres son identificados con comillas simples `'` y un solo caracter alfanumérico o de puntuación.
```regex
[\w\W]
```
### Decoradores
Los decoradores fue la forma en la que nombramos a los elementos claves de la sintaxis de JSON, tales como **llaves** `{}` para delimitar objetos, **corchetes** `[]` para delimitar arreglos, y **comas** `,` para delimitar propiedades.
```regex
((?<![\w])[:])|[,\[\]{}](?=([^"]*\"[^"]*")*[^"]*$)
```

### Tabs
Reemplazamos los tabs con cadenas de cuatro espacios
```regex
[\t]
```

## Reflexión

Reflexión sobre la solución planteada, los algoritmos implementados y sobre el tiempo de ejecución de estos.

- La solución planteada nos pareció muy interesante, ya que pudimos entender lo poderosas y complejas que son las expresiones regulares. 
- Los resaltadores de sintaxis son algo que usamos casi diariamente en esta carrera, ha sido muy enriquecedor entender cómo funcionan y cómo podemos implementar uno. 
- Otra cosa que nos sorprendió fue el darnos cuenta de cómo varios lenguajes de programación y herramientas tecnológicas pueden interactuar entre sí. No habíamos pensado que un lenguaje de la familia Lisp podría utilizarse para generar una página web. Nos gustó mucho esta oportunidad de interactuar con un lenguaje Lisp ya que creemos que nos permitió entender mejor cómo funcionan los lenguajes de programación y nos hizo mejorar nuestras habilidades para resolver problemas. 

    <a href="https://xkcd.com/297/"><img src="lisp_cycles.png" width="400px"> </a>

- Utilizar Racket fue un gran reto para nosotros, tuvimos que cambiar la manera en la que pensamos al programar. Nos pareció muy interesante adoptar este nuevo paradigma de programación funcional, aprendiendo de sus posibilidades y múltiples retos. 

- Nos parece que para identificar tokens es un algoritmo bastante eficiente, pensamos que iba a tomar más tiempo debido a las expresiones regulares. Esto nos hizo apreciar aún más lo poderosas que son. 

- Nos dimos cuenta que, aunque el algoritmo concurrente es más rápido que el secuencial, estos podrían tener tiempos de ejecución similares. Por la manera en la que se distribuyen los archivos por thread, podría suceder que dos archivos muy largos sean procesados por el mismo thread, reduciendo la eficiencia del algoritmo.

- Aprendimos que los threads son muy útiles, pero hay que saberlos usar según la capacidad del CPU. Si la cantidad de threads excede a la cantidad de cores del procesador, el programa se volverá significativamente más lento. 

- Hay que recordar que aunque un algoritmo puede ser muy eficiente, siempre hay que considerar cómo se está utilizando, pues esto también es un factor importante para el funcionamiento óptimo del mismo. En este caso, esto implica el orden de los archivos y la cantidad de threads.

### Complejidad
Calcular la complejidad del algoritmo basada en el número de iteraciones y contrástala con el tiempo obtenido.

- La solución planteada lee cada línea del archivo de manera recursiva: **O(n)**
- Para cada línea, realiza 7 reemplazos usando sustituciones de expresiones regulares: **O(1)**
- Posteriormente la nueva línea es añadida a una nueva lista: **O(1)**
- La lista es devuelta en el caso base de la función recursiva: **O(1)**

Al leerse el archivo solamente una vez, podemos obtener una complejidad de **O(n)** (donde __n__ es la cantidad de líneas en el archivo).

Consideramos que es un algoritmo eficiente; solo se realizan operaciones la cantidad de veces necesarias, reduciendo el malgasto de recursos.

### Tiempo de ejecución
| Cantidad de archivos  | Tiempo secuencial (ms)    | Tiempo  Paralelo (ms) | Speedup   |
|-----------------------|---------------------------|-----------------------|-----------|
| 4                     | 69                        | 65                    | 1.06      |
| 5                     | 553775                    | 501989                | 1.10      |

## Ejemplos de ejecución
Desde la línea de comandos de Racket, correr los siguientes comandos. La función `write-files` recibe como argumento el nombre de la carpeta con los archivos a resaltar.

La función `write-files-parallel` también recibe el nombre de la carpeta con los archivos a resaltar, además de la cantidad de threads en los que se quiera realizar la operación.

```lisp
> (enter! "identify-tokens.rkt")
> (write-files "examples")
> (write-files-parallel "examples" 4)
```

Los archivos resultantes se guardan en una carpeta llamada `results`. Puedes visualizarlos utilizando el navegador web de tu elección.