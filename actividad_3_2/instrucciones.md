# Deterministic Finite Automaton

## Instrucciones
Hacer una función que reciba como argumento un string que contenga expresiones aritméticas y comentarios, y nos regrese una lista con cada uno de sus tokens encontrados, en el orden en que fueron encontrados e indicando de qué tipo son.

## Tipos de tokens
Las expresiones aritméticas sólo podrán contener los siguientes tipos de tokens:
- Enteros
- Flotantes (Reales)
- Operadores:
- Asignación
- Suma
- Resta
- Multiplicación
- División
- Potencia
- Identificadores:
- Variables
- Símbolos especiales:
    - (
    - )
- Comentarios:
    - // seguido de caracteres hasta que se acabe el renglón
 

## Función principal

El programa podrá estar formado con las funciones que requiera, pero la función principal tendrá la siguiente forma:

    void arithmetic-lexer(string expression);

donde expression es un string que representa una operación aritmética

## Entrada
Los tokens no necesariamente deben estar separados por un espacio en blanco, o pueden tener separación de más de un blanco
Por ejemplo:

    b=7
    a = 32.4 *(-8.6 - b)/       6.1E-8
    d = a ^ b // Esto es un comentario

 
## Salida
Debe entregar la siguiente salida:
| Token  | Tipo                  |
|--------|-----------------------|
| b      | Variable              |
| =      | Asignación            |
| 7      | Entero                |
| a      | Variable              |
| =      | Asignación            |
| 32.4   | Real                  |
| *      | Multiplicación        |
| (      | Paréntesis que abre   |
| -8.6   | Real                  |
| -      | Resta                 |
| b      | Variable              |
| )      | Paréntesis que cierra |
| 6.1E-8 | Real                  |
| d      | Variable              |
| =      | Asignación            |
| ^      | Potencia              |
| b      | Variable              |
| //     | Comentario            |

## Reglas de formación de algunos tokens

- Variables: 
    - Deben empezar con una letra (mayúscula o minúscula).
    - Sólo están formadas por letras, números y underscore (‘_’).
- Números reales (de punto flotante):
    - Pueden ser positivos o negativos
    - Pueden o no tener parte decimal pero deben contener un punto (e.g. 10. o 10.0)
    - Pueden usar notación exponencial con la letra E, mayúscula o minúscula, pero después de la letra E sólo puede ir un entero positivo o negativo (e.g. 2.3E3, 6.345e-5, -0.001E-3, .467E9). (OPCIONAL)
- Comentarios:
    - Inician con // y todo lo que sigue hasta que termina el renglón es un comentario (OPCIONAL)
 

## Algoritmo

- El reconocimiento de tokens se debe hacer por medio de la tabla de transición de un Autómata Finito Determinístico.
- El diseño del autómata debe ser parte fundamental de la documentación (utilice alguna herramienta computacional para dibujarlo, no lo haga a mano).
 

## Documentación:

- Manual del usuario, indicando cómo correr su programa y qué se obtiene de salida, en qué lenguaje lo hizo y qué tengo que instalar para que funcione.
- El autómata que resuelve el problema (como un anexo del punto 1).