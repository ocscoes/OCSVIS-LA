
# Recodificacion Variables ------------------------------------------------
    # Julio Cesar Iturra Sanhueza - julioiturrasanhueza@gmail.com
    # 22 mayo 2019


{
library(dplyr)
library(sjPlot)
library(knitr)
library(sjlabelled)
library(here)
  }

rm(list=ls())

# Cargar bases LAPOP ------------------------------------------------------

load(file = "data/lapop_aggr.RData") # Base de datos longitudinal
load(file = "data/lapop_ind.RData") # Base de datos individual



lapop_ind1 <- lapop_ind %>% select(year,pais,it1,prot3,aoj12,b2,b3,b4,b10a,b12,b20,
                                  b20a,b21,b21a,n9,n11,n15,pr4,ros4,ing4,eff1,pn4,
                                  exc7,pol1,vb2) %>% data.frame()

view_df(lapop_ind1,show.id = TRUE,show.type = TRUE)
lab1<- get_labels(lapop_ind1)


# for (i in 2:25) {
#   lapop_ind1[,i]<- as.numeric(unlist(lapop_ind1[,i]))
# }

for (i in 2:25) {
  lapop_ind1[,i]<- as_factor(unlist(lapop_ind1[,i]))
}


levels1 = c(1,2,3,4,5,6,7)
labels1 = c("Nada","2","3","4","5","6","Mucho")

for (i in 6:18) {
  lapop_ind1[,i]<- factor(unlist(lapop_ind1[,i]),
                          levels = levels1,
                          labels = labels1)
}

levels2 = c(1,2,3,4,5,6,7)
labels2 = c("Muy en \n Desacuerdo","2","3","4","5","6","Muy de \n acuerdo")


for (i in 19:21) {
  lapop_ind1[,i]<- factor(unlist(lapop_ind1[,i]),
                          levels = levels2,
                          labels = labels2)
}

lapop_ind1$it1 <- factor(x = lapop_ind1$it1, 
                         levels = c(1:4), 
                         labels = c("Muy \n confiable", "Algo \n confiable", "Poco \n confiable", "Nada \n confiable"))




lapop_ind1$pn4 <- factor(x = lapop_ind1$pn4, 
                         levels = c(1:4), 
                         labels = c("Muy \n satisfecho","Satisfecho","Insatisfecho","Muy \n insatisfecho"))




for (i in c(5,24)){
  lapop_ind1[,i]<- factor(unlist(lapop_ind1[,i]),
                          levels = c(1:4),
                          labels = c("Mucho","Algo","Poco","Nada"))
}

lapop_ind1$vb2 <- car::recode(lapop_ind1$vb2,"1=1;2=0",as.factor = TRUE)
lapop_ind1$prot3 <- car::recode(lapop_ind1$prot3,"1=1;2=0",as.factor = TRUE)

# prop.table(table(lapop_ind1$vb2))

lapop_ind1$vb2 <- factor(x = lapop_ind1$vb2 , 
                         levels = c(1:0), 
                         labels = c("Sí votó","No votó"))

lapop_ind1$prot3 <- factor(x = lapop_ind1$prot3 , 
                         levels = c(1:0), 
                         labels = c("Sí","No"))

lapop_ind1$exc7 <- factor(x = lapop_ind1$exc7 , 
                           levels = c(1:4), 
                           labels = c("Muy \n generalizada","Algo \n generalizada","Poco \n generalizada","Nada \ngeneralizada" ))




view_df(lapop_ind1,show.id = TRUE, show.type = TRUE, encoding = "UTF-8", show.prc = TRUE)

# 1. Etiquetas para paises ------------------------------------------------


# Nivel agregado ----------------------------------------------------------
length(table(lapop$pais))
levels_pais <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,21,22,23,24,25,26,40,41)
labels_pais <- c("Mexico","Guatemala","El Salvador","Honduras","Nicaragua",
                 "Costa Rica","Panama","Colombia","Ecuador","Bolivia","Peru",
                 "Paraguay","Chile","Uruguay","Brasil","Venezuela","Argentina",
                 "Republica Dominicana","Haiti","Jamaica","Guyana","Trinidad y Tobago",
                 "Belice","Estados Unidos","Canada")

lapop$pais <- factor(lapop$pais,
                     levels = levels_pais, 
                     labels = labels_pais)


# Nivel Individual --------------------------------------------------------

length(table(lapop_ind1$pais))
lapop_ind1$pais <- factor(lapop_ind1$pais,
                     levels = levels_pais, 
                     labels = labels_pais)
table(lapop_ind1$pais)


# 2. Años -----------------------------------------------------------------

# Nivel agregado ----------------------------------------------------------

length(table(lapop$year))
table(lapop$year)

lapop$year <- factor(lapop$year,ordered = TRUE)
class(lapop$year)

# Nivel Individual --------------------------------------------------------

length(table(lapop_ind1$year))
table(lapop_ind$year)

lapop_ind1$year <- factor(lapop_ind1$year,ordered = TRUE)
class(lapop_ind1$year)



# Arreglar medidas agregadas por pais-agno -------------------------------------------------


summary(lapop$prot3)
lapop$prot3 <- (1-(lapop$prot3-1))

summary(lapop$vb2)
lapop$vb2   <- (1-(lapop$vb2-1))



# Agregar variable label -------------------------------------------

