# Observatorio de Cohesión Social


## Indicadores Comparativos de Cohesión Social para América Latina


Este sitio permite realizar análisis comparativos de distintos indicadores asociados a cohesión social en América Latina, como confianza interpersonal, valoración de la democracia, participación en protestas, entre otros. Para ello se utiliza la base de la encuesta **LAPOP** (Latin American Public Opinion Project), olas  2004, 2006, 2008, 2010, 2012 y 2014.

## Estructura del repositorio:

```
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
│               ocs-logo.png
│               ocs.png
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
