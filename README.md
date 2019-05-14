# LAB: Transformación de archivos CSV usando Bash

Los archivos en formato CSV de la carpeta `estaciones/` contienen la información de cuatro (4) estaciones automáticas de medición de viento. Se desear realizar un proceso de transformación de los datos con el fin de producir la información requerida para construir un atlas eólico de la región. 

En todos los archivos generados, los campos deben estar separados por `,`, y los decimales deben indicarse con punto `.` en vez de coma. 

Escriba un solo script (el archivo `script.sh`) que genere los siguientes archivos a partir de todos los archivos que se encuentren en la carpeta `estaciones/`.

**`velocidad-por-mes.csv`**:

    * Nombre de la estación.
    * Mes.
    * Velocidad. Esto es, la velocidad promedio por mes para la respectiva estación.

**`velocidad-por-ano.csv`**:

* Nombre de la estación.
* Año.
* Velocidad. Esto es, la velocidad promedio por año para la respectiva estación.

**`velocidad-por-hora.csv`**:

* Nombre de la estación.
* Mes.
* Velocidad. Esto es, la velocidad promedio por hora para la respectiva estación.