# Observatorio de Cohesión Social


## Indicadores Comparativos de Cohesión Social para América Latina


Este sitio permite realizar análisis comparativos de distintos indicadores asociados a cohesión social en América Latina, como confianza interpersonal, valoración de la democracia, participación en protestas, entre otros. Para ello se utiliza la base de la encuesta **LAPOP** (Latin American Public Opinion Project), olas  2004, 2006, 2008, 2010, 2012 y 2014.

## Estructura del repositorio:

```
├── app
│   ├── rsconnect
│   │   ├── shinyapps.io
│   ├── www
│       ├── bib
|       |   └── ocs-library.bib
│       ├── css
|       |   ├── docs-theme.css  
|       |   └── custom-a.css
|       ├── html
|       |   └── disqus.html
|       └── images
|           ├── OCS_1_1.svg
|           └── OCS_sfonts.svg
├── input
│   ├── data
│       ├── original
│       |   ├── lapop_agrr.RData
|       |   └── lapop_agrr.RData
│       └── proc
│          ├── lapop_agrr_v2.RData
|          └── lapop_agrr_v2.RData
├── output
│   ├── backup_barplot.R
|   ├── recode_vars.R
├── README.md
```
