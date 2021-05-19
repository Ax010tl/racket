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
(?:-)?\d+(?:.\d*)?(?:[Ee])?(?:[+-])?(?:\d*)?
```
### Booleanos
Hay tres valores booleanos posibles: `true`, `null` y `false`.
```regex
\b(?:true|false|null)\b
```
### Llaves
Las llaves son cadenas de texto delimitados entre comillas `"`. Tienen dos puntos `:` al final.
```regex
(?:"(?:.*?)")(:)
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