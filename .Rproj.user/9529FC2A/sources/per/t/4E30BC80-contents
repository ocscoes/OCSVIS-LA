{
  library(shiny)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(dplyr)
  library(sjPlot)
  library(sjlabelled)
  library(ggplot2)
  library(knitr)
  library(plotly)
  library(stringr)
  library(ggthemes)
  library(ggrepel)
  library(extrafont)
  }

rm(list=ls())


# Cargar bases LAPOP ------------------------------------------------------

load("data/lapop_aggr_v2.RData") # Guardar bases con labels
load("data/lapop_ind_v2.RData") # Guardar bases con labels


# Determinar etiquetas para variable input --------------------------------

var_label <- c(
  "Confianza Interpersonal"                                                     = "it1",
  "Participar en Protesta"                                                      = "prot3",
  "Confianza en Eficacia Sistema Judicial"                                      = "aoj12",
  "Respeto por las Instituciones"                                               = "b2",
  "Grado de Acuerdo: Derechos Básicos Están Protegidos por el Sistema Político" = "b3",
  "Orgullo con el Sistema Político"                                             = "b4",
  "Confianza en Sistema Judicial"                                               = "b10a",
  "Confianza en Fuerzas Armadas"                                                = "b12",
  "Confianza en Iglesia Católica"                                               = "b20",
  "Confianza en Iglesias Evangélicas/Protestantes"                              = "b20a",
  "Confianza en Partidos Políticos"                                             = "b21",
  "Confianza en Ejecutivo"                                                      = "b21a",
  "Evaluación del Desempeño del Gobierno Combatiendo Corrupción"                = "n9",
  "Evaluación del Desempeño del Gobierno en Seguridad Ciudadana"                = "n11",
  "Evaluación del Desempeño del Gobierno Manejando Economía"                    = "n15",
  "Respeto por la Propiedad Privada"                                            = "pr4",
  "Gobierno debe Implementar Políticas para Reducir Desigualdadad de Ingresos"  = "ros4",
  "Democracia es Mejor que otras Formas de Gobierno"                            = "ing4",
  "Gobernantes están Interesados en lo que la Gente Piensa"                     = "eff1",
  "Satisfacción con la Democracia"                                              = "pn4",
  "Percepción de Corrupción Pública"                                            = "exc7",
  "Interés en Política"                                                         = "pol1",
  "Voto en Últimas Elecciones Presidenciales"                                   = "vb2"
)




# view_df(lapop, file = "lapop.xls")

# Solamente lapop agregada ------------------------------------------------

# ggplot() + 
#   geom_point(data = lapop,aes(x = year,y = it1,color=pais,group=pais)) +
#   geom_line(data  = lapop,aes(x = year,y = it1,color=pais,group=pais))
 


# Solamente lapop promedio por año ----------------------------------------

# ggplot() + 
#   stat_summary(data = lapop,aes(y = it1,x = year,group = 1), fun.y=mean, colour="red", geom="line", size = 3)


# Nivel pais y general ----------------------------------------------------

# ggplot() + 
#   geom_point(data = lapop,aes(x = year,y = it1,color=pais,group=pais)) +
#   geom_line(data  = lapop,aes(x = year,y = it1,color=pais,group=pais)) + 
#   stat_summary(data = lapop,aes(y = it1,x = year,group = 1), fun.y=mean, colour="red", geom="line", size = 3)+
#   stat_summary(data = lapop,aes(y = it1,x = year,group = 1), fun.y=mean, colour="blue", geom="point", size = 3)




















