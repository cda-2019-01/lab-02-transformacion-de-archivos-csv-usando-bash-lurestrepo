
#agregar columna adicional con el nombre de la estacion a cada archivo
sed 's/\([0-9],[0-9]\)/\1;Estacion1/g' estaciones/estacion1.csv> out.1 
sed 's/\([0-9],[0-9]\)/\1;Estacion2/g' estaciones/estacion2.csv> out.2 
sed 's/\([0-9],[0-9]\)/\1;Estacion3/g' estaciones/estacion3.csv> out.3 
sed 's/\([0-9],[0-9]\)/\1;Estacion4/g' estaciones/estacion4.csv> out.4 

#agregar en el encabezado de Estacion1 el nombre de la columna Estacion
sed 's/\([a-zA-Z]*\);\([a-zA-Z]*\);\([a-zA-Z]*\);\([a-zA-Z]*\)/\1; \2; \3; \4; Estacion/' out.1 > out.11
rm out.1
#eliminar los encabezados de los archivos archivos 2, 3 y 4 
sed "1 d" out.2 >out.22
sed "1 d" out.3 >out.33
sed "1 d" out.4 >out.44
 rm out.2 out.3 out.4
#integrar los archivos 2-3-4  en archivo 1
cat out.*  > out.5

rm out.11 out.22 out.33 out.44 #eliminar outs que no se usaran

######     comenzar con la limpieza y de variables    ######
#modificar decimales  , por .
sed 's/\([0-9]\),\([0-9]\)/\1.\2/g' out.5 > out.6 #remplaza la ,  los decimales de la ultima columna.
#modificar separadores  ; por ,
sed 's/;/,/g' out.6 >out.7 #Reemplace los ; por , 
##modificar fecha
    #Formato dia mes año
#modificar dia para agregar un 0 al inicio
sed 's/^\([0-9]\)\// 0\1\//g' out.7 > out.8 #agrega 0 al inicio de la cadena para los dias de 1 solo digito
#modificar año para agregar 
sed 's/\/\([0-9][0-9]\),/\/20\1,/g' out.8 > out.9 #agrega el 20 al año
sed 's/ //g'  out.9 > out.10 #eliminar espacios
sed 's/\//-/g' out.10 > out.11
sed 's/\([0-9][0-9]\)-\([0-9][0-9]\)-\([0-9]*\),/\3-\2-\1,/' out.11>out12.csv #dar formato a fecha YYYY-MM-DD
#limpiar hora
sed 's/,\([0-9]\):/,0\1:/g' out12.csv>base.csv

rm out.* out12.csv #eliminar archivos no usados
##calculos para los archivos finales###
#velocidad-por-mes.csv
csvsql --query 'select  Estacion, strftime ("%m",FECHA)as Mes, avg(VEL) as Velocidad from base  group by Estacion, Mes'  base.csv>velocidad-por-mes.csv #velocidad promedio por mes y por estacion
#velocidad-por-ano.csv
csvsql --query 'select  Estacion, strftime ("%Y",FECHA)as Ano, avg(VEL) as Velocidad from base  group by Estacion, Ano'  base.csv>velocidad-por-ano.csv #velocidad promedio por año y por estacion
#velocidad-por-hora.csv
csvsql --query 'select  Estacion, strftime ("%H",HHMMSS)as Hora, avg(VEL) as Velocidad from base  group by  Estacion, Hora'  base.csv>velocidad-por-hora.csv #velocidad promedio por hora y por estacion
rm base.csv