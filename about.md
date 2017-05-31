---
title: "Acerca de"
output: html_document
---


### Evapotranspiración de referencia

Evapotranspiración de referencia horaria, calculada a partir de la fórmula de Penman-Monteith, a través de la ecuación ASCE (Allen et al., 2006):

![Ecuación de PM](PM.png)

Dónde:

$\delta$ = pendiente de la curva de presión de vapor de saturación versus la temperatura (kPa º$C^{-1}$)  
Rn = radiación neta que llega sobre el cultivo  
G = Flujo de calor del suelo  
$\gamma$ = constante psicrométrica (kPa ºC-1)  
Cn = constante que cambia con el cultivo de referencia y el tiempo de medición, horario o diario  
T = temperatura del aire media del periodo horario, medida a 1,5 o 2 m de altura (ºC)  
u2 = velocidad del viento media horaria medida a 2 m de altura (m s-1)  
es = presión de vapor de saturación (medida a 1,5 o 2 m de altura) media a la temperatura media del aire  
ea = presión de vapor actual (medida a 1,5 o 2 m de altura)  
Cd = constante que cambia con el cultivo de referencia y el tiempo de medición, horario o diario  

Los datos meteorológicos son procesados mediante el paquete de R *water* (Olmedo et al, 2016).

### Evapotranspiración de referencia acumulada

Sumatoria de la ETo calculada de manera horaria durante un día completo. Cada día corresponde a una columna (color azul).

### Evapotranspiración de cultivo actual

Evapotranspiración del cultivo, calculada como (Allen, 1998):

![Ecuación de PM](ETc.png)

### Evapotranspiración de cultivo acumulada

Sumatoria de la ETc calculada de manera horaria durante un día completo. Cada día corresponde a una columna (color verde).

### Datos de Estación Meteorológica Automática

Ubicación: INTA, EEA Mendoza  
Latitud: 33º 00' 19" S  
Longitud: 68º 51' 50,28" O  
Altitud: 925 msnm  
Determinaciones: temperatura ambiente (ºC), humedad relativa (%), humectación , precipitación (mm), radiación (W m-2), viento (m s-1). Variables registradas automáticamente cada 15 min a 2 m de altura.

### Cálculo de lámina de riego aplicada (La)

Las láminas de riego diarias aplicadas (mm) se representan como barras diarias de color celeste.  

RIEGO POR GOTEO:  

![Ecuación de PM](got.png)

Qg = caudal de cada gotero (l s-1)  
Hr = horas de riego (h)  
Ng = número de goteros (got ha-1)  
1000 m3 l-1  
10 mm m-3 ha  

### Precipitación acumulada

Sumatoria de la precipitación recibida cada hora durante un día completo (mm). Barras de color celeste.

### Precipitación efectiva

Calculada como el 80% precipitación diaria acumulada (mm) menos 12mm (Anderson).


### Software 

La información meteorológico y de riego es almacenada en una base de datos [mariadb](https://mariadb.org). Los datos son procesados en [R](cran.r-project.org) utilizando el paquete [water](https://cran.r-project.org/package=water). Esta página web dinámica utilizada [shiny](http://shiny.rstudio.com/).

### Referencias

Allen, R. G.; Pereira, L. S.; Raes, D.; Smith, M. Evapotranspiración del cultivo: Guías para la determinación de los requerimientos de agua de los cultivos; Food & Agriculture Org, 1998; Vol. 56  
Olmedo, G. F.; Ortega-Farias, S.; Fonseca-Luengo, D.; de la Fuente-Saiz, D.; Peñailillo-Fuentes, F. water: Actual Evapotranspiration with Energy Balance Models 2016.  
Oriolani, M. Requerimientos hídricos de la vid. Resultados experimentales.; 1988.  
Vallone, R. C. Influencia del estado hídrico sobre desarrollo, rendimento y calidad enológica en vid, Universidad Nacional de Cuyo, 1998.  



