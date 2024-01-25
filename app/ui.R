#------------------------------------------------------------------------------#
# Proyect title: "Observatorio de Cohesion Social" 
# Author(s): Julio Iturra Sanhueza & Juan Carlos Castillo
# website: https://www.linkedin.com/in/jciturras/
# e-mail: julioiturrasanhueza@gmail.com
#------------------------------------------------------------------------------#

# INTERFAZ OCS-COES -----------------------------

# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("shinydashboardPlus")
# install.packages("ggplot2")
# install.packages("scales")
# install.packages("ggthemes")
# install.packages("sjlabelled")
# install.packages("dplyr")
# install.packages("Cairo")
# library(devtools)
# install.packages("shinydashboardPlus")
# install_version("shinydashboardPlus", version = "0.7.5")

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinyEffects)
# library(shinydashboardPlus)
library(shinydashboard)
library(shinydashboardPlus)

library(ggplot2)
library(ggrepel)
library(cowplot)
library(magick)
library(highcharter)
library(fontawesome)
library(scales)
library(ggthemes)
library(RColorBrewer)
library(hrbrthemes)
library(sjlabelled)
library(dplyr)
library(V8)
# library(Cairo)
options(shiny.usecairo=TRUE) # Para la calidad de los plots


# fullscreen buton ----------------------------------------------------------------------------

jsToggleFS <- 'shinyjs.toggleFullScreen = function() {
    var element = document.documentElement,
      enterFS = element.requestFullscreen || element.msRequestFullscreen || element.mozRequestFullScreen || element.webkitRequestFullscreen,
      exitFS = document.exitFullscreen || document.msExitFullscreen || document.mozCancelFullScreen || document.webkitExitFullscreen;
    if (!document.fullscreenElement && !document.msFullscreenElement && !document.mozFullScreenElement && !document.webkitFullscreenElement) {
      enterFS.call(element);
    } else {
      exitFS.call(document);
    }
  }'

# fade in loading screen ----------------------------------------------------------------------
appCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  vertical-align: bottom;
  color: #FFFFFF;
}
"

setShadow <- shinyEffects::setShadow


# INTERFAZ ----------------------------------------------------------------

