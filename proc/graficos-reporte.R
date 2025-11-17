library(pacman)
p_load(tidyverse,
       janitor,
       plotly,
       ggimage,
       RColorBrewer,
       ggbreak)

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

 cor.test(df_2022$gini_index, df_2022$cohesion_vertical)
 cor.test(df_2022$pib_per_capita_nominal, df_2022$cohesion_horizontal)
 
 
 dat_text <- data.frame(
   label = c("r = -0.33"),
   gini_index = c(52.5),
   cohesion_vertical = c(5.5)) 
 
 # Graficar
 gini <- ggplot(df_2022, aes(x = gini_index, y = cohesion_vertical)) +
   geom_smooth(method = "loess", se = FALSE, color = "black", linetype = "dashed") +
   geom_image(aes(image = flag_url), size = 0.07, asp = 1.5) +
   scale_y_continuous(n.breaks = 6) + 
   scale_x_continuous(breaks = seq(35,55,5)) +
   labs(
     x = "Índice Gini",
     y = "Cohesión vertical"
   ) +
   geom_text(data = dat_text,
             mapping = aes(x = gini_index, y = cohesion_vertical, label = label),
             size = rel(20)) +
  theme_minimal() +
   theme(axis.title = element_text(size = 50),
     axis.text = element_text(size = 36)
   )
 
 gini
 
 
 dat_text <- data.frame(
   label = c("r = 0.29"),
   pib_per_capita_nominal = c(20000),
   cohesion_horizontal = c(7.5)) 

 
 pib <- ggplot(df_2022, aes(x = pib_per_capita_nominal, y = cohesion_horizontal)) +
   geom_smooth(method = "loess", se = FALSE, color = "black", linetype = "dashed") +
   geom_image(aes(image = flag_url), size = 0.07, asp = 1.5) +
   scale_y_continuous(n.breaks = 6) + 
   scale_x_continuous(n.breaks = 6) +
   labs(
     x = "PIB per cápita",
     y = "Cohesión horizontal"
   ) +
   geom_text(data = dat_text,
             mapping = aes(x = pib_per_capita_nominal, y = cohesion_horizontal, label = label),
             size = rel(20)) +
   theme_minimal() +
   theme(
     axis.title = element_text(size = 50),
     axis.text= element_text(size=36)
   )
 
pib



## Longitudinal
load(file = "data/base_shiny_indicadores.rdata")

p  <- df_indicadores |> 
  clean_names() |>
  group_by(ola, dimension) |>
  summarise(promedio = mean(valor, na.rm=T)) |>
  ggplot(aes(x = ola, y = promedio, color = dimension, group = dimension)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    x = "Ola",
    y = "Promedio",
    color = NULL
  ) +
  scale_y_continuous(limits = c(0,7)) +
  theme_minimal(base_size = 13) +
  theme(legend.position = "top")

p

p + scale_y_cut(breaks=c(3.5), which=c(1, 2), scales=c(3, 0.5))


paises_interes <- c("Argentina", "Brasil", "Chile", "Colombia", "El Salvador", "México", "Uruguay")

df <- df_indicadores %>% filter(País %in% paises_interes) %>% janitor::clean_names()

df_horizontal <- df |>
  filter(dimension == "Cohesión horizontal") |>
  group_by(ola, pais) |>
  summarise(valor_promedio = mean(valor, na.rm = T), .groups = "drop") |>
  ggplot(aes(x = ola, y = valor_promedio, color = pais, group = pais)) +
  geom_line(linewidth = 1.5) +
  geom_point(aes(shape = pais, color = pais), size = 5) +
  scale_y_continuous(n.breaks = 6) +
  scale_shape_manual(values = c("Argentina" = 15, 
                                "Brasil" = 16, 
                                "Chile" = 17,
                                "Colombia" = 18,
                                "El Salvador" = 4,
                                "México" = 3,
                                "Uruguay"= 8)) +
  scale_color_brewer(palette = "Dark2") + 
  labs(x = "Ola", y = "Valor promedio") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 50),
    axis.text = element_text(size = 36),
    legend.title = element_blank(),
    legend.text = element_text(size = 40),
    legend.position = "bottom",
    legend.key.size = unit(2.5, "lines"),
    legend.key.height = unit(2.5, "lines"),
    legend.key.width = unit(2.5, "lines")
  ) +
  guides(
    color = guide_legend(override.aes = list(size = 2.5)),  # para líneas
    shape = guide_legend(override.aes = list(size = 5))     # para shapes
  )


df_horizontal


df_vertical<- df |>
  filter(dimension == "Cohesión vertical") |>
  group_by(ola, pais) |>
  summarise(valor_promedio = mean(valor, na.rm = T), .groups = "drop") |>
  ggplot(aes(x = ola, y = valor_promedio, color = pais, group = pais)) +
  geom_line(linewidth = 1.5) +
  geom_point(aes(shape = pais, color = pais), size = 5) +
  scale_y_continuous(n.breaks = 6) +
  scale_shape_manual(values = c("Argentina" = 15, 
                                "Brasil" = 16, 
                                "Chile" = 17,
                                "Colombia" = 18,
                                "El Salvador" = 4,
                                "México" = 3,
                                "Uruguay"= 8)) +
  scale_color_brewer(palette = "Dark2") + 
  labs(x = "Ola", y = "Valor promedio") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 50),
    axis.text = element_text(size = 36),
    legend.title = element_blank(),
    legend.text = element_text(size = 40),
    legend.position = "bottom",
    legend.key.size = unit(2.5, "lines"),
    legend.key.height = unit(2.5, "lines"),
    legend.key.width = unit(2.5, "lines")
  ) +
  guides(
    color = guide_legend(override.aes = list(size = 2.5)),  # para líneas
    shape = guide_legend(override.aes = list(size = 5))     # para shapes
  )


df_vertical

