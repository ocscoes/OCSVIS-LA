library(pacman)
remotes::install_github("nset-ornl/wbstats")

p_load(dplyr, tidyverse, wbstats, zoo)

# Country Level variables 

paises<- c("ARG",
           "BOL",
           "BRA",
           "CHL",
           "COL",
           "CRI",
           "DOM",
           "ECU",
           "GTM",
           "HND",
           "MEX",
           "NIC",
           "PAN",
           "PER",
           "PRY",
           "SLV",
           "URY",
           "VEN")


#GINI
for (i in 1:length(paises)) {
  name<-paste0("gini_", paises[i])
  pais<- paste0(paises[i])
  assign(name, wb(indicator = "SI.POV.GINI", country = pais, startdate = 2005, enddate = 2019))
}

gini<- rbind(gini_ARG,
             gini_BOL,
             gini_BRA,
             gini_CHL,
             gini_COL,
             gini_CRI,
             gini_DOM,
             gini_ECU,
             gini_GTM,
             gini_HND,
             gini_MEX,
             gini_NIC,
             gini_PAN,
             gini_PER,
             gini_PRY,
             gini_SLV,
             gini_URY,
             gini_VEN)

gini$id<- NA
gini$id<- paste0(gini$iso3c,"_",gini$date)
gini<- gini[,c(8,1,2,3,4,5,6,7)]
gini<- gini[,c(1,4)]
names(gini)[2]<- "gini"


#GDP
for (i in 1:length(paises)) {
  name<-paste0("gdp_", paises[i])
  pais<- paste0(paises[i])
  assign(name, wb(indicator = "NY.GDP.PCAP.KD", country = pais, startdate = 2005, enddate = 2019))
}

gdp<- rbind(gdp_ARG,
            gdp_BOL,
            gdp_BRA,
            gdp_CHL,
            gdp_COL,
            gdp_CRI,
            gdp_DOM,
            gdp_ECU,
            gdp_GTM,
            gdp_HND,
            gdp_MEX,
            gdp_NIC,
            gdp_PAN,
            gdp_PER,
            gdp_PRY,
            gdp_SLV,
            gdp_URY,
            gdp_VEN)


gdp$id<- NA
gdp$id<- paste0(gdp$iso3c,"_",gdp$date)
gdp<- gdp[,c(8,1,2,3,4,5,6,7)]
gdp<- gdp[,c(1,4)]
names(gdp)[2]<- "gdp"

#Miles de dolares
gdp$gdp = (gdp$gdp)/1000



# Imputations



#Fusion databases

country_vars <- merge(gini, gdp, by="id", all=T)

country_vars_original = country_vars
#lapop_original = lapop

#Reasignación de datos en missings
country_vars$gini[country_vars$id=="ARG_2018"] <- country_vars$gini[country_vars$id=="ARG_2017"]
country_vars$gini[country_vars$id=="BOL_2010"] <- country_vars$gini[country_vars$id=="BOL_2009"]
country_vars$gini[country_vars$id=="BOL_2018"] <- country_vars$gini[country_vars$id=="BOL_2017"]
country_vars$gini[country_vars$id=="BRA_2010"] <- country_vars$gini[country_vars$id=="BRA_2009"]
country_vars$gini[country_vars$id=="BRA_2018"] <- country_vars$gini[country_vars$id=="BRA_2017"]
country_vars$gini[country_vars$id=="CHL_2008"] <- country_vars$gini[country_vars$id=="CHL_2009"]
country_vars$gini[country_vars$id=="CHL_2010"] <- country_vars$gini[country_vars$id=="CHL_2009"]
country_vars$gini[country_vars$id=="CHL_2012"] <- country_vars$gini[country_vars$id=="CHL_2011"]
country_vars$gini[country_vars$id=="CHL_2014"] <- country_vars$gini[country_vars$id=="CHL_2013"]
country_vars$gini[country_vars$id=="CHL_2016"] <- country_vars$gini[country_vars$id=="CHL_2015"]
country_vars$gini[country_vars$id=="CHL_2018"] <- country_vars$gini[country_vars$id=="CHL_2017"]
country_vars$gini[country_vars$id=="COL_2018"] <- country_vars$gini[country_vars$id=="COL_2017"]
country_vars$gini[country_vars$id=="CRI_2018"] <- country_vars$gini[country_vars$id=="CRI_2017"]
country_vars$gini[country_vars$id=="DOM_2018"] <- country_vars$gini[country_vars$id=="DOM_2016"] #DOM_2018
country_vars$gini[country_vars$id=="ECU_2018"] <- country_vars$gini[country_vars$id=="ECU_2017"]
country_vars$gini[country_vars$id=="HND_2018"] <- country_vars$gini[country_vars$id=="HND_2017"]
country_vars$gini[country_vars$id=="MEX_2018"] <- country_vars$gini[country_vars$id=="MEX_2016"] #MEX_2018
country_vars$gini[country_vars$id=="PAN_2018"] <- country_vars$gini[country_vars$id=="PAN_2017"]
country_vars$gini[country_vars$id=="PER_2018"] <- country_vars$gini[country_vars$id=="PER_2017"]
country_vars$gini[country_vars$id=="PRY_2018"] <- country_vars$gini[country_vars$id=="PRY_2017"]
country_vars$gini[country_vars$id=="SLV_2018"] <- country_vars$gini[country_vars$id=="SLV_2017"]
country_vars$gini[country_vars$id=="URY_2018"] <- country_vars$gini[country_vars$id=="URY_2017"]

