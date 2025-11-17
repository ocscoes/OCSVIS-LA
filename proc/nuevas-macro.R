rm(list=ls())

library(tidyverse)

load("data/datos-completos.rdata")
load("data/base_shiny_completa.rdata")

subset <- datos_wide |>
  dplyr::select(1:2,
         13:18) |>
  rename("Gobernanza (WGI)" =  wgi) |>
  pivot_longer(
    cols = c("Gini index",
             "PIB per cápita (PPA)",
             "(Log) PIB per cápita (PPA)",
             "% pob. migrante",
             "Indice V-Dem",
             "Gobernanza (WGI)"),
    names_to = "Variable",
    values_to = "Valor"
  ) |>
  rename(Ola=ola,
         País=pais)

df <- df |> filter(Variable != "Gini index" & Variable!="PIB per cápita (nominal)")

df <- bind_rows(df, subset)

save(df, file= "data/base_shiny_completa_b.rdata")  
