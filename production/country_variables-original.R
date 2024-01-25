library(pacman)
#remotes::install_github("nset-ornl/wbstats")

p_load(dplyr, tidyverse, wbstats, zoo)

# Country Level variables 

paises<- c("ARG", # Argentina
           "BOL", # Bolivia
           "BLZ", # Belize
           "BRA", # Brazil
           "CAN", # Canada
           "CHL", # Chile
           "COL", # Colombia
           "CRI", # Costa Rica
           "DOM", # Rep. Dominicana
           "ECU", # Ecuador
           "SLV", # Salvador
           "GTM", # Guatemala
           "GUY", # Guyana
           "HTI", # Haiti
           "HND", # Honduras
           "JAM", # Jamaica
           "MEX", # México
           "NIC", # Nicaragua
           "PAN", # Panamá
           "PRY", # Paraguay
           "PER", # Perú
           'TTO', # Trinidad y Tobago
           'USA', # Unites States
           "URY", # Uruguay
           "VEN"  # Venezuela
)

paises<- c("Argentina"          = "ARG",
           "Bolivia"            = "BOL",
           "Belize"             = "BLZ",
           "Brazil"             = "BRA",
           "Canada"             = "CAN",
           "Chile"              = "CHL",
           "Colombia"           = "COL",
           "Costa Rica"         = "CRI",
           "Dominican Republic" = "DOM",
           "Ecuador"            = "ECU",
           "El Salvador"        = "SLV",
           "Guatemala"          = "GTM",
           "Guyana"             = "GUY",
           "Haiti"              = "HTI",
           "Honduras"           = "HND",
           "Jamaica"            = "JAM",
           "Mexico"             = "MEX",
           "Nicaragua"          = "NIC",
           "Panama"             = "PAN",
           "Paraguay"           = "PRY",
           "Peru"               = "PER",
           "Trinidad & Tobago"  = 'TTO',
           "United States"      = 'USA',
           "Uruguay"            = "URY",
           "Venezuela"          = "VEN"
           )

get_country_data <- function(countries,
                             indicators = c("SI.POV.GINI", # Gini index.
                                            "NY.GDP.PCAP.KD"), # GDP per capita (constant 2015 US$).
                             since = 2003,
                             until = 2022,
                             rmNA=FALSE,
                             wide=TRUE,
                             kdollars_gdp=TRUE,
                             simplify=TRUE,
                             impute=TRUE){
  
  # Obtención datos
  data_wd <- wb(indicator = indicators,
                country = countries,
                startdate = since,
                enddate = until,
                removeNA=rmNA,
                return_wide=wide)
  # Creación ID
  data_wd$id <- paste0(data_wd$iso3c,"_",data_wd$date)
  
  # GDP en miles
  if(kdollars_gdp & 'NY.GDP.PCAP.KD' %in% indicators){
    data_wd$NY.GDP.PCAP.KD <- data_wd$NY.GDP.PCAP.KD/1000
  }

  # Imputación-----
  if(impute == TRUE){
    data_wd <- data_wd %>% arrange(country, date)
    data_wd$imputated<- FALSE
    for(i in 1:nrow(data_wd)) {
      if(is.na(data_wd$SI.POV.GINI[i])) {
        # Encuentra el valor más reciente que no sea NA hasta dos años atrás
        patch<- data_wd %>% filter(country == data_wd$country[i]) %>%
                            filter(date < data_wd$date[i],
                                   date >= as.numeric(data_wd$date[i])-1,
                                   !is.na(SI.POV.GINI),
                                   imputated == FALSE) %>%+
                                   tail(1)
        if(!nrow(patch)==0){
          
          # Imputar el valor
          data_wd$SI.POV.GINI[i] <- patch$SI.POV.GINI[1]
          data_wd$imputated[i]<- TRUE
          # Imprimir la imputación
          print(paste0("Para el GINI de ",data_wd$country[i]," ", data_wd$date[i],
                      " se imputó el valor del año ", patch$date[1],
                      " (",patch$SI.POV.GINI[1],")"))  
        }
        
      }
    }
  }

  # Formato simplificado-----
  if(simplify == TRUE){
    data_wd <- data_wd[c("id","SI.POV.GINI","NY.GDP.PCAP.KD","iso3c","date")] %>%
      setNames(c("id","gini","gdp","country","date"))
  }
  return(data_wd)
}

country_vars<-get_country_data(paises,simplify = TRUE) # Alerta de función spread() deprecated.
                               # Origen de la alerta: función wb().
country_vars$pais <- NA
for(i in 1:nrow(country_vars)){
  country_vars$pais[i] <- names(paises)[paises==country_vars$country[i]]
}

save(country_vars, file="country_vars.rdata")

