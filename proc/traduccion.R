rm(list=ls())

library(dplyr)

load(file = "data/base_shiny_indicadores.rdata")

paises <- unique(df_indicadores$País)

# Vector original
paises_ingles <- c("Argentina", "Bahamas", "Belize", "Bolivia", "Brazil", "Canada",
                   "Chile", "Colombia", "Costa Rica", "Dominican Republic", "Ecuador",
                   "El Salvador", "Grenada", "Guatemala", "Guyana", "Haiti", "Honduras",
                   "Jamaica", "Mexico", "Nicaragua", "Panama", "Paraguay", "Peru",
                   "Puerto Rico", "Suriname", "Trinidad & Tobago", "United States",
                   "Uruguay", "Venezuela", "Promedio")

# Diccionario de traducción
spa <- c(
  "Argentina" = "Argentina",
  "Bahamas" = "Bahamas",
  "Belize" = "Belice",
  "Bolivia" = "Bolivia",
  "Brazil" = "Brasil",
  "Canada" = "Canadá",
  "Chile" = "Chile",
  "Colombia" = "Colombia",
  "Costa Rica" = "Costa Rica",
  "Dominican Republic" = "República Dominicana",
  "Ecuador" = "Ecuador",
  "El Salvador" = "El Salvador",
  "Grenada" = "Granada",
  "Guatemala" = "Guatemala",
  "Guyana" = "Guyana",
  "Haiti" = "Haití",
  "Honduras" = "Honduras",
  "Jamaica" = "Jamaica",
  "Mexico" = "México",
  "Nicaragua" = "Nicaragua",
  "Panama" = "Panamá",
  "Paraguay" = "Paraguay",
  "Peru" = "Perú",
  "Puerto Rico" = "Puerto Rico",
  "Suriname" = "Surinam",
  "Trinidad & Tobago" = "Trinidad y Tobago",
  "United States" = "Estados Unidos",
  "Uruguay" = "Uruguay",
  "Venezuela" = "Venezuela",
  "Promedio" = "Promedio"
)

# Traducción
paises_espanol <- traducciones[paises_ingles]

# Resultado
print(paises_espanol)


library(dplyr)


df_indicadores <- df_indicadores %>%
  mutate(País = recode(País, !!!spa))

unique(df_indicadores$País)

save(df_indicadores, file="data/base_shiny_indicadores.rdata")
