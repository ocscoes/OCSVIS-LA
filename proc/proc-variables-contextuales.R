library(tidyverse)


load("data/variables_macro.RData")
load(file = "data/base_shiny_otros.rdata")

df <- df |> filter(País!="Puerto Rico")

agnos_ordenados <- sort(unique(var_macro$año))

resumen <- var_macro %>%
  filter(!is.na(valor)) %>%
  distinct(id_pais, año, indicador) %>%
  mutate(disponible = TRUE) %>%
  pivot_wider(names_from = año, values_from = disponible, values_fill = FALSE)


resumen <- resumen %>%
  select(id_pais, indicador, all_of(as.character(agnos_ordenados)))

#####################


# Asegurarse de que Anio sea numérico
var_macro <- var_macro %>%
  mutate(año = as.integer(año))

# Expandir la tabla para completar años faltantes dentro del rango de cada grupo
datos <- var_macro %>%
  complete(id_pais, indicador, año = full_seq(año, 1))  # incluye años intermedios faltantes

# Imputación con lógica extendida
datos_imputados <- datos %>%
  group_by(id_pais, indicador) %>%
  arrange(año) %>%
  mutate(
    valor = if_else(
      is.na(valor),
      case_when(
        !is.na(lag(valor)) & !is.na(lead(valor)) ~ (lag(valor) + lead(valor)) / 2,
        !is.na(lag(valor)) ~ lag(valor),
        !is.na(lead(valor)) ~ lead(valor),
        TRUE ~ NA_real_
      ),
      valor  # si ya tiene valor, se mantiene
    )
  ) %>%
  ungroup()

# Filtrar por olas en la base de datos
olas <- unique(df$Ola)

datos_imputados <- datos_imputados |>
  filter(año %in% olas)

# Recodificar nombre de paises

codigos <- unique(var_macro$id_pais)
nombres <- unique(df$País)

recod <- setNames(nombres, codigos)

datos_imputados <- datos_imputados |>
  mutate(País= recod[id_pais],
         Variable= case_when(
           indicador == "Desempleo, total (% de la fuerza laboral total) (estimación modelada de la OIT)" ~ "Desempleo",
           indicador == "Homicidios intencionales (por cada 100.000 habitantes)" ~ "Homicidios intencionales",
           indicador == "PIB per cápita (US$ a precios actuales)" ~ "PIB per cápita (nominal)",
           .default = indicador)) |>
  select(Ola=año,
         País,
         Variable,
         Valor=valor)

# Bind

df <- rbind(df, datos_imputados)

save(df, file="data/base_shiny_completa.rdata")
