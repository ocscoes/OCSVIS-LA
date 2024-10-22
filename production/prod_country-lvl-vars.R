options(scipen=999)
rm(list=ls())

if (!require("pacman")) install.packages("pacman")
# remotes::install_github("nset-ornl/wbstats")
pacman::p_load(tidyverse,sjlabelled,countrycode,haven,questionr,wbstats,zoo,sjPlot,sjmisc)

#datos<-read_dta("input/data/original/GrandMerge.dta") # importante poner extensión .dta
# save(datos,file = "input/data/original/GrandMerge.RData")

# datos <- read_dta(file = "input/data/original/4_LAPOP_2004_2018.dta")
datos<- read_dta("input/data/original/2004-2018 LAPOP AmericasBarometer Merge (v1.0FREE).dta")

# save(datos,file = "input/data/original/4_LAPOP_2004_2018.RData")

# Cargar base de datos ------------------------------------------------------------------------
#load(file = "input/data/original/GrandMerge.RData") #Lapop: 2004 - 2014
l#apop18<- read_dta(file = "input/data/original/5_LAPOP_2018.dta")# Lapop: 2018

names(datos)#para saber el orden de las variables

# A 2018: seleccionar variables y pegarla a 2004-2014

#reducir base
datos <-datos %>% select(wave, year, pais, idnum, upm, strata, wt, weight1500, estratopri,
                         estratosec, ur, tamano, prov, cluster,
                         it1, prot3, aoj12, b2, b3, b4,
                         b10a, b12, b20, b20a, b21, b21a,
                         n9, n11, n15, ros4, ing4,
                         eff1, pn4, exc7, pol1, vb2) #subset de variables. pr4 
names(datos)

# variables ausentes en LAPOP 2018: n9,n11,n15,pr4

# Merge 2004-2014 + 2018 ----------------------------------------------------------------------

save() #guardar base a nivel individual para periodo 2004 - 2018


# Promedio pais | year ------------------------------------------------------------------------
datos2 <- datos %>% group_by(pais,wave)%>%summarise_all(funs(mean(., na.rm=TRUE))) 

# Promedio wave para cada variable ------------------------------------------------------------

## promedio de variables para cada ola (p.e. el nivel de confianza interpersonal en año 2006)
promedio_ola <- datos %>% group_by(wave)%>%summarise_all(funs(mean(., na.rm=TRUE))) 

#promedios regionales
promedio_ola <- select(promedio_ola, wave, year, it1, prot3, aoj12, b2, b3, b4, b10a, b12, b20,
                       b20a, b21, b21a,n9, n11, n15, ros4, ing4, 
                       eff1, pn4, exc7, pol1, vb2) # pr4

# renombro varibles que incluyen promedio de ola
colnames(promedio_ola) <- c("wave","year","it1_promr","prot3_promr","aoj12_promr","b2_promr","b3_promr",
                            "b4_promr","b10a_promr","b12_promr","b20_promr","b20a_promr","b21_promr",
                            "b21a_promr","n9_promr","n11_promr", "n15_promr", "ros4_promr",
                            "ing4_promr", "eff1_promr", "pn4_promr", "exc7_promr","pol1_promr", "vb2_promr") #"pr4_promr"

# unir en una base de datos
lapop_country <- merge(datos2, promedio_ola, by = "wave")

# ordenar los datos
### Comentario: no usar.
lapop_country <- arrange(lapop_country,
                         pais,wave,year,
                         it1, it1_promr,
                         prot3, prot3_promr,
                         aoj12, aoj12_promr,
                         b2, b2_promr,
                         b3, b3_promr,
                         b4, b4_promr,
                         b10a, b10a_promr,
                         b12, b12_promr,
                         b20, b20_promr,
                         b20a, b20a_promr,
                         b21, b21_promr,
                         b21a, b21a_promr,
                         n9,n9_promr,
                         n11, n11_promr,
                         n15, n15_promr,
                         ros4,ros4_promr,
                         ing4, ing4_promr,
                         eff1,eff1_promr,
                         pn4, pn4_promr,
                         exc7, exc7_promr,
                         pol1, pol1_promr,
                         vb2, vb2_promr) # pr4, pr4_promr,

# crear variable country name como character y nombre en iso3c (p.e. United States = USA)
lapop_country$pais.name <- as_label(as_factor(lapop_country$pais))
lapop_country$isocode   <- countrycode(lapop_country$pais.name, 
                                       origin = 'country.name', 
                                       destination = 'iso3c')
lapop_country[,c("pais","pais.name","isocode")]

# Variables a Nivel Macro ---------------------------------------------------------------------####



# country level variables -------------------------------------------------------------------------
paises<- unique(lapop_country$isocode)

