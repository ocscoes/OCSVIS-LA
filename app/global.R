


rm(list=ls())


# Cargar bases LAPOP ------------------------------------------------------

load("../input/data/proc/lapop_ind_2004to2018.RData")              # transversal
load("../input/data/proc/lapop_count_2004to2018.RData")            # longitudinal 
load("../input/data/proc/lapop_count_2004to2018_long-wave.RData")  # longitudinal para bivariado
fraseo<- xlsx::read.xlsx(file = "../input/data/original/fraseo_preguntas.xlsx",sheetIndex = 1,encoding = "UTF-8")

logo_file <- "../app/www/images/ocs.png"
url_ocs   <- "https://ocs-coes.netlify.app/"

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


var_labelcor <- list(
  `Cohesión Social`=
list("Confianza Interpersonal"                                                     = "it1",
     "Participar en Protesta (% Sí ha participado)"                                = "prot3",
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
     "Voto en Últimas Elecciones Presidenciales (% Sí votó)"                       = "vb2"),
`Macroeconómicos`=
list("Índice de Gini"                                                              = "gini",
     "Producto Interno Bruto"                                                      = "gdp")
)
