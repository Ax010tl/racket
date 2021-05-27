# Actividad 5.2 Programación paralela y concurrente

Lourdes Badillo, A01024232 <br>
Valeria Pineda, A01023979 <br>
Eduardo Villalpando, A01023646 <br>

## Descripción 

Utilizando Racket escribimos dos versiones de un programa que calcula la suma de todos los números primos menores a 5,000,000
- La primera versión lo hace de manera secuencial 
- La segunda versión lo hace de manera paralela

## Tiempos de Ejecución 
Medimos el tiempo en que tarda en ejecutar cada versión del programa y calculamos el *speedup* obtenido. 

| Rango     | Tiempo  Secuencial (ms) | Tiempo  Paralelo (ms) | Speedup |
|-----------|-------------------------|-----------------------|---------|
| 1-5000    | 52.47                   | 5.16                  | 10.17   |
| 1-42000   | 1016.77                 | 623.28                | 1.63    |
| 1-5000000 | ∞                       | 21804.10              |         |