# Gini Index (Gini) -------------------------------------------------------------------------------
for (i in 1:length(paises)) {
  name<-paste0("gini_", paises[i])
  pais<- paste0(paises[i])
  assign(name, wb(indicator = "SI.POV.GINI", country = pais, startdate = 2004, enddate = 2019))
}

gini<- rbind(gini_ARG, gini_BOL, gini_CAN, gini_COL, gini_DOM, gini_GTM, gini_HND, gini_JAM, gini_NIC, gini_PER, gini_SLV,
             gini_URY, gini_VEN, gini_BLZ, gini_BRA, gini_CHL, gini_CRI, gini_ECU, gini_GUY, gini_HTI, gini_MEX, gini_PAN,
             gini_PRY, gini_TTO, gini_USA)

gini<- gini %>% select(country,year=date,iso3c,gini=value)

# Gross Domestic Product (GDP) --------------------------------------------------------------------
for (i in 1:length(paises)) {
  name<-paste0("gdp_", paises[i])
  pais<- paste0(paises[i])
  assign(name, wb(indicator = "NY.GDP.PCAP.KD", country = pais, startdate = 2004, enddate = 2019))
}

gdp<- rbind(gdp_ARG, gdp_BOL, gdp_CAN, gdp_COL, gdp_DOM, gdp_GTM, gdp_HND, gdp_JAM, gdp_NIC, gdp_PER, gdp_SLV,
            gdp_URY, gdp_VEN, gdp_BLZ, gdp_BRA, gdp_CHL, gdp_CRI, gdp_ECU, gdp_GUY, gdp_HTI, gdp_MEX, gdp_PAN,
            gdp_PRY, gdp_TTO, gdp_USA)

gdp<- gdp %>% 
  select(country,year=date,iso3c,gdp=value) %>% 
  mutate(gdp=(gdp/1000)) #gpd in thounsand dolars

# Merge datasets ------------------------------------------------------------------------------
country_vars <- full_join(x = gini,y = gdp)
country_vars <- country_vars %>% arrange(country,year)

# Country x wave ------------------------------------------------------------------------------
table(lapop_country$pais.name,lapop_country$wave)
#                    2004 2006 2007 2008 2009 2010 2012 2014
# Mexico                1    1    0    1    0    1    1    1
# Guatemala             1    1    0    1    0    1    1    1
# El Salvador           1    1    0    1    0    1    1    1
# Honduras              1    1    0    1    0    1    1    1
# Nicaragua             1    1    0    1    0    1    1    1
# Costa Rica            1    1    0    1    0    1    1    1
# Panama                1    1    0    1    0    1    1    1
# Colombia              1    1    0    1    0    1    1    1
# Ecuador               1    1    0    1    0    1    1    1
# Bolivia               1    1    0    1    0    1    1    1
# Peru                  0    1    0    1    0    1    1    1
# Paraguay              0    1    0    1    0    1    1    1
# Chile                 0    1    0    1    0    1    1    1
# Uruguay               0    0    1    1    0    1    1    1
# Brazil                0    0    1    1    0    1    1    1
# Venezuela             0    0    1    1    0    1    1    1
# Argentina             0    0    0    1    0    1    1    1
# Dominican Republic    1    1    0    1    0    1    1    1
# Haiti                 0    1    0    1    0    1    1    1
# Jamaica               0    1    0    1    0    1    1    1
# Guyana                0    1    0    0    1    1    1    1
# Trinidad & Tobago     0    0    0    0    0    1    1    1
# Belize                0    0    0    1    0    1    1    1
# United States         0    1    0    1    0    1    1    1
# Canada                0    1    0    1    0    1    1    1


# PENDIENTES: Chequear datos faltantes por pais y agno [ver country_variables-original.R para procedimiento de imputacion]


#Juntar Gini, GDP y Lapop

table(lapop_country$wave)
table(country_vars$year)
table(lapop_country$isocode)
table(country_vars$iso3c)

country_vars$isocode <- country_vars$iso3c
country_vars$year <- as.numeric(country_vars$year)
country_vars$idwc <- paste(country_vars$wave, country_vars$isocode)
lapop_country$idwc <- paste(lapop_country$year.x, lapop_country$isocode)

lapop_country2 <- left_join(lapop_country , country_vars, by = c("year.x"="year", "isocode"="iso3c"))

#lapop_country <- merge(lapop_country, country_vars, by= "idwc")

# Esta correlacion muestra la consistencia entre el año de campo y el gini.
cor(lapop_country$year.x, lapop_country$year) 

## 5. Guardar base de datos
#save(lapop,file="lapop_country-level.RData") 