# #GINI
# for (i in 1:length(paises)) {
#   name<-paste0("gini_", paises[i])
#   pais<- paste0(paises[i])
#   assign(name, wb(indicator = "SI.POV.GINI", country = pais, startdate = 2005, enddate = 2019))
# }
# 
# gini<- rbind(gini_ARG,
#              gini_BOL,
#              gini_BRA,
#              gini_CHL,
#              gini_COL,
#              gini_CRI,
#              gini_DOM,
#              gini_ECU,
#              gini_GTM,
#              gini_HND,
#              gini_MEX,
#              gini_NIC,
#              gini_PAN,
#              gini_PER,
#              gini_PRY,
#              gini_SLV,
#              gini_URY,
#              gini_VEN)
# 
# gini$id<- NA
# gini$id<- paste0(gini$iso3c,"_",gini$date)
# gini<- gini[,c(8,1,2,3,4,5,6,7)]
# gini<- gini[,c(1,4)]
# names(gini)[2]<- "gini"
# 
# 
# #GDP
# for (i in 1:length(paises)) {
#   name<-paste0("gdp_", paises[i])
#   pais<- paste0(paises[i])
#   assign(name, wb(indicator = "NY.GDP.PCAP.KD", country = pais, startdate = 2005, enddate = 2019))
# }
# 
# gdp<- rbind(gdp_ARG,
#             gdp_BOL,
#             gdp_BRA,
#             gdp_CHL,
#             gdp_COL,
#             gdp_CRI,
#             gdp_DOM,
#             gdp_ECU,
#             gdp_GTM,
#             gdp_HND,
#             gdp_MEX,
#             gdp_NIC,
#             gdp_PAN,
#             gdp_PER,
#             gdp_PRY,
#             gdp_SLV,
#             gdp_URY,
#             gdp_VEN)
# 
# 
# gdp$id<- NA
# gdp$id<- paste0(gdp$iso3c,"_",gdp$date)
# gdp<- gdp[,c(8,1,2,3,4,5,6,7)]
# gdp<- gdp[,c(1,2,3,4)]
# names(gdp)[2]<- "gdp"
# 
# #Miles de dolares
# gdp$gdp = (gdp$gdp)/1000
# 
# 
# 
# # Imputations
# 
# 
# 
# #Fusion databases
# 
# country_vars <- merge(gini, gdp, by="id", all=T)
# 
# #Reasignación de datos en missings
# country_vars$gini[country_vars$id=="ARG_2018"] <- country_vars$gini[country_vars$id=="ARG_2017"]
# country_vars$gini[country_vars$id=="BOL_2010"] <- country_vars$gini[country_vars$id=="BOL_2009"]
# country_vars$gini[country_vars$id=="BOL_2018"] <- country_vars$gini[country_vars$id=="BOL_2017"]
# country_vars$gini[country_vars$id=="BRA_2010"] <- country_vars$gini[country_vars$id=="BRA_2009"]
# country_vars$gini[country_vars$id=="BRA_2018"] <- country_vars$gini[country_vars$id=="BRA_2017"]
# country_vars$gini[country_vars$id=="CHL_2008"] <- country_vars$gini[country_vars$id=="CHL_2009"]
# country_vars$gini[country_vars$id=="CHL_2010"] <- country_vars$gini[country_vars$id=="CHL_2009"]
# country_vars$gini[country_vars$id=="CHL_2012"] <- country_vars$gini[country_vars$id=="CHL_2011"]
# country_vars$gini[country_vars$id=="CHL_2014"] <- country_vars$gini[country_vars$id=="CHL_2013"]
# country_vars$gini[country_vars$id=="CHL_2016"] <- country_vars$gini[country_vars$id=="CHL_2015"]
# country_vars$gini[country_vars$id=="CHL_2018"] <- country_vars$gini[country_vars$id=="CHL_2017"]
# country_vars$gini[country_vars$id=="COL_2018"] <- country_vars$gini[country_vars$id=="COL_2017"]
# country_vars$gini[country_vars$id=="CRI_2018"] <- country_vars$gini[country_vars$id=="CRI_2017"]
# country_vars$gini[country_vars$id=="DOM_2018"] <- country_vars$gini[country_vars$id=="DOM_2016"] #DOM_2018
# country_vars$gini[country_vars$id=="ECU_2018"] <- country_vars$gini[country_vars$id=="ECU_2017"]
# country_vars$gini[country_vars$id=="HND_2018"] <- country_vars$gini[country_vars$id=="HND_2017"]
# country_vars$gini[country_vars$id=="MEX_2018"] <- country_vars$gini[country_vars$id=="MEX_2016"] #MEX_2018
# country_vars$gini[country_vars$id=="PAN_2018"] <- country_vars$gini[country_vars$id=="PAN_2017"]
# country_vars$gini[country_vars$id=="PER_2018"] <- country_vars$gini[country_vars$id=="PER_2017"]
# country_vars$gini[country_vars$id=="PRY_2018"] <- country_vars$gini[country_vars$id=="PRY_2017"]
# country_vars$gini[country_vars$id=="SLV_2018"] <- country_vars$gini[country_vars$id=="SLV_2017"]
# country_vars$gini[country_vars$id=="URY_2018"] <- country_vars$gini[country_vars$id=="URY_2017"]

# Gini data from CEPAL
# Source: https://statistics.cepal.org/portal/databank/index.html?lang=es&indicator_id=3289 (May, 2023)
load("../input/data/original/cepal_gini.Rdata")