#ECLAC
country_vars$gini[country_vars$id=="GTM_2006"] <- 55.8
country_vars$gini[country_vars$id=="GTM_2014"] <- 53.5
country_vars$gini[country_vars$id=="NIC_2009"] <- 46.3
country_vars$gini[country_vars$id=="NIC_2014"] <- 49.5
country_vars$gini[country_vars$id=="VEN_2008"] <- 37.9
country_vars$gini[country_vars$id=="VEN_2010"] <- 36.4
country_vars$gini[country_vars$id=="VEN_2012"] <- 38.4
country_vars$gini[country_vars$id=="VEN_2014"] <- 37.8

#Linear interpolation
country_vars$country_wave1 = country_vars$id

country_vars1 = country_vars %>% 
  separate(country_wave1, c("country", "year"))

#GTM
country_vars_GTM = country_vars1 %>% 
  filter(country=="GTM" & year>=2006 & year<=2014) %>% 
  mutate(gini=na.approx(gini))

#NIC
country_vars_NIC = country_vars1 %>% 
  filter(country=="NIC" & year>=2009 & year<=2014) %>% 
  mutate(gini=na.approx(gini))

#VEN
country_vars_VEN = country_vars1 %>% 
  filter(country=="VEN" & year<=2014)

#Rbind
country_vars_else = country_vars1 %>% 
  filter(country!="GTM") %>% 
  filter(country!="NIC") %>% 
  filter(country!="VEN") 


country_vars = as.data.frame(rbind(country_vars_else, country_vars_GTM, country_vars_NIC, country_vars_VEN)) %>%
  rename(country_wave = id) %>% 
  mutate(year = as.numeric(year)) %>% 
  arrange(country)

rm(list=setdiff(ls(), c("lapop", "country_vars", "lapop_original", "country_vars_original", "gini", "gdp")))

#Waves
country_vars_waves = filter(country_vars, year==2008 | year==2010 | year==2012 | year==2014 | year==2016 | year==2018)

#Means
country_var_means = aggregate(country_vars_waves[, 2:3], list(country_vars_waves$country), mean)
colnames(country_var_means) = c("country", "gini_mean", "gdp_mean")
country_vars_waves <- merge(country_vars_waves, country_var_means, by="country", all.x = TRUE, all.y = FALSE)

#Differences
country_vars_waves$gini_dif = country_vars_waves$gini - country_vars_waves$gini_mean
country_vars_waves$gdp_dif = country_vars_waves$gdp - country_vars_waves$gdp_mean

#Welfare state
country_vars_waves = country_vars_waves %>% 
  mutate(welfare = ifelse(country == "BRA" | country == "CRI" | country == "PAN" | country == "MEX" | country == "URY", "Proteccionista", NA)) %>% 
  mutate(welfare = ifelse(country == "ARG" | country == "CHL", "Productivista", welfare)) %>% 
  mutate(welfare = ifelse(country == "ECU" | country == "SLV" | country == "GTM" | country == "COL" | country == "VEN" | country == "PER" | country == "DOM" | country == "HND" | country == "NIC" | country == "BOL" | country == "PRY", "Informal familiar", welfare))

#Limpieza
#rm(list=setdiff(ls(), c("lapop", "country_vars_waves", "lapop_original", "country_vars")))
