# OCSVIS-LA

## Indicadores Comparativos de Cohesión Social para América Latina

Esta herramienta de visualización permite realizar análisis comparativos de distintos indicadores asociados a cohesión social en América Latina, como confianza interpersonal, valoración de la democracia, participación en protestas, entre otros. Para ello se utiliza la base de la encuesta **LAPOP** (Latin American Public Opinion Project), olas  2004, 2006, 2008, 2010, 2012, 2014 y 2018.

## Repositorio

El código de procesamiento de datos y generación de la herramienta de visualización se encuentra abierto en el repositorio [https://github.com/ocscoes/OCSVIS-LA](https://github.com/ocscoes/OCS-COES). El repositorio esta ordenado en modo general en 3 carpetas,

- Aplicación Shiny que permite la visualización de los datos (app),
- Datos utilizados (input). Cabe destacar, que siguiendo las políticas de resguardo de la información de LAPOP no se subirá la base de datos original sino solamente los códigos de procesamiento.
- Códigos de procesamiento de los datos (production).

La estructura del repositorio sigue la propuesta del protocolo <a href="https://lisa-coes.github.io/ipo/" target="_blank">IPO</a>

## Datos

La herramienta de visualización utiliza los datos abiertos disponibles de la encuesta Barómetro de las Américas, del LAPOP (Latin American Public Opinion Project), disponible en https://www.vanderbilt.edu/lapop/. En general esta encuesta es conocida como “Encuesta LAPOP”, y se define como “the only survey of democratic public opinion and behavior that covers the Americas (North, Central, South and the Caribbean). It is an effort by LAPOP to measure democratic values and behaviors in the Americas using national probability samples of voting-age adults”. Esta encuesta es bianual, comenzando el año 2004 con 11 países y en su ola 2018 abarca 29 países.

Además de la encuesta LAPOP se incorporan algunos indicadores económicos de países para el análisis obtenidos desde el Banco Mundial (World Bank, 2020) y la base de datos SWIID (Solt, 2020).

El número de casos según país y ola se presenta en la siguiente tabla.

<table class="table table-striped table-bordered" style="font-size: 14px; margin-left: auto; margin-right: auto;">
  <caption style="font-size: initial !important;">Número de encuestados por ola y país</caption>
  <thead>
    <tr>
      <th style="text-align:left;">   </th>
      <th style="text-align:right;"> 2004 </th>
      <th style="text-align:right;"> 2006 </th>
      <th style="text-align:right;"> 2008 </th>
      <th style="text-align:right;"> 2010 </th>
      <th style="text-align:right;"> 2012 </th>
      <th style="text-align:right;"> 2014 </th>
      <th style="text-align:right;"> 2016 </th>
      <th style="text-align:right;"> 2018 </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left;width: 5cm; "> Mexico </td>
      <td style="text-align:right;"> 1556 </td>
      <td style="text-align:right;"> 1560 </td>
      <td style="text-align:right;"> 1560 </td>
      <td style="text-align:right;"> 1562 </td>
      <td style="text-align:right;"> 1560 </td>
      <td style="text-align:right;"> 1578 </td>
      <td style="text-align:right;"> 1563 </td>
      <td style="text-align:right;"> 1580 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Guatemala </td>
      <td style="text-align:right;"> 1708 </td>
      <td style="text-align:right;"> 1498 </td>
      <td style="text-align:right;"> 1538 </td>
      <td style="text-align:right;"> 1504 </td>
      <td style="text-align:right;"> 1509 </td>
      <td style="text-align:right;"> 1506 </td>
      <td style="text-align:right;"> 1546 </td>
      <td style="text-align:right;"> 1596 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> El Salvador </td>
      <td style="text-align:right;"> 1589 </td>
      <td style="text-align:right;"> 1729 </td>
      <td style="text-align:right;"> 1549 </td>
      <td style="text-align:right;"> 1550 </td>
      <td style="text-align:right;"> 1497 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1551 </td>
      <td style="text-align:right;"> 1511 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Honduras </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1585 </td>
      <td style="text-align:right;"> 1522 </td>
      <td style="text-align:right;"> 1596 </td>
      <td style="text-align:right;"> 1728 </td>
      <td style="text-align:right;"> 1561 </td>
      <td style="text-align:right;"> 1560 </td>
      <td style="text-align:right;"> 1560 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Nicaragua </td>
      <td style="text-align:right;"> 1430 </td>
      <td style="text-align:right;"> 1762 </td>
      <td style="text-align:right;"> 1540 </td>
      <td style="text-align:right;"> 1540 </td>
      <td style="text-align:right;"> 1686 </td>
      <td style="text-align:right;"> 1547 </td>
      <td style="text-align:right;"> 1560 </td>
      <td style="text-align:right;"> 1547 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Costa Rica </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1498 </td>
      <td style="text-align:right;"> 1541 </td>
      <td style="text-align:right;"> 1514 </td>
      <td style="text-align:right;"> 1501 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Panama </td>
      <td style="text-align:right;"> 1639 </td>
      <td style="text-align:right;"> 1536 </td>
      <td style="text-align:right;"> 1536 </td>
      <td style="text-align:right;"> 1536 </td>
      <td style="text-align:right;"> 1620 </td>
      <td style="text-align:right;"> 1508 </td>
      <td style="text-align:right;"> 1521 </td>
      <td style="text-align:right;"> 1559 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Colombia </td>
      <td style="text-align:right;"> 1479 </td>
      <td style="text-align:right;"> 1491 </td>
      <td style="text-align:right;"> 1503 </td>
      <td style="text-align:right;"> 1506 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1563 </td>
      <td style="text-align:right;"> 1663 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Ecuador </td>
      <td style="text-align:right;"> 3000 </td>
      <td style="text-align:right;"> 2925 </td>
      <td style="text-align:right;"> 3000 </td>
      <td style="text-align:right;"> 3000 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1545 </td>
      <td style="text-align:right;"> 1533 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Bolivia </td>
      <td style="text-align:right;"> 3073 </td>
      <td style="text-align:right;"> 3008 </td>
      <td style="text-align:right;"> 3003 </td>
      <td style="text-align:right;"> 3018 </td>
      <td style="text-align:right;"> 3029 </td>
      <td style="text-align:right;"> 3068 </td>
      <td style="text-align:right;"> 1691 </td>
      <td style="text-align:right;"> 1682 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Peru </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 2647 </td>
      <td style="text-align:right;"> 1521 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Paraguay </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1165 </td>
      <td style="text-align:right;"> 1166 </td>
      <td style="text-align:right;"> 1502 </td>
      <td style="text-align:right;"> 1510 </td>
      <td style="text-align:right;"> 1515 </td>
      <td style="text-align:right;"> 1528 </td>
      <td style="text-align:right;"> 1515 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Chile </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1517 </td>
      <td style="text-align:right;"> 1527 </td>
      <td style="text-align:right;"> 1965 </td>
      <td style="text-align:right;"> 1571 </td>
      <td style="text-align:right;"> 1571 </td>
      <td style="text-align:right;"> 1625 </td>
      <td style="text-align:right;"> 1638 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Uruguay </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1200 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1514 </td>
      <td style="text-align:right;"> 1581 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Brasil </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1214 </td>
      <td style="text-align:right;"> 1497 </td>
      <td style="text-align:right;"> 2482 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1532 </td>
      <td style="text-align:right;"> 1498 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Venezuela </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1510 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1558 </td>
      <td style="text-align:right;"> 0 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Argentina </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1486 </td>
      <td style="text-align:right;"> 1410 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1528 </td>
      <td style="text-align:right;"> 1528 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Republica Dominicana </td>
      <td style="text-align:right;"> 4460 </td>
      <td style="text-align:right;"> 1516 </td>
      <td style="text-align:right;"> 1507 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1520 </td>
      <td style="text-align:right;"> 1518 </td>
      <td style="text-align:right;"> 1516 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Haiti </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1625 </td>
      <td style="text-align:right;"> 1536 </td>
      <td style="text-align:right;"> 1752 </td>
      <td style="text-align:right;"> 1836 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 2221 </td>
      <td style="text-align:right;"> 0 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Jamaica </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1595 </td>
      <td style="text-align:right;"> 1499 </td>
      <td style="text-align:right;"> 1504 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1506 </td>
      <td style="text-align:right;"> 1515 </td>
      <td style="text-align:right;"> 1513 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Guyana </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1555 </td>
      <td style="text-align:right;"> 2514 </td>
      <td style="text-align:right;"> 1540 </td>
      <td style="text-align:right;"> 1529 </td>
      <td style="text-align:right;"> 1558 </td>
      <td style="text-align:right;"> 1576 </td>
      <td style="text-align:right;"> 0 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Trinidad y Tobago </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1503 </td>
      <td style="text-align:right;"> 1506 </td>
      <td style="text-align:right;"> 4207 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Belice </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 1552 </td>
      <td style="text-align:right;"> 1504 </td>
      <td style="text-align:right;"> 1512 </td>
      <td style="text-align:right;"> 1534 </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 0 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Estados Unidos </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 609 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1500 </td>
    </tr>
    <tr>
      <td style="text-align:left;width: 5cm; "> Canada </td>
      <td style="text-align:right;"> 0 </td>
      <td style="text-align:right;"> 601 </td>
      <td style="text-align:right;"> 2032 </td>
      <td style="text-align:right;"> 1500 </td>
      <td style="text-align:right;"> 1501 </td>
      <td style="text-align:right;"> 1517 </td>
      <td style="text-align:right;"> 1511 </td>
      <td style="text-align:right;"> 1508 </td>
    </tr>
  </tbody>
</table>

## Variables

La selección de variables de la encuesta LAPOP se realizó a partir de una perspectiva de cohesión social que considera dos dimensiones:

* **Vertical**, referida a la relación con el sistema político en temas como confianza en instituciones, satisfacción con la democracia.

* **Horizontal**, que considera fundamentalmente las relaciones con los demás.

En el procesamiento de los datos se calculó el promedio por país y por ola de la encuesta para cada uno de los indicadores seleccionados. Adicionalmente, se generaron promedios de las variables por año para tener como referente de comparación en los análisis nacionales. Junto a ello se incorporaron a la base de datos dos variables macroeconómicas, el Producto Interno Bruto (PIB) y el índice de Gini para medir desigualdad de ingresos dentro del país, las cuales aparecen como posibles opciones de selección en la pestaña de análisis bivariado.

El listado de variables se resume en la siguiente tabla:

<table>
  <caption>Tabla: Listado de variables</caption>
  <tbody>
    <tr>
      <th class="thead">ID</th>
      <th class="thead">Name</th>
      <th class="thead">Label</th>
      <th class="thead">Value Labels</th>
      <th class="thead">%</th>
    </tr>
    <tr>
      <td class="tdata">1</td>
      <td class="tdata">it1</td>
      <td class="tdata">Confianza Interpersonal:  Ahora, hablando de la<br>gente de por aquí, ¿diría que la gente de su<br>comunidad es muy
        confiable, algo confiable, poco<br>confiable o nada confiable?
      </td>
      <td class="tdata">Nada
        confiable<br>Poco
        confiable<br>Algo
        confiable<br>Muy
        confiable
      </td>
      <td class="tdata">9.75<br>26.30<br>41.35<br>22.60</td>
    </tr>
    <tr>
      <td class="tdata arc">2</td>
      <td class="tdata arc">prot3</td>
      <td class="tdata arc">Participar en Protesta: ¿En los últimos 12 meses<br>ha participado en una manifestación o protesta<br>pública?</td>
      <td class="tdata arc">Sí<br>No</td>
      <td class="tdata arc">8.52<br>91.48</td>
    </tr>
    <tr>
      <td class="tdata">3</td>
      <td class="tdata">aoj12</td>
      <td class="tdata">Confianza en Eficacia Sistema Judicial :  Si usted<br>fuera víctima de un robo o asalto, ¿cuánto<br>confiaría que el sistema judicial castigue al<br>culpable? Confiaría</td>
      <td class="tdata">Nada<br>Poco<br>Algo<br>Mucho</td>
      <td class="tdata">28.33<br>31.76<br>24.82<br>15.09</td>
    </tr>
    <tr>
      <td class="tdata arc">4</td>
      <td class="tdata arc">b2</td>
      <td class="tdata arc">Respeto por las Instituciones: ¿Hasta qué punto<br>tiene usted respeto por las instituciones<br>políticas de su país?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>10.63<br>17.59<br>24.88<br>26.74<br>20.17<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">5</td>
      <td class="tdata">b3</td>
      <td class="tdata">Protección Derechos Básicos
        ¿Hasta qué punto cree<br>usted que los derechos básicos del ciudadano están<br>bien protegidos por el sistema político de su<br>país?
      </td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>14.92<br>22.82<br>27.30<br>23.16<br>11.79<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">6</td>
      <td class="tdata arc">b4</td>
      <td class="tdata arc">Orgullo con el Sistema Político: ¿Hasta qué punto<br>se siente usted orgulloso de vivir bajo el sistema<br>político de su país?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>13.44<br>19.54<br>25.67<br>24.68<br>16.66<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">7</td>
      <td class="tdata">b10a</td>
      <td class="tdata">Confianza en Sistema Judicial: ¿Hasta qué punto<br>tiene confianza en el sistema de justicia?</td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>15.14<br>22.40<br>26.38<br>23.30<br>12.79<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">8</td>
      <td class="tdata arc">b12</td>
      <td class="tdata arc">Confianza en Fuerzas Armadas:  ¿Hasta qué punto<br>tiene confianza usted en las Fuerzas Armadas?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>9.36<br>15.08<br>22.71<br>27.94<br>24.91<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">9</td>
      <td class="tdata">b20</td>
      <td class="tdata">Confianza en Iglesia Católica: ¿Hasta qué punto<br>tiene confianza usted en la Iglesia Católica?</td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>10.67<br>14.24<br>20.44<br>26.34<br>28.32<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">10</td>
      <td class="tdata arc">b20a</td>
      <td class="tdata arc">Confianza en Iglesias Evangélicas : ¿Hasta qué<br>punto tiene confianza usted en la Iglesia<br>Evangélica?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>15.93<br>18.82<br>22.73<br>23.99<br>18.54<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">11</td>
      <td class="tdata">b21</td>
      <td class="tdata">Confianza en Partidos Políticos:  ¿Hasta qué punto<br>tiene confianza usted en los partidos políticos?</td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>21.90<br>25.83<br>26.29<br>18.25<br>7.73<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">12</td>
      <td class="tdata arc">b21a</td>
      <td class="tdata arc">Confianza en Ejecutivo: ¿Hasta qué punto tiene<br>confianza usted en el presidente?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>13.85<br>17.83<br>24.16<br>24.82<br>19.34<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">13</td>
      <td class="tdata">n9</td>
      <td class="tdata">Evaluación del Desempeño del Gobierno Combatiendo<br>Corrupción: ¿Hasta qué punto diría que el gobierno<br>actual combate la corrupción en el
        gobierno?
      </td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>17.38<br>22.81<br>24.93<br>21.65<br>13.23<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">14</td>
      <td class="tdata arc">n11</td>
      <td class="tdata arc">Evaluación del Desempeño del Gobierno en Seguridad<br>Ciudadana: ¿Hasta qué punto diría que el gobierno<br>actual mejora la seguridad ciudadana?</td>
      <td class="tdata arc">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata arc">0.00<br>15.53<br>22.72<br>26.40<br>22.55<br>12.81<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">15</td>
      <td class="tdata">n15</td>
      <td class="tdata">Evaluación del Desempeño del Gobierno Manejando<br>Economía:  ¿Hasta qué punto diría que el gobierno<br>actual está manejando bien la economía? </td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>14.95<br>22.34<br>25.96<br>23.07<br>13.68<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">16</td>
      <td class="tdata arc">ros4</td>
      <td class="tdata arc">Políticas redistributivas :  El Estado debe<br>implementar políticas firmes para reducir la<br>desigualdad de ingresos entre ricos y pobres.<br>¿Hasta qué punto está de acuerdo o en desacuerdo<br>con esta frase? </td>
      <td class="tdata arc">Muy en
        Desacuerdo<br>2<br>3<br>4<br>5<br>6<br>Muy de
        acuerdo
      </td>
      <td class="tdata arc">0.00<br>6.10<br>11.31<br>21.50<br>28.82<br>32.26<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">17</td>
      <td class="tdata">ing4</td>
      <td class="tdata">Democracia es Mejor que otras Formas de Gobierno:<br>puede que la democracia tenga problemas, pero es<br>mejor que cualquier otra forma de gobierno. ¿Hasta<br>qué punto está de acuerdo o en
        desacuerdo con esta<br>frase?
      </td>
      <td class="tdata">Muy en
        Desacuerdo<br>2<br>3<br>4<br>5<br>6<br>Muy de
        acuerdo
      </td>
      <td class="tdata">0.00<br>6.14<br>13.21<br>24.80<br>28.92<br>26.93<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata arc">18</td>
      <td class="tdata arc">eff1</td>
      <td class="tdata arc">Gobernantes están Interesados en lo que la Gente<br>Piensa: A los que gobiernan el país les interesa<br>lo que piensa la gente como usted. ¿Hasta qué<br>punto está de acuerdo o en desacuerdo con esta<br>frase?</td>
      <td class="tdata arc">Muy en
        Desacuerdo<br>2<br>3<br>4<br>5<br>6<br>Muy de
        acuerdo
      </td>
      <td class="tdata arc">0.00<br>19.59<br>22.28<br>24.92<br>21.08<br>12.13<br>0.00</td>
    </tr>
    <tr>
      <td class="tdata">19</td>
      <td class="tdata">pn4</td>
      <td class="tdata">Satisfacción con la Democracia: En general, ¿usted<br>diría que está muy satisfecho(a), satisfecho(a),<br>insatisfecho(a) o muy insatisfecho(a) con la forma<br>en que la democracia funciona en su país?</td>
      <td class="tdata">Muy
        insatisfecho<br>Insatisfecho<br>Satisfecho<br>Muy
        satisfecho
      </td>
      <td class="tdata">9.67<br>39.74<br>44.55<br>6.03</td>
    </tr>
    <tr>
      <td class="tdata arc">20</td>
      <td class="tdata arc">exc7</td>
      <td class="tdata arc">Percepción de Corrupción Pública: Teniendo en<br>cuenta su experiencia o lo que ha oído mencionar,<br>¿la corrupción de los funcionarios públicos en el<br>país está:</td>
      <td class="tdata arc">Nada
        generalizada<br>Poco
        generalizada<br>Algo
        generalizada<br>Muy
        generalizada
      </td>
      <td class="tdata arc">4.66<br>16.18<br>36.00<br>43.16</td>
    </tr>
    <tr>
      <td class="tdata">21</td>
      <td class="tdata">pol1</td>
      <td class="tdata">Interés en Política: ¿Qué tanto interés tiene<br>usted en la política: mucho, algo, poco o nada?</td>
      <td class="tdata">Nada<br>Poco<br>Algo<br>Mucho</td>
      <td class="tdata">33.29<br>33.42<br>21.90<br>11.38</td>
    </tr>
    <tr>
      <td class="tdata arc">22</td>
      <td class="tdata arc">vb2</td>
      <td class="tdata arc">Voto en Últimas Elecciones Presidenciales:  ¿Votó<br>usted en las últimas elecciones presidenciales?</td>
      <td class="tdata arc">Sí votó<br>No votó</td>
      <td class="tdata arc">74.67<br>25.33</td>
    </tr>
    <tr>
      <td class="tdata">23</td>
      <td class="tdata">pr4</td>
      <td class="tdata">Respeto por la Propiedad Privada: ¿Hasta qué punto<br>siente usted que el Estado de su país respeta la<br>propiedad privada de
        sus ciudadanos?
      </td>
      <td class="tdata">Nada<br>2<br>3<br>4<br>5<br>6<br>Mucho</td>
      <td class="tdata">0.00<br>11.11<br>19.72<br>27.89<br>25.94<br>15.33<br>0.00</td>
    </tr>
  </tbody>
</table>

# Bibliografía

> Banco Mundial. (2020). _Datos de libre acceso del Banco Mundial. Acceso abierto y gratuito a datos sobre el desarrollo en el mundo_. [https://datos.bancomundial.org/](https://datos.bancomundial.org/)

> Solt, F. (2020). Measuring Income Inequality Across Countries and Over Time: The Standardized World Income Inequality Database. _Social Science Quarterly, 101_(3), 1183-1199. [https://doi.org/10.1111/ssqu.12795](https://doi.org/10.1111/ssqu.12795)


## Estructura del repositorio:

```
├───README.md
│
├───app
│   │   .Rhistory
│   │   global.R
│   │   home.html
│   │   home.Rmd
│   │   instrucciones.html
│   │   instrucciones.Rmd
│   │   OCS-COES.Rproj
│   │   server.R
│   │   ui.R
│   │   upload_app.R
│   │
│   ├───rsconnect
│   │   └───shinyapps.io
│   │       └───juitsa
│   │               ocs-coes.dcf
│   │
│   └───www
│       ├───bib
│       │       ocs-library.bib
│       │
│       ├───css
│       │       custom-a.css
│       │       docs-theme.css
│       │
│       ├───html
│       │       disqus.html
│       │
│       └───images
│               graficar.png
│               logo-ocs-animated.gif
│               ocs-21.png
│               ocs-logo.png
│               ocs-negro.png
│               OCS_1_1.png
│               OCS_1_1.svg
│               OCS_sfonts.svg
│
├───input
│   └───data
│       ├───original
│       │   │   4_LAPOP_2004_2018.RData
│       │   │   5_LAPOP_2018.dta
│       │   │   fraseo_preguntas.Rdata
│       │   │   fraseo_preguntas.xlsx
│       │   │   GrandMerge.RData
│       │   │   LAPOP_2004-2008.RData
│       │   │   lapop_aggr.RData
│       │   │   lapop_ind.RData
│       │   │   swiid8_3.rda
│       │   │
│       │   └───lapop-faltantes
│       │           argentina2016.dta
│       │           argentina2018.dta
│       │           bolivia2016.dta
│       │           bolivia2018.dta
│       │           brazil2016.dta
│       │           brazil2018.dta
│       │           canada2016.dta
│       │           canada2018.dta
│       │           chile2016.dta
│       │           chile2018.dta
│       │           colombia2016.dta
│       │           costarica2016.dta
│       │           costarica2018.dta
│       │           ecuador2018.dta
│       │           guyana2016.dta
│       │           panama2016.dta
│       │           panama2018.dta
│       │           uruguay2016.dta
│       │           uruguay2018.dta
│       │           usa2016.dta
│       │           usa2018.dta
│       │           venezuela2016.dta
│       │
│       └───proc
│               lapop_aggr_v2.RData
│               lapop_count_2004to2018.RData
│               lapop_count_2004to2018_long-wave.RData
│               lapop_ind_2004to2018.RData
│               lapop_ind_v2.RData
│
└───production
        .Rhistory
        country_variables-original.R
        prod_country-lvl-vars.R
        prod_country-lvl-vars.rmd
        prod_var-labels.R
```        