# Venezuela
venezuela <- cepal_gini[str_detect(cepal_gini$País__ESTANDAR,"Ven"),] %>%
  mutate(País__ESTANDAR = "VEN") %>%
  mutate(id = paste0(País__ESTANDAR,"_",Años__ESTANDAR), value = value *100) %>%
  select(id, value,Años__ESTANDAR) %>% setNames(c("id","gini","date")) %>%
  filter(date >= 2003)%>% add_column(gdp = NA, .after = "gini") %>%
  add_column(country = "VEN", .after = "gdp")

country_vars <- country_vars %>% filter(country != "VEN") %>% rbind(venezuela)
rm(venezuela)

for(i in c("GTM_2007","GTM2015","NIC_2006","NIC_2010","NIC_2015")){
  country_vars$gini[country_vars$id==i] <- NA
}

# Interpolación lineal: NIC
country_vars$gini[country_vars$country=="NIC" & country_vars$date<2016] <- na.approx(
  country_vars[country_vars$country=="NIC",]$gini, na.rm = TRUE)

# Interpolación lineal: GTM
country_vars$gini[country_vars$country=="GTM"] <- na.approx(country_vars[country_vars$country=="GTM",]$gini, na.rm = TRUE)

# Casos específicos
if(is.na(country_vars$gini[country_vars$id=='HND_2021'])){
  country_vars$gini[country_vars$id == 'HND_2021'] <- country_vars$gini[country_vars$id=='HND_2020']
  print("Valor Gini para Honduras 2021 imputado según 2020.")
}

if(is.na(country_vars$gini[country_vars$id=='CHL_2008'])){
  country_vars$gini[country_vars$id=="CHL_2008"] <- country_vars$gini[country_vars$id=="CHL_2009"]
  print("Valor Gini para Chile 2008 imputado según 2009.")
}
# #ECLAC
# country_vars$gini[country_vars$id=="GTM_2006"] <- 55.8
# country_vars$gini[country_vars$id=="GTM_2014"] <- 53.5
# country_vars$gini[country_vars$id=="NIC_2009"] <- 46.3
# country_vars$gini[country_vars$id=="NIC_2014"] <- 49.5
 # country_vars$gini[country_vars$id=="VEN_2008"] <- 37.9
 # country_vars$gini[country_vars$id=="VEN_2010"] <- 36.4
 # country_vars$gini[country_vars$id=="VEN_2012"] <- 38.4
 # country_vars$gini[country_vars$id=="VEN_2014"] <- 37.8
# 
# #Linear interpolation
# country_vars$country_wave1 = country_vars$id
# 
# country_vars1 = country_vars %>% 
#   separate(country_wave1, c("country", "year"))
# 
# #GTM
# country_vars_GTM = country_vars1 %>% 
#   filter(country=="GTM" & year>=2006 & year<=2014) %>% 
#   mutate(gini=na.approx(gini))
# 
# #NIC
# country_vars_NIC = country_vars1 %>% 
#   filter(country=="NIC" & year>=2009 & year<=2014) %>% 
#   mutate(gini=na.approx(gini))
# 
# #VEN
# country_vars_VEN = country_vars1 %>% 
#   filter(country=="VEN" & year<=2014)
# 
# #Rbind
# country_vars_else = country_vars1 %>% 
#   filter(country!="GTM") %>% 
#   filter(country!="NIC") %>% 
#   filter(country!="VEN") 

country_vars <- country_vars%>% rename(country_wave = id, year = date) %>%
  mutate(year = as.numeric(year))

# country_vars = as.data.frame(rbind(country_vars_else, country_vars_GTM, country_vars_NIC, country_vars_VEN)) %>%
#   rename(country_wave = id) %>% 
#   mutate(year = as.numeric(year)) %>% 
#   arrange(country)
# 
# rm(list=setdiff(ls(), c("lapop", "country_vars", "lapop_original", "country_vars_original", "gini", "gdp")))

#Waves
country_vars_waves <- filter(country_vars, year %in%
                               c(2008,2010,2012,2014,2016,2018,2021))

#Means
country_vars_waves = aggregate(country_vars_waves[, 2:3], list(country_vars_waves$country), mean) %>%
                    setNames(c("country", "gini_mean", "gdp_mean")) %>%
                    merge(country_vars_waves, ., by="country", all.x = TRUE, all.y = FALSE)


#Differences
country_vars_waves$gini_dif = country_vars_waves$gini - country_vars_waves$gini_mean
country_vars_waves$gdp_dif = country_vars_waves$gdp - country_vars_waves$gdp_mean

#,Welfare state
country_vars_waves <- country_vars_waves %>% 
  mutate(welfare = ifelse(country %in% c("BRA","CRI","PAN","MEX","URY"), "Proteccionista", NA)) %>% 
  mutate(welfare = ifelse(country %in% c("ARG","CHL"), "Productivista", welfare)) %>% 
  mutate(welfare = ifelse(country %in% c("ECU","SLV","GTM","COL","VEN","PER","DOM","HND","NIC","BOL","PRY"), "Informal familiar", welfare))

#Limpieza
#rm(list=setdiff(ls(), c("lapop", "country_vars_waves", "lapop_original", "country_vars")))
