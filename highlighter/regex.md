Para este proyecto se seleccionó la sintaxis de JSON

# Encontrar tipos de datos
## Números
```regex
(?:-)?\d+(?:.\d*)?(?:[Ee])?(?:[+-])?(?:\d*)?
```
## Booleanos
```regex
\b(?:true|false|null)\b
```
## Llaves
```regex
((?:"(?:.*?)")):
```
## Cadenas de texto
```regex
(?:"(?:.*?)")
```
## Caracteres
```regex
CHAR ('')
'[\w\W]'

STUFF
[,\[\]{}]