# OCSVIS-LA

## Indicadores Comparativos de Cohesión Social para América Latina

Esta herramienta de visualización permite realizar análisis
comparativos de distintos indicadores asociados a cohesión
social en América Latina, como confianza interpersonal,
valoración de la democracia, participación en protestas,
entre otros. Para ello se utiliza la base de la encuesta
**LAPOP** (Latin American Public Opinion Project), olas
2004, 2006, 2008, 2010, 2012, 2014 y 2018.

## Repositorio

El código de procesamiento de datos y generación de la
herramienta de visualización se encuentra abierto en el
repositorio
[https://github.com/ocscoes/OCSVIS-LA](https://github.com/ocscoes/OCS-COES).
El repositorio esta ordenado en modo general en 3 carpetas,

-   Aplicación Shiny que permite la visualización de los
    datos (app),
-   Datos utilizados (input). Cabe destacar, que siguiendo
    las políticas de resguardo de la información de LAPOP no
    se subirá la base de datos original sino solamente los
    códigos de procesamiento.
-   Códigos de procesamiento de los datos (production).

La estructura del repositorio sigue la propuesta del
protocolo
<a href="https://lisa-coes.github.io/ipo/" target="_blank">IPO</a>

## Datos

La herramienta de visualización utiliza los datos abiertos
disponibles de la encuesta Barómetro de las Américas, del
LAPOP (Latin American Public Opinion Project), disponible en
<https://www.vanderbilt.edu/lapop/>. En general esta
encuesta es conocida como "Encuesta LAPOP", y se define como
"the only survey of democratic public opinion and behavior
that covers the Americas (North, Central, South and the
Caribbean). It is an effort by LAPOP to measure democratic
values and behaviors in the Americas using national
probability samples of voting-age adults". Esta encuesta es
bianual, comenzando el año 2004 con 11 países y en su ola
2018 abarca 29 países.

Además de la encuesta LAPOP se incorporan algunos
indicadores económicos de países para el análisis obtenidos
desde el Banco Mundial (World Bank, 2020) y la base de datos
SWIID (Solt, 2020).

El número de casos según país y ola se presenta en la
siguiente tabla.

<table>
<caption>Número de encuestados por ola y país</caption>
<thead>
<tr class="header">
<th style="text-align: left;"><p></p></th>
<th style="text-align: right;"><p>2004</p></th>
<th style="text-align: right;"><p>2006</p></th>
<th style="text-align: right;"><p>2008</p></th>
<th style="text-align: right;"><p>2010</p></th>
<th style="text-align: right;"><p>2012</p></th>
<th style="text-align: right;"><p>2014</p></th>
<th style="text-align: right;"><p>2016</p></th>
<th style="text-align: right;"><p>2018</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>Mexico</p></td>
<td style="text-align: right;"><p>1556</p></td>
<td style="text-align: right;"><p>1560</p></td>
<td style="text-align: right;"><p>1560</p></td>
<td style="text-align: right;"><p>1562</p></td>
<td style="text-align: right;"><p>1560</p></td>
<td style="text-align: right;"><p>1578</p></td>
<td style="text-align: right;"><p>1563</p></td>
<td style="text-align: right;"><p>1580</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Guatemala</p></td>
<td style="text-align: right;"><p>1708</p></td>
<td style="text-align: right;"><p>1498</p></td>
<td style="text-align: right;"><p>1538</p></td>
<td style="text-align: right;"><p>1504</p></td>
<td style="text-align: right;"><p>1509</p></td>
<td style="text-align: right;"><p>1506</p></td>
<td style="text-align: right;"><p>1546</p></td>
<td style="text-align: right;"><p>1596</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>El Salvador</p></td>
<td style="text-align: right;"><p>1589</p></td>
<td style="text-align: right;"><p>1729</p></td>
<td style="text-align: right;"><p>1549</p></td>
<td style="text-align: right;"><p>1550</p></td>
<td style="text-align: right;"><p>1497</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1551</p></td>
<td style="text-align: right;"><p>1511</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Honduras</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1585</p></td>
<td style="text-align: right;"><p>1522</p></td>
<td style="text-align: right;"><p>1596</p></td>
<td style="text-align: right;"><p>1728</p></td>
<td style="text-align: right;"><p>1561</p></td>
<td style="text-align: right;"><p>1560</p></td>
<td style="text-align: right;"><p>1560</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Nicaragua</p></td>
<td style="text-align: right;"><p>1430</p></td>
<td style="text-align: right;"><p>1762</p></td>
<td style="text-align: right;"><p>1540</p></td>
<td style="text-align: right;"><p>1540</p></td>
<td style="text-align: right;"><p>1686</p></td>
<td style="text-align: right;"><p>1547</p></td>
<td style="text-align: right;"><p>1560</p></td>
<td style="text-align: right;"><p>1547</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Costa Rica</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1498</p></td>
<td style="text-align: right;"><p>1541</p></td>
<td style="text-align: right;"><p>1514</p></td>
<td style="text-align: right;"><p>1501</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Panama</p></td>
<td style="text-align: right;"><p>1639</p></td>
<td style="text-align: right;"><p>1536</p></td>
<td style="text-align: right;"><p>1536</p></td>
<td style="text-align: right;"><p>1536</p></td>
<td style="text-align: right;"><p>1620</p></td>
<td style="text-align: right;"><p>1508</p></td>
<td style="text-align: right;"><p>1521</p></td>
<td style="text-align: right;"><p>1559</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Colombia</p></td>
<td style="text-align: right;"><p>1479</p></td>
<td style="text-align: right;"><p>1491</p></td>
<td style="text-align: right;"><p>1503</p></td>
<td style="text-align: right;"><p>1506</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1563</p></td>
<td style="text-align: right;"><p>1663</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Ecuador</p></td>
<td style="text-align: right;"><p>3000</p></td>
<td style="text-align: right;"><p>2925</p></td>
<td style="text-align: right;"><p>3000</p></td>
<td style="text-align: right;"><p>3000</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1545</p></td>
<td style="text-align: right;"><p>1533</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Bolivia</p></td>
<td style="text-align: right;"><p>3073</p></td>
<td style="text-align: right;"><p>3008</p></td>
<td style="text-align: right;"><p>3003</p></td>
<td style="text-align: right;"><p>3018</p></td>
<td style="text-align: right;"><p>3029</p></td>
<td style="text-align: right;"><p>3068</p></td>
<td style="text-align: right;"><p>1691</p></td>
<td style="text-align: right;"><p>1682</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Peru</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>2647</p></td>
<td style="text-align: right;"><p>1521</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Paraguay</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1165</p></td>
<td style="text-align: right;"><p>1166</p></td>
<td style="text-align: right;"><p>1502</p></td>
<td style="text-align: right;"><p>1510</p></td>
<td style="text-align: right;"><p>1515</p></td>
<td style="text-align: right;"><p>1528</p></td>
<td style="text-align: right;"><p>1515</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Chile</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1517</p></td>
<td style="text-align: right;"><p>1527</p></td>
<td style="text-align: right;"><p>1965</p></td>
<td style="text-align: right;"><p>1571</p></td>
<td style="text-align: right;"><p>1571</p></td>
<td style="text-align: right;"><p>1625</p></td>
<td style="text-align: right;"><p>1638</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Uruguay</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1200</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1514</p></td>
<td style="text-align: right;"><p>1581</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Brasil</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1214</p></td>
<td style="text-align: right;"><p>1497</p></td>
<td style="text-align: right;"><p>2482</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1532</p></td>
<td style="text-align: right;"><p>1498</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Venezuela</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1510</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1558</p></td>
<td style="text-align: right;"><p>0</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Argentina</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1486</p></td>
<td style="text-align: right;"><p>1410</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1528</p></td>
<td style="text-align: right;"><p>1528</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Republica
Dominicana</p></td>
<td style="text-align: right;"><p>4460</p></td>
<td style="text-align: right;"><p>1516</p></td>
<td style="text-align: right;"><p>1507</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1520</p></td>
<td style="text-align: right;"><p>1518</p></td>
<td style="text-align: right;"><p>1516</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Haiti</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1625</p></td>
<td style="text-align: right;"><p>1536</p></td>
<td style="text-align: right;"><p>1752</p></td>
<td style="text-align: right;"><p>1836</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>2221</p></td>
<td style="text-align: right;"><p>0</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Jamaica</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1595</p></td>
<td style="text-align: right;"><p>1499</p></td>
<td style="text-align: right;"><p>1504</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1506</p></td>
<td style="text-align: right;"><p>1515</p></td>
<td style="text-align: right;"><p>1513</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Guyana</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1555</p></td>
<td style="text-align: right;"><p>2514</p></td>
<td style="text-align: right;"><p>1540</p></td>
<td style="text-align: right;"><p>1529</p></td>
<td style="text-align: right;"><p>1558</p></td>
<td style="text-align: right;"><p>1576</p></td>
<td style="text-align: right;"><p>0</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Trinidad y Tobago</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1503</p></td>
<td style="text-align: right;"><p>1506</p></td>
<td style="text-align: right;"><p>4207</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Belice</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>1552</p></td>
<td style="text-align: right;"><p>1504</p></td>
<td style="text-align: right;"><p>1512</p></td>
<td style="text-align: right;"><p>1534</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>0</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>Estados Unidos</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>609</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1500</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Canada</p></td>
<td style="text-align: right;"><p>0</p></td>
<td style="text-align: right;"><p>601</p></td>
<td style="text-align: right;"><p>2032</p></td>
<td style="text-align: right;"><p>1500</p></td>
<td style="text-align: right;"><p>1501</p></td>
<td style="text-align: right;"><p>1517</p></td>
<td style="text-align: right;"><p>1511</p></td>
<td style="text-align: right;"><p>1508</p></td>
</tr>
</tbody>
</table>

: Número de encuestados por ola y país

## Variables

La selección de variables de la encuesta LAPOP se realizó a
partir de una perspectiva de cohesión social que considera
dos dimensiones:

-   **Vertical**, referida a la relación con el sistema
    político en temas como confianza en instituciones,
    satisfacción con la democracia.

-   **Horizontal**, que considera fundamentalmente las
    relaciones con los demás.

En el procesamiento de los datos se calculó el promedio por
país y por ola de la encuesta para cada uno de los
indicadores seleccionados. Adicionalmente, se generaron
promedios de las variables por año para tener como referente
de comparación en los análisis nacionales. Junto a ello se
incorporaron a la base de datos dos variables
macroeconómicas, el Producto Interno Bruto (PIB) y el índice
de Gini para medir desigualdad de ingresos dentro del país,
las cuales aparecen como posibles opciones de selección en
la pestaña de análisis bivariado.

El listado de variables se resume en la siguiente tabla:

+----+-------+---------------+---------------+--------+
| ID | Name  | Label         | Value Labels  | \%     |
+====+=======+===============+===============+========+
| 1  | it1   | Confianza     | Nada          | 9.75\  |
|    |       | I             | confiable\    | 26.30\ |
|    |       | nterpersonal: | Poco          | 41.35\ |
|    |       | Ahora,        | confiable\    | 22.60  |
|    |       | hablando de   | Algo          |        |
|    |       | la\           | confiable\    |        |
|    |       | gente de por  | Muy confiable |        |
|    |       | aquí, ¿diría  |               |        |
|    |       | que la gente  |               |        |
|    |       | de su\        |               |        |
|    |       | comunidad es  |               |        |
|    |       | muy           |               |        |
|    |       | confiable,    |               |        |
|    |       | algo          |               |        |
|    |       | confiable,    |               |        |
|    |       | poco\         |               |        |
|    |       | confiable o   |               |        |
|    |       | nada          |               |        |
|    |       | confiable?    |               |        |
+----+-------+---------------+---------------+--------+
| 2  | prot3 | Participar en | Sí\           | 8.52\  |
|    |       | Protesta: ¿En | No            | 91.48  |
|    |       | los últimos   |               |        |
|    |       | 12 meses\     |               |        |
|    |       | ha            |               |        |
|    |       | participado   |               |        |
|    |       | en una        |               |        |
|    |       | manifestación |               |        |
|    |       | o protesta\   |               |        |
|    |       | pública?      |               |        |
+----+-------+---------------+---------------+--------+
| 3  | aoj12 | Confianza en  | Nada\         | 28.33\ |
|    |       | Eficacia      | Poco\         | 31.76\ |
|    |       | Sistema       | Algo\         | 24.82\ |
|    |       | Judicial : Si | Mucho         | 15.09  |
|    |       | usted\        |               |        |
|    |       | fuera víctima |               |        |
|    |       | de un robo o  |               |        |
|    |       | asalto,       |               |        |
|    |       | ¿cuánto\      |               |        |
|    |       | confiaría que |               |        |
|    |       | el sistema    |               |        |
|    |       | judicial      |               |        |
|    |       | castigue al\  |               |        |
|    |       | culpable?     |               |        |
|    |       | Confiaría     |               |        |
+----+-------+---------------+---------------+--------+
| 4  | b2    | Respeto por   | Nada\         | 0.00\  |
|    |       | las           | 2\            | 10.63\ |
|    |       | I             | 3\            | 17.59\ |
|    |       | nstituciones: | 4\            | 24.88\ |
|    |       | ¿Hasta qué    | 5\            | 26.74\ |
|    |       | punto\        | 6\            | 20.17\ |
|    |       | tiene usted   | Mucho         | 0.00   |
|    |       | respeto por   |               |        |
|    |       | las           |               |        |
|    |       | i             |               |        |
|    |       | nstituciones\ |               |        |
|    |       | políticas de  |               |        |
|    |       | su país?      |               |        |
+----+-------+---------------+---------------+--------+
| 5  | b3    | Protección    | Nada\         | 0.00\  |
|    |       | Derechos      | 2\            | 14.92\ |
|    |       | Básicos       | 3\            | 22.82\ |
|    |       | ¿Hasta qué    | 4\            | 27.30\ |
|    |       | punto cree\   | 5\            | 23.16\ |
|    |       | usted que los | 6\            | 11.79\ |
|    |       | derechos      | Mucho         | 0.00   |
|    |       | básicos del   |               |        |
|    |       | ciudadano     |               |        |
|    |       | están\        |               |        |
|    |       | bien          |               |        |
|    |       | protegidos    |               |        |
|    |       | por el        |               |        |
|    |       | sistema       |               |        |
|    |       | político de   |               |        |
|    |       | su\           |               |        |
|    |       | país?         |               |        |
+----+-------+---------------+---------------+--------+
| 6  | b4    | Orgullo con   | Nada\         | 0.00\  |
|    |       | el Sistema    | 2\            | 13.44\ |
|    |       | Político:     | 3\            | 19.54\ |
|    |       | ¿Hasta qué    | 4\            | 25.67\ |
|    |       | punto\        | 5\            | 24.68\ |
|    |       | se siente     | 6\            | 16.66\ |
|    |       | usted         | Mucho         | 0.00   |
|    |       | orgulloso de  |               |        |
|    |       | vivir bajo el |               |        |
|    |       | sistema\      |               |        |
|    |       | político de   |               |        |
|    |       | su país?      |               |        |
+----+-------+---------------+---------------+--------+
| 7  | b10a  | Confianza en  | Nada\         | 0.00\  |
|    |       | Sistema       | 2\            | 15.14\ |
|    |       | Judicial:     | 3\            | 22.40\ |
|    |       | ¿Hasta qué    | 4\            | 26.38\ |
|    |       | punto\        | 5\            | 23.30\ |
|    |       | tiene         | 6\            | 12.79\ |
|    |       | confianza en  | Mucho         | 0.00   |
|    |       | el sistema de |               |        |
|    |       | justicia?     |               |        |
+----+-------+---------------+---------------+--------+
| 8  | b12   | Confianza en  | Nada\         | 0.00\  |
|    |       | Fuerzas       | 2\            | 9.36\  |
|    |       | Armadas:      | 3\            | 15.08\ |
|    |       | ¿Hasta qué    | 4\            | 22.71\ |
|    |       | punto\        | 5\            | 27.94\ |
|    |       | tiene         | 6\            | 24.91\ |
|    |       | confianza     | Mucho         | 0.00   |
|    |       | usted en las  |               |        |
|    |       | Fuerzas       |               |        |
|    |       | Armadas?      |               |        |
+----+-------+---------------+---------------+--------+
| 9  | b20   | Confianza en  | Nada\         | 0.00\  |
|    |       | Iglesia       | 2\            | 10.67\ |
|    |       | Católica:     | 3\            | 14.24\ |
|    |       | ¿Hasta qué    | 4\            | 20.44\ |
|    |       | punto\        | 5\            | 26.34\ |
|    |       | tiene         | 6\            | 28.32\ |
|    |       | confianza     | Mucho         | 0.00   |
|    |       | usted en la   |               |        |
|    |       | Iglesia       |               |        |
|    |       | Católica?     |               |        |
+----+-------+---------------+---------------+--------+
| 10 | b20a  | Confianza en  | Nada\         | 0.00\  |
|    |       | Iglesias      | 2\            | 15.93\ |
|    |       | Evangélicas : | 3\            | 18.82\ |
|    |       | ¿Hasta qué\   | 4\            | 22.73\ |
|    |       | punto tiene   | 5\            | 23.99\ |
|    |       | confianza     | 6\            | 18.54\ |
|    |       | usted en la   | Mucho         | 0.00   |
|    |       | Iglesia\      |               |        |
|    |       | Evangélica?   |               |        |
+----+-------+---------------+---------------+--------+
| 11 | b21   | Confianza en  | Nada\         | 0.00\  |
|    |       | Partidos      | 2\            | 21.90\ |
|    |       | Políticos:    | 3\            | 25.83\ |
|    |       | ¿Hasta qué    | 4\            | 26.29\ |
|    |       | punto\        | 5\            | 18.25\ |
|    |       | tiene         | 6\            | 7.73\  |
|    |       | confianza     | Mucho         | 0.00   |
|    |       | usted en los  |               |        |
|    |       | partidos      |               |        |
|    |       | políticos?    |               |        |
+----+-------+---------------+---------------+--------+
| 12 | b21a  | Confianza en  | Nada\         | 0.00\  |
|    |       | Ejecutivo:    | 2\            | 13.85\ |
|    |       | ¿Hasta qué    | 3\            | 17.83\ |
|    |       | punto tiene\  | 4\            | 24.16\ |
|    |       | confianza     | 5\            | 24.82\ |
|    |       | usted en el   | 6\            | 19.34\ |
|    |       | presidente?   | Mucho         | 0.00   |
+----+-------+---------------+---------------+--------+
| 13 | n9    | Evaluación    | Nada\         | 0.00\  |
|    |       | del Desempeño | 2\            | 17.38\ |
|    |       | del Gobierno  | 3\            | 22.81\ |
|    |       | Combatiendo\  | 4\            | 24.93\ |
|    |       | Corrupción:   | 5\            | 21.65\ |
|    |       | ¿Hasta qué    | 6\            | 13.23\ |
|    |       | punto diría   | Mucho         | 0.00   |
|    |       | que el        |               |        |
|    |       | gobierno\     |               |        |
|    |       | actual        |               |        |
|    |       | combate la    |               |        |
|    |       | corrupción en |               |        |
|    |       | el gobierno?  |               |        |
+----+-------+---------------+---------------+--------+
| 14 | n11   | Evaluación    | Nada\         | 0.00\  |
|    |       | del Desempeño | 2\            | 15.53\ |
|    |       | del Gobierno  | 3\            | 22.72\ |
|    |       | en Seguridad\ | 4\            | 26.40\ |
|    |       | Ciudadana:    | 5\            | 22.55\ |
|    |       | ¿Hasta qué    | 6\            | 12.81\ |
|    |       | punto diría   | Mucho         | 0.00   |
|    |       | que el        |               |        |
|    |       | gobierno\     |               |        |
|    |       | actual mejora |               |        |
|    |       | la seguridad  |               |        |
|    |       | ciudadana?    |               |        |
+----+-------+---------------+---------------+--------+
| 15 | n15   | Evaluación    | Nada\         | 0.00\  |
|    |       | del Desempeño | 2\            | 14.95\ |
|    |       | del Gobierno  | 3\            | 22.34\ |
|    |       | Manejando\    | 4\            | 25.96\ |
|    |       | Economía:     | 5\            | 23.07\ |
|    |       | ¿Hasta qué    | 6\            | 13.68\ |
|    |       | punto diría   | Mucho         | 0.00   |
|    |       | que el        |               |        |
|    |       | gobierno\     |               |        |
|    |       | actual está   |               |        |
|    |       | manejando     |               |        |
|    |       | bien la       |               |        |
|    |       | economía?     |               |        |
+----+-------+---------------+---------------+--------+
| 16 | ros4  | Políticas     | Muy en        | 0.00\  |
|    |       | re            | Desacuerdo\   | 6.10\  |
|    |       | distributivas | 2\            | 11.31\ |
|    |       | : El Estado   | 3\            | 21.50\ |
|    |       | debe\         | 4\            | 28.82\ |
|    |       | implementar   | 5\            | 32.26\ |
|    |       | políticas     | 6\            | 0.00   |
|    |       | firmes para   | Muy de        |        |
|    |       | reducir la\   | acuerdo       |        |
|    |       | desigualdad   |               |        |
|    |       | de ingresos   |               |        |
|    |       | entre ricos y |               |        |
|    |       | pobres.\      |               |        |
|    |       | ¿Hasta qué    |               |        |
|    |       | punto está de |               |        |
|    |       | acuerdo o en  |               |        |
|    |       | desacuerdo\   |               |        |
|    |       | con esta      |               |        |
|    |       | frase?        |               |        |
+----+-------+---------------+---------------+--------+
| 17 | ing4  | Democracia es | Muy en        | 0.00\  |
|    |       | Mejor que     | Desacuerdo\   | 6.14\  |
|    |       | otras Formas  | 2\            | 13.21\ |
|    |       | de Gobierno:\ | 3\            | 24.80\ |
|    |       | puede que la  | 4\            | 28.92\ |
|    |       | democracia    | 5\            | 26.93\ |
|    |       | tenga         | 6\            | 0.00   |
|    |       | problemas,    | Muy de        |        |
|    |       | pero es\      | acuerdo       |        |
|    |       | mejor que     |               |        |
|    |       | cualquier     |               |        |
|    |       | otra forma de |               |        |
|    |       | gobierno.     |               |        |
|    |       | ¿Hasta\       |               |        |
|    |       | qué punto     |               |        |
|    |       | está de       |               |        |
|    |       | acuerdo o en  |               |        |
|    |       | desacuerdo    |               |        |
|    |       | con esta\     |               |        |
|    |       | frase?        |               |        |
+----+-------+---------------+---------------+--------+
| 18 | eff1  | Gobernantes   | Muy en        | 0.00\  |
|    |       | están         | Desacuerdo\   | 19.59\ |
|    |       | Interesados   | 2\            | 22.28\ |
|    |       | en lo que la  | 3\            | 24.92\ |
|    |       | Gente\        | 4\            | 21.08\ |
|    |       | Piensa: A los | 5\            | 12.13\ |
|    |       | que gobiernan | 6\            | 0.00   |
|    |       | el país les   | Muy de        |        |
|    |       | interesa\     | acuerdo       |        |
|    |       | lo que piensa |               |        |
|    |       | la gente como |               |        |
|    |       | usted. ¿Hasta |               |        |
|    |       | qué\          |               |        |
|    |       | punto está de |               |        |
|    |       | acuerdo o en  |               |        |
|    |       | desacuerdo    |               |        |
|    |       | con esta\     |               |        |
|    |       | frase?        |               |        |
+----+-------+---------------+---------------+--------+
| 19 | pn4   | Satisfacción  | Muy           | 9.67\  |
|    |       | con la        | insatisfecho\ | 39.74\ |
|    |       | Democracia:   | Insatisfecho\ | 44.55\ |
|    |       | En general,   | Satisfecho\   | 6.03   |
|    |       | ¿usted\       | Muy           |        |
|    |       | diría que     | satisfecho    |        |
|    |       | está muy      |               |        |
|    |       | s             |               |        |
|    |       | atisfecho(a), |               |        |
|    |       | sa            |               |        |
|    |       | tisfecho(a),\ |               |        |
|    |       | in            |               |        |
|    |       | satisfecho(a) |               |        |
|    |       | o muy         |               |        |
|    |       | in            |               |        |
|    |       | satisfecho(a) |               |        |
|    |       | con la forma\ |               |        |
|    |       | en que la     |               |        |
|    |       | democracia    |               |        |
|    |       | funciona en   |               |        |
|    |       | su país?      |               |        |
+----+-------+---------------+---------------+--------+
| 20 | exc7  | Percepción de | Nada          | 4.66\  |
|    |       | Corrupción    | generalizada\ | 16.18\ |
|    |       | Pública:      | Poco          | 36.00\ |
|    |       | Teniendo en\  | generalizada\ | 43.16  |
|    |       | cuenta su     | Algo          |        |
|    |       | experiencia o | generalizada\ |        |
|    |       | lo que ha     | Muy           |        |
|    |       | oído          | generalizada  |        |
|    |       | mencionar,\   |               |        |
|    |       | ¿la           |               |        |
|    |       | corrupción de |               |        |
|    |       | los           |               |        |
|    |       | funcionarios  |               |        |
|    |       | públicos en   |               |        |
|    |       | el\           |               |        |
|    |       | país está:    |               |        |
+----+-------+---------------+---------------+--------+
| 21 | pol1  | Interés en    | Nada\         | 33.29\ |
|    |       | Política:     | Poco\         | 33.42\ |
|    |       | ¿Qué tanto    | Algo\         | 21.90\ |
|    |       | interés       | Mucho         | 11.38  |
|    |       | tiene\        |               |        |
|    |       | usted en la   |               |        |
|    |       | política:     |               |        |
|    |       | mucho, algo,  |               |        |
|    |       | poco o nada?  |               |        |
+----+-------+---------------+---------------+--------+
| 22 | vb2   | Voto en       | Sí votó\      | 74.67\ |
|    |       | Últimas       | No votó       | 25.33  |
|    |       | Elecciones    |               |        |
|    |       | Pr            |               |        |
|    |       | esidenciales: |               |        |
|    |       | ¿Votó\        |               |        |
|    |       | usted en las  |               |        |
|    |       | últimas       |               |        |
|    |       | elecciones    |               |        |
|    |       | pr            |               |        |
|    |       | esidenciales? |               |        |
+----+-------+---------------+---------------+--------+
| 23 | pr4   | Respeto por   | Nada\         | 0.00\  |
|    |       | la Propiedad  | 2\            | 11.11\ |
|    |       | Privada:      | 3\            | 19.72\ |
|    |       | ¿Hasta qué    | 4\            | 27.89\ |
|    |       | punto\        | 5\            | 25.94\ |
|    |       | siente usted  | 6\            | 15.33\ |
|    |       | que el Estado | Mucho         | 0.00   |
|    |       | de su país    |               |        |
|    |       | respeta la\   |               |        |
|    |       | propiedad     |               |        |
|    |       | privada de    |               |        |
|    |       | sus           |               |        |
|    |       | ciudadanos?   |               |        |
+----+-------+---------------+---------------+--------+

: Tabla: Listado de variables

# Bibliografía

> Banco Mundial. (2020). *Datos de libre acceso del Banco
> Mundial. Acceso abierto y gratuito a datos sobre el
> desarrollo en el mundo*. <https://datos.bancomundial.org/>

> Solt, F. (2020). Measuring Income Inequality Across
> Countries and Over Time: The Standardized World Income
> Inequality Database. *Social Science Quarterly, 101*(3),
> 1183-1199. <https://doi.org/10.1111/ssqu.12795>

## Estructura del repositorio:

```         
.
├── README.md
├── app
│   ├── OCS-COES.Rproj
│   ├── global.R
│   ├── home.Rmd
│   ├── home.html
│   ├── instrucciones.Rmd
│   ├── instrucciones.html
│   ├── rsconnect
│   │   └── shinyapps.io
│   │       ├── jandimter
│   │       │   └── app21.dcf
│   │       └── juitsa
│   │           └── ocs-coes.dcf
│   ├── server.R
│   ├── ui.R
│   ├── upload_app.R
│   └── www
│       ├── bib
│       │   └── ocs-library.bib
│       ├── css
│       │   ├── custom-a.css
│       │   └── docs-theme.css
│       ├── html
│       │   └── disqus.html
│       └── images
│           ├── OCS_1_1.png
│           ├── OCS_1_1.svg
│           ├── OCS_sfonts.svg
│           ├── graficar.png
│           ├── logo-ocs-animated.gif
│           ├── ocs-21.png
│           ├── ocs-logo.png
│           └── ocs-negro.png
├── estructura_repositorio.txt
├── fraseo_preguntas.Rdata
├── input
│   └── data
│       ├── original
│       │   ├── 4_LAPOP_2004_2018.RData
│       │   ├── 5_LAPOP_2018.dta
│       │   ├── GrandMerge.RData
│       │   ├── LAPOP2021
│       │   │   ├── ARG_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── BOL_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── BRA_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── CAN_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── CHL_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── COL_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── CRI_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── DOM_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── ECU_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── GTM_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── GUY_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── HND_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── HTI_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── JAM_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── MEX_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── NIC_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── PAN_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── PER_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── PRY_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── SLV_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   ├── URY_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   │   └── USA_2021_LAPOP_AmericasBarometer_v1.2_w.dta
│       │   ├── LAPOP_2004-2008.RData
│       │   ├── cepal_gini.RData
│       │   ├── fraseo_preguntas.Rdata
│       │   ├── fraseo_preguntas.xlsx
│       │   ├── lapop-faltantes
│       │   │   ├── argentina2016.dta
│       │   │   ├── argentina2018.dta
│       │   │   ├── bolivia2016.dta
│       │   │   ├── bolivia2018.dta
│       │   │   ├── brazil2016.dta
│       │   │   ├── brazil2018.dta
│       │   │   ├── canada2016.dta
│       │   │   ├── canada2018.dta
│       │   │   ├── chile2016.dta
│       │   │   ├── chile2018.dta
│       │   │   ├── colombia2016.dta
│       │   │   ├── costarica2016.dta
│       │   │   ├── costarica2018.dta
│       │   │   ├── ecuador2018.dta
│       │   │   ├── guyana2016.dta
│       │   │   ├── panama2016.dta
│       │   │   ├── panama2018.dta
│       │   │   ├── uruguay2016.dta
│       │   │   ├── uruguay2018.dta
│       │   │   ├── usa2016.dta
│       │   │   ├── usa2018.dta
│       │   │   └── venezuela2016.dta
│       │   ├── lapop_aggr.RData
│       │   ├── lapop_ind.RData
│       │   ├── swiid8_3.rda
│       │   └── swiid9_4.rda
│       └── proc
│           ├── lapop_count_2004to2021.RData
│           ├── lapop_count_2004to2021_long-wave.RData
│           └── lapop_ind_2004to2021.RData
├── lapop_count_2004to2018.RData
├── lapop_count_2004to2018_long-wave.RData
├── lapop_ind_2004to2018.RData
└── production
    ├── country_variables-original.R
    ├── prod_country-lvl-vars.R
    ├── prod_country-lvl-vars.rmd
    └── prod_var-labels.R

18 directories, 91 files

```
