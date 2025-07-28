library(pacman)
p_load(tidyverse,
       janitor,
       plotly,
       ggimage)

load(file = "data/base_shiny_completa.rdata")

df_bivariado <- df %>% filter(País!="Bahamas" & País !="Grenada" & País != "Suriname",
                              País !="Canada" & 
                                País!= "United States",
                              !is.nan(Valor))

df_bivariado <- clean_names(df_bivariado)


datos_wide <- df_bivariado %>%
  filter(variable=="Cohesión vertical" | variable== "Cohesión horizontal" |
           variable=="PIB per cápita (nominal)" | variable=="Gini index") |>
  pivot_wider(
    names_from = variable,
    values_from = valor
  ) |>
  clean_names()

# datos_wide %>% group_by(ola) |> 
#   summarise(mean_h = mean(cohesion_horizontal, na.rm=T),
#             mean_v = mean(cohesion_vertical, na.rm=T))
# 
# datos_wide <- datos_wide |>
#   group_by(ola) |>
#   mutate(
#     mean_cv = mean(cohesion_vertical, na.rm = TRUE),
#     mean_ch = mean(cohesion_horizontal, na.rm = TRUE),
#     grupo = case_when(
#       cohesion_vertical > mean_cv & cohesion_horizontal > mean_ch ~ "Grupo 1",
#       cohesion_vertical > mean_cv & cohesion_horizontal <= mean_ch ~ "Grupo 2",
#       cohesion_vertical <= mean_cv & cohesion_horizontal > mean_ch ~ "Grupo 3",
#       cohesion_vertical <= mean_cv & cohesion_horizontal <= mean_ch ~ "Grupo 4",
#       TRUE ~ NA_character_
#     )
#   ) |>
#   ungroup()

# mean_cv <- mean(datos_wide$`cohesion_vertical`)
# mean_ch <- mean(datos_wide$`cohesion_horizontal`, na.rm=T)
# 
# datos_wide <- datos_wide |>
#   mutate(grupo = case_when(
#     cohesion_vertical>mean_cv & cohesion_horizontal>mean_ch ~ "Grupo 1",
#     cohesion_vertical>mean_cv & cohesion_horizontal<mean_ch ~ "Grupo 2",
#     cohesion_vertical<mean_cv & cohesion_horizontal>mean_ch ~ "Grupo 3",
#     cohesion_vertical<mean_cv & cohesion_horizontal<mean_ch ~ "Grupo 4"
#   ))