set_label(lapop$year)<- "Año"
set_label(lapop$pais)<- "Pais"
set_label(lapop$it1 )<- "Confianza Interpersonal"
set_label(lapop$prot3)<- "Participar en Protesta"
set_label(lapop$aoj12)<- "Confianza en Eficacia Sistema Judicial"
set_label(lapop$b2  )<- "Respeto por las Instituciones"
set_label(lapop$b3  )<- "Grado de Acuerdo: Derechos Básicos Están Protegidos por el Sistema  Político"
set_label(lapop$b4  )<- "Orgullo con el Sistema Político"
set_label(lapop$b10a)<- "Confianza en Sistema Judicial"
set_label(lapop$b12 )<- "Confianza en Fuerzas Armadas"
set_label(lapop$b20 )<- "Confianza en Iglesia Católica"
set_label(lapop$b20a)<- "Confianza en Iglesias Evangélicas/Protestantes"
set_label(lapop$b21 )<- "Confianza en Partidos Políticos"
set_label(lapop$b21a)<- "Confianza en Ejecutivo"
set_label(lapop$n9  )<- "Evaluación del Desempeño del Gobierno Combatiendo Corrupción"
set_label(lapop$n11 )<- "Evaluación del Desempeño del Gobierno en Seguridad Ciudadana"
set_label(lapop$n15 )<- "Evaluación del Desempeño del Gobierno Manejando Economía"
set_label(lapop$pr4 )<- "Respeto por la Propiedad Privada"
set_label(lapop$ros4)<- "Gobierno debe Implementar Políticas para Reducir Desigualdadad de Ingresos"
set_label(lapop$ing4)<- "Democracia es Mejor que otras Formas de Gobierno"
set_label(lapop$eff1)<- "Gobernantes están Interesados en lo que la Gente Piensa"
set_label(lapop$pn4 )<- "Satisfacción con la Democracia"
set_label(lapop$exc7)<- "Percepción de Corrupción Pública"
set_label(lapop$pol1)<- "Interés en Política"
set_label(lapop$vb2 )<- "Voto en Últimas Elecciones Presidenciales"

get_label(lapop)

sjlabelled::set_label(lapop_ind1$year  )<- "Año"
sjlabelled::set_label(lapop_ind1$pais  )<- "Pais"
sjlabelled::set_label(lapop_ind1$it1   )<- "Confianza Interpersonal"
sjlabelled::set_label(lapop_ind1$prot3 )<- "Participar en Protesta"
sjlabelled::set_label(lapop_ind1$aoj12 )<- "Confianza en Eficacia Sistema Judicial"
sjlabelled::set_label(lapop_ind1$b2    )<- "Respeto por las Instituciones"
sjlabelled::set_label(lapop_ind1$b3    )<- "Grado de Acuerdo: Derechos Básicos Están Protegidos por el Sistema  Político"
sjlabelled::set_label(lapop_ind1$b4    )<- "Orgullo con el Sistema Político"
sjlabelled::set_label(lapop_ind1$b10a  )<- "Confianza en Sistema Judicial"
sjlabelled::set_label(lapop_ind1$b12   )<- "Confianza en Fuerzas Armadas"
sjlabelled::set_label(lapop_ind1$b20   )<- "Confianza en Iglesia Católica"
sjlabelled::set_label(lapop_ind1$b20a  )<- "Confianza en Iglesias Evangélicas/Protestantes"
sjlabelled::set_label(lapop_ind1$b21   )<- "Confianza en Partidos Políticos"
sjlabelled::set_label(lapop_ind1$b21a  )<- "Confianza en Ejecutivo"
sjlabelled::set_label(lapop_ind1$n9    )<- "Evaluación del Desempeño del Gobierno Combatiendo Corrupción"
sjlabelled::set_label(lapop_ind1$n11   )<- "Evaluación del Desempeño del Gobierno en Seguridad Ciudadana"
sjlabelled::set_label(lapop_ind1$n15   )<- "Evaluación del Desempeño del Gobierno Manejando Economía"
sjlabelled::set_label(lapop_ind1$pr4   )<- "Respeto por la Propiedad Privada"
sjlabelled::set_label(lapop_ind1$ros4  )<- "Gobierno debe Implementar Políticas para Reducir Desigualdadad de Ingresos"
sjlabelled::set_label(lapop_ind1$ing4  )<- "Democracia es Mejor que otras Formas de Gobierno"
sjlabelled::set_label(lapop_ind1$eff1  )<- "Gobernantes están Interesados en lo que la Gente Piensa"
sjlabelled::set_label(lapop_ind1$pn4   )<- "Satisfacción con la Democracia"
sjlabelled::set_label(lapop_ind1$exc7  )<- "Percepción de Corrupción Pública"
sjlabelled::set_label(lapop_ind1$pol1  )<- "Interés en Política"
sjlabelled::set_label(lapop_ind1$vb2   )<- "Voto en Últimas Elecciones Presidenciales"


get_label(lapop_ind1)

# N paises segun año ------------------------------------------------------

sjt.xtab(var.row = lapop$pais,
         var.col = lapop$year)
 
# Ver base de datos -------------------------------------------------------

lapop <- lapop %>% mutate(pais_year=paste(pais,year))

lapop <- lapop %>% mutate(promedio=paste("Promedio anual"))

sjPlot::view_df(lapop, 
                show.type = TRUE,
                show.frq = TRUE,
                show.labels = TRUE,
                show.prc = T, max.len = 1000,show.values = FALSE)

sjPlot::view_df(lapop_ind1, 
                show.type = TRUE,
                show.frq = TRUE,
                show.labels = TRUE,
                show.prc = T, max.len = 100,show.values = FALSE)




# save(lapop,file = "data/lapop_aggr_v2.RData")# Guardar bases con labels
load("data/lapop_aggr_v2.RData")




# save(lapop_ind1,file = "data/lapop_ind_v2.RData")
load(file = "data/lapop_ind_v2.RData")

str(lapop_ind1)
data.table::data.table("lab1"=Hmisc::label(lapop_ind1))
data.table::data.table("lab1"=Hmisc::label(lapop))