shinydashboardPlus::dashboardPage(
  shinydashboardPlus::dashboardHeader(
    title =  NULL,
      # tagList(
    # span(class = "logo-lg", "OCS-COES"),
    # img(src = "images/OCS_1_1.svg")
    # ),
    disable = TRUE,
    titleWidth = 300
    # enable_rightsidebar = FALSE
    ),
  # Barra Lateral: tabs--------------------------------------------------------
              dashboardSidebar(width = 200,
                               sidebarMenu(
                                 menuItem("Instrucciones",tabName = "home",        icon = icon("globe-americas")),
                                 menuItem("Transversal"  ,tabName = "transversal", icon = icon("chart-bar")),
                                 menuItem("Longitudinal" ,tabName = "longitudinal",icon = icon("chart-line")),
                                 menuItem("Bivariado"    ,tabName = "bivariado",   icon=icon("project-diagram"))
#                                 div(HTML("<button type='button'>Toggle Fullscreen </button>"),onclick = "shinyjs.toggleFullScreen();") #full screen button
                               )),
              # Cuerpo del UI ------------------------------------------------------------
              dashboardBody(
                setShadow(class = "box"),
                setShadow(class= "main-header"), 
                setShadow(class= "sidebar-collapse"),
                #-------------------------------------------------------------------------
                inlineCSS(appCSS), # 1. Cubre de negro toda la app
                useShinyjs(),      # 2. Carga funciones JS a la app 
                extendShinyjs(text = jsToggleFS, functions = c("toggleFullScreen")), #3. Full screen app
                div(id = "loading-content",
                    tags$img(src = "https://github.com/ocscoes/OCS-COES/raw/master/app/www/images/logo-ocs-animated.gif")
                    ), # Loading image 
                #------------------------------------------------------------------------#
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "css/custom-a.css")),
                tabItems(
                  # tab0: Home-------------------------------------------------------------------------------------
                  tabItem(tabName = "home",
                          htmlOutput(outputId="home1")
                          ), #Termino tabItem (0)
                  # tab1: Análisis transversal --------------------------------------------------------------------
                  tabItem(tabName = "transversal",
                          fluidPage(
                            box(title = NULL,
                                width = 10, 
                                status = "success",
                                collapsible = TRUE,
                                plotOutput(outputId = "hist1",
                                           width = "100%",
                                           height = 1000)
                                # plotlyOutput(outputId = "plotly2",
                                #              width = "100%",
                                #              height = 930)
                            ),
                            box(title = NULL,width = 2,
                                selectInput(inputId = "items2",
                                            label = "Selecionar Indicador",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = 700),
                                selectInput(inputId = "year",
                                            label = "Seleciona ola",
                                            choices = levels(lapop_ind_2004to2021$wave),
                                            multiple = FALSE,
                                            selected = c("2018"),
                                            width = 700),
                                selectInput(inputId = "country",
                                            label = "Seleciona País",
                                            choices = levels(lapop_ind_2004to2021$pais),
                                            multiple = TRUE,
                                            selected = c("Chile","Estados Unidos","Mexico","Ecuador"),
                                            width = 700),
                                actionButton(inputId = "boton1",
                                             label = "Graficar", 
                                             width = "100%",
                                             icon = icon(name = "chart-bar",lib = "font-awesome"),
                                             style="color: #fff; background-color: #FF8787; border-color: #2e6da4"),
                                collapsible = TRUE)
                            # box(title = NULL,
                            #     width = 2,
                            #     collapsible = TRUE,
                            #     status = "warning",
                            #     numericInput(inputId="ancho1","Ancho de gráfico (cm)", min = 10, max = 30,value = 20,width = "100%"),
                            #     selectInput(inputId="format1",
                            #                 label = "Exportar gráfico",
                            #                 choices = c("pdf" = "pdf",
                            #                             "png" = "png"),
                            #                 multiple = FALSE,
                            #                 selected = "png",width = "100%"),
                            #     downloadButton("saveplot1",label =  "Guardar")
                            #     )

                           ) #termino fluidPage(1)
                  ), #termino tabItem(1)
                  # tab2 : Analisis Longitudinal --------------------------------------------------------------------
                  tabItem(tabName = "longitudinal", 
                          fluidPage(
                            box(title = NULL,
                                width = 6,
                                collapsible = TRUE,
                                selectInput(inputId = "items_long",
                                            label = "Seleciona Indicador",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                sliderInput(inputId = "year_long", 
                                            label = "Rango de ola",
                                            width = "100%",
                                            sep = "",
                                            step = 1,
                                            min = 2004,
                                            max = 2023, 
                                            value = c(2004,2023))
                                ),
                            box(title = NULL,
                                width = 6,
                                height = "218px",
                                collapsible = TRUE,
                                selectInput(inputId = "country_long",
                                            label = "Seleciona el País",
                                            choices = levels(lapop_country_2004to2021$pais),
                                            multiple = TRUE,
                                            selected = c("Chile","United States","Venezuela"),
                                            width = "100%"),
                                actionButton(inputId = "boton2",
                                             width = "100%",
                                             height="100%",
                                             label = "Graficar", 
                                             icon = icon(name = "chart-bar",
                                                         lib = "font-awesome"),
                                             style="color: #fff; background-color: #FF8787; border-color: #2e6da4")
                                ),
                            box(title = NULL,
                                width = 12,
                                collapsible = TRUE,
                                plotOutput(outputId = "plotlong1",
                                           width = "100%",
                                           height = 850)
                            )
                          ) #termino fluidPage(2)
                  ), #termino tabItem(2)
                  # tab2 : Analisis de Correlación  --------------------------------------------------------------------
                  tabItem(tabName = "bivariado", 
                          fluidPage(
                            box(title = NULL,
                                width = 10,
                                collapsible = TRUE,
                                plotOutput(outputId = "plotscat1",
                                           width = "100%",
                                           height = 1000)),
                            box(title = NULL,
                                width = 2,
                                collapsible = TRUE,
                                selectInput(inputId = "items_x",
                                            label = "Seleciona Indicador (Horizontal)",
                                            choices = var_labelcor,
                                            selected = "b2",
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                selectInput(inputId = "items_y",
                                            label = "Seleciona Indicador (Vertical)",
                                            choices = var_labelcor,
                                            selected = "ros4",
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                # selectInput(inputId = "year_scatter",
                                #             label = "Seleciona ola",
                                #             choices = levels(lapop_long_wave$wave),
                                #             multiple = FALSE,
                                #             selected = c("2014"),
                                #             width = "100%"),
                                sliderInput(inputId = "year_scatter", 
                                            label = "Rango de ola",
                                            width = "100%",
                                            sep = "",step = 2,
                                            min = 2004,
                                            max = 2023, 
                                            value = c(2014,2023)),
                                actionButton(inputId = "boton3",
                                             width = "100%",
                                             height="100%",
                                             label = "Graficar", 
                                             icon = icon(name = "chart-bar",
                                                         lib = "font-awesome"),
                                             style="color: #fff; background-color: #FF8787; border-color: #2e6da4")
                                
                                )
                          ) #termino fluidPage(2)
                  ) #termino tabItem(2) ------
                )# Termino de tabItems() -- Entorno principal de pestañas en sidebar
              )
          ) #Termino de dashboardPage()