# datos_wide |>
#   group_by(grupo) |>
#   summarise(paises_ola = n()) |>
#   filter(!is.na(grupo)) |>
#   mutate(paises_ola = paises_ola / sum(paises_ola) * 100) |>
#   plot_ly(
#     x = ~grupo,
#     y = ~paises_ola,
#     type = 'bar',
#     text = ~paste0(round(paises_ola, 1), "%"),
#     textposition = 'outside',
#     marker = list(color = 'steelblue')
#   ) |>
#   layout(
#     xaxis = list(title = "Grupo"),
#     yaxis = list(title = "Porcentaje de países"),
#     uniformtext = list(minsize = 10, mode = "hide")
#   )
# 
# 
#  datos_wide |>
#    filter(ola>2004) |>
#   group_by(ola, grupo) |>
#   summarise(paises_ola = n(), .groups = "drop") |>
#   filter(!is.na(grupo)) |>
#   group_by(ola) |>
#   ungroup() |>
#     plot_ly(
#       x = ~ola,
#       y = ~paises_ola,
#       color = ~grupo,
#       type = 'scatter',
#       mode = 'lines+markers',
#       text = ~paste0("Países: ", paises_ola),
#       hoverinfo = 'text+x+color'
#     ) |>
#     layout(
#       xaxis = list(title = "Ola"),
#       yaxis = list(title = "Número de países"),
#       legend = list(title = list(text = "Grupo"))
#     )
# 
#   
#  library(dplyr)
#  library(plotly)
#  
#  datos_wide |>
#    filter(ola > 2004 & !is.na(grupo)) |>
#    group_by(ola, grupo) |>
#    summarise(paises_ola = n(), .groups = "drop") |>
#    group_by(ola) |>
#    mutate(
#      total_ola = sum(paises_ola),
#      porcentaje = 100 * paises_ola / total_ola
#    ) |>
#    ungroup() |>
#    plot_ly(
#      x = ~ola,
#      y = ~porcentaje,
#      color = ~grupo,
#      type = 'scatter',
#      mode = 'lines+markers',
#      text = ~paste0("Porcentaje: ", round(porcentaje, 1), "%"),
#      hoverinfo = 'text+x+color'
#    ) |>
#    layout(
#      xaxis = list(title = "Ola"),
#      yaxis = list(title = "Porcentaje de países"),
#      legend = list(title = list(text = "Grupo"))
#    )
 

 
 # Función para obtener URL de la bandera
 get_flag_url <- function(country_name) {
   country_codes <- list(
     Argentina = "ar", Belize = "bz", Bolivia = "bo", Brazil = "br",
     Canada = "ca", Chile = "cl", Colombia = "co", `Costa Rica` = "cr",
     `Dominican Republic` = "do", Ecuador = "ec", `El Salvador` = "sv",
     Guatemala = "gt", Guyana = "gy", Haiti = "ht", Honduras = "hn",
     Jamaica = "jm", Mexico = "mx", Nicaragua = "ni", Panama = "pa",
     Paraguay = "py", Peru = "pe", `Trinidad & Tobago` = "tt",
     `United States` = "us", Uruguay = "uy", Venezuela = "ve"
   )
   code <- country_codes[[country_name]]
   if (is.null(code)) return(NA)
   paste0("https://flagcdn.com/w40/", code, ".png")
 }
 
 # Filtrar datos y preparar para graficar
 df_2022 <- datos_wide %>%
   filter(ola == 2022) %>%
   mutate(flag_url = sapply(pais, get_flag_url))
 
 # # Calcular promedios
 # mean_h <- mean(df_2022$cohesion_horizontal, na.rm = TRUE)
 # mean_v <- mean(df_2022$cohesion_vertical, na.rm = TRUE)
 
 # Graficar
 gini <- ggplot(df_2022, aes(x = gini_index, y = cohesion_vertical)) +
   geom_smooth(method = "loess", se = FALSE, color = "black", linetype = "dashed") +
   geom_image(aes(image = flag_url), size = 0.05, asp = 1.5) +
   labs(
     x = "Gini Index",
     y = "Cohesión vertical"
   ) +
  theme_minimal() +
   theme(
     axis.title= element_text(size=36),
     axis.text= element_text(size=30)
   )
 
 gini
 

 
 
 pib <- ggplot(df_2022, aes(x = pib_per_capita_nominal, y = cohesion_horizontal)) +
   geom_smooth(method = "loess", se = FALSE, color = "black", linetype = "dashed") +
   geom_image(aes(image = flag_url), size = 0.05, asp = 1.5) +
   labs(
     x = "PIB per cápita",
     y = "Cohesión horizontal"
   ) +
   theme_minimal() +
   theme(
     axis.title= element_text(size=36),
     axis.text= element_text(size=30)
   )
 
pib

cor.test(df_2022$gini_index, df_2022$cohesion_vertical)
cor.test(df_2022$pib_per_capita_nominal, df_2022$cohesion_horizontal)


## Longitudinal
load(file = "data/base_shiny_indicadores.rdata")

paises_interes <- c("Argentina", "Brasil", "Chile", "Colombia", "El Salvador", "México", "Uruguay")

df <- df_indicadores %>% filter(País %in% paises_interes)

df_horizontal<- df |>
  filter(Dimension=="Cohesión horizontal") |>
  group_by(Ola, País) |>
  summarise(valor_promedio = mean(Valor, na.rm=T), .groups = "drop") |>
  ggplot(aes(x = Ola, y = valor_promedio, color = País, group = País)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  labs(x = "Ola",
    y = "Valor promedio"
  ) +
  theme_minimal() +
  theme(axis.title = element_text(size = 45),
    axis.text = element_text(size = 36),
    legend.title = element_blank(),
    legend.text = element_text(size = 36),
    legend.position = "bottom"
  )

df_horizontal


df_vertical<- df |>
  filter(Dimension=="Cohesión vertical") |>
  group_by(Ola, País) |>
  summarise(valor_promedio = mean(Valor, na.rm=T), .groups = "drop") |>
  ggplot(aes(x = Ola, y = valor_promedio, color = País, group = País)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  labs(x = "Ola",
       y = "Valor promedio"
  ) +
  theme_minimal() +
  theme(axis.title = element_text(size = 45),
        axis.text = element_text(size = 36),
        legend.title = element_blank(),
        legend.text = element_text(size = 36),
        legend.position = "bottom"
  )

df_vertical

