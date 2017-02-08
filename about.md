---
title: "Acerca de"
output: html_document
---

## ETo

Evapotranspiración de referencia horaria, calculada a partir de la fórmula de Penman-Monteith, a través de la ecuación ASCE (Allen et al., 2006):

![Ecuación de PM](PM.png)

Dónde:
= pendiente de la curva de presión de vapor de saturación versus la temperatura (kPa ºC-1)
Rn = radiación neta que llega sobre el cultivo
G = Flujo de calor del suelo
= constante psicrométrica (kPa ºC-1)
Cn = constante que cambia con el cultivo de referencia y el tiempo de medición, horario o diario
T = temperatura del aire media del periodo horario, medida a 1,5 o 2 m de altura (ºC)
u2 = velocidad del viento media horaria medida a 2 m de altura (m s-1)
es = presión de vapor de saturación (medida a 1,5 o 2 m de altura) media a la temperatura media del aire
ea = presión de vapor actual (medida a 1,5 o 2 m de altura)
Cd = constante que cambia con el cultivo de referencia y el tiempo de medición, horario o diario

## ETo acumulada

Sumatoria de la ETo calculada de manera horaria durante un día completo. Cada día corresponde a una columna (color azul).

## ETc actual

Evapotranspiración del cultivo, calculada como (CITA):

## ETc acumulada

Sumatoria de la ETc calculada de manera horaria durante un día completo. Cada día corresponde a una columna (color verde).

## Coeficientes de cultivo: Kc

A continuación se detalla la tabla de los kc que pueden ser utilizados para el cálculo de ETc y las fuentes de los mismos

## Datos de Estación Meteorológica Automática

Ubicación: INTA, EEA Mendoza
Latitud: 33º 00' 19" S
Longitud: 68º 51' 50,28" O
Altitud: 925 msnm
Determinaciones: temperatura ambiente (ºC), humedad relativa (%), humectación , precipitación (mm), radiación (W m-2), viento (m s-1). Variables registradas automáticamente cada 15 min a 2 m de altura.

## Cálculo de lámina de riego aplicada (La)

Las láminas de riego diarias aplicadas (mm) se representan como barras diarias de color celeste.
RIEGO POR GOTEO:
La = Qg x Hr x Ng/1000/10
Qg = caudal de cada gotero (l s-1)
Hr = horas de riego (h)
Ng = número de goteros (got ha-1)
1000 m3 l-1
10 mm m-3 ha

## Precipitación acumulada

Sumatoria de la precipitación recibida cada hora durante un día completo (mm). Barras de color celeste.

## Precipitación efectiva

Calculada como la precipitación diaria acumulada (mm) menos el 40% (CITA).


