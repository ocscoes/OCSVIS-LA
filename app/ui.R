# INTERFAZO OCS-COES -----------------------------

# install.packages("shiny")
# install.packages("shinydashboard")
# install.packages("shinydashboardPlus")
# install.packages("ggplot2")
# install.packages("scales")
# install.packages("ggthemes")
# install.packages("sjlabelled")
# install.packages("dplyr")
# install.packages("Cairo")


library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinyEffects)
library(shinydashboard)
library(shinydashboardPlus)
library(ggplot2)
library(ggrepel)
library(highcharter)
library(scales)
library(ggthemes)
library(sjlabelled)
library(dplyr)
library(Cairo);options(shiny.usecairo=TRUE) # Para la calidad de los plots


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

dashboardPagePlus(
  dashboardHeaderPlus(title = tagList(
    span(class = "logo-lg", "OCS-COES"),
    img(src = "images/OCS_1_1.svg")),
    disable = FALSE,
    titleWidth = 300,
    enable_rightsidebar = TRUE),
  # Barra Lateral: tabs--------------------------------------------------------
              dashboardSidebar(width = 150,
                               sidebarMenu(
                                 menuItem("Inicio           ",tabName = "home", icon = icon("globe-americas")),
                                 menuItem("Transversal"  ,tabName = "transversal", icon = icon("chart-bar")),
                                 menuItem("Longitudinal" ,tabName = "longitudinal", icon = icon("chart-line")),
                                 menuItem("Correlacionar",tabName = "correlacionar",icon=icon("project-diagram"))
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
                extendShinyjs(text = jsToggleFS), #3. Full screen app
                div(id = "loading-content",
                    tags$img(src = "https://i.pinimg.com/originals/a4/f2/cb/a4f2cb80ff2ae2772e80bf30e9d78d4c.gif")
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
                                           height = 900)
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
                                            label = "Seleciona año",
                                            choices = levels(lapop$year),
                                            multiple = FALSE,
                                            selected = c("2014"),
                                            width = 700),
                                selectInput(inputId = "country",
                                            label = "Seleciona País",
                                            choices = levels(lapop$pais),
                                            multiple = TRUE,
                                            selected = c("Chile","Venezuela","Argentina","Mexico"),
                                            width = 700),
                                actionButton(inputId = "boton1",
                                             label = "Graficar", 
                                             width = "100%",
                                             icon = icon(name = "chart-bar",lib = "font-awesome")),
                                collapsible = TRUE),
                            box(title = NULL,
                                width = 2,
                                collapsible = TRUE,
                                status = "warning",
                                numericInput(inputId="ancho1","Ancho de gráfico (cm)", min = 10, max = 30,value = 20,width = "100%"),
                                selectInput(inputId="format1",
                                            label = "Exportar gráfico",
                                            choices = c("pdf" = "pdf",
                                                        "png" = "png"),
                                            multiple = FALSE,
                                            selected = "png",width = "100%"),
                                downloadButton("saveplot1",label =  "Guardar")
                                ),

                           ) #termino fluidPage(1)
                  ), #termino tabItem(1)
                  # tab2 : Analisis Longitudinal --------------------------------------------------------------------
                  tabItem(tabName = "longitudinal", 
                          fluidPage(
                            box(title = "Evolución temporal de las Medidas de Cohesión Social",
                                width = 13, 
                                collapsible = TRUE,
                                plotOutput(outputId = "plotlong1",
                                           width = "100%",
                                           height = 620)
                                # plotlyOutput(outputId = "plotly1",
                                #              width = "100%",
                                #              height = 800)
                            ),
                            box(title = NULL,width = 6,
                                collapsible = TRUE,
                                selectInput(inputId = "items_long",
                                            label = "Seleciona Indicador",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                sliderInput(inputId = "year_long", 
                                            label = "Rango de Año",
                                            width = "100%",
                                            sep = "",step = 1,
                                            min = 2004,
                                            max = 2014, 
                                            value = c(2004,2014)),
                                ),
                            box(title = NULL,
                                width = 6,
                                height = "218px",
                                collapsible = TRUE,
                                selectInput(inputId = "country_long",
                                            label = "Seleciona el País",
                                            choices = levels(lapop$pais),
                                            multiple = TRUE,
                                            selected = c("Chile","Venezuela","Argentina","Mexico"),
                                            width = "100%"),
                                actionButton(inputId = "boton2",
                                             width = "100%",height="100%",
                                             label = "Graficar", 
                                             icon = icon(name = "chart-bar",
                                                         lib = "font-awesome"))
                                )
                          
                            # box(title = "Variable de Cohesion  - Longitudinal",width = 3,height = 200,
                            #     selectInput(inputId = "year_long",
                            #                 label = "Seleciona el año",
                            #                 choices = levels(lapop$year),
                            #                 multiple = TRUE,
                            #                 selected = c(2004,2006,2007,2008,2009,2010,2012,2014),
                            #                 width = 500))

                          ) #termino fluidPage(2)
                  ), #termino tabItem(2)
                  # tab2 : Analisis de Correlación  --------------------------------------------------------------------
                  tabItem(tabName = "correlacionar", 
                          fluidPage(
                            box(title = "Correlación variables de cohesión social",
                                width = 10,
                                collapsible = TRUE,
                                plotOutput(outputId = "plotscat1",
                                           width = "100%",
                                           height = 900)),
                            box(title = "Variable de Cohesion",
                                width = 2,
                                collapsible = TRUE,
                                selectInput(inputId = "items_x",
                                            label = "Seleciona Indicador (Eje X)",
                                            choices = var_label,
                                            selected = "it1",
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                selectInput(inputId = "items_y",
                                            label = "Seleciona Indicador (Eje Y)",
                                            choices = var_label,
                                            selected = "pn4",
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = "100%"),
                                selectInput(inputId = "year_scatter",
                                            label = "Seleciona año",
                                            choices = levels(lapop$year),
                                            multiple = FALSE,
                                            selected = c("2014"),
                                            width = "100%"),
                                actionButton(inputId = "boton3",
                                             width = "100%",
                                             height="100%",
                                             label = "Graficar", 
                                             icon = icon(name = "chart-bar",
                                                         lib = "font-awesome"))
                                
                                )
                          ) #termino fluidPage(2)
                  ) #termino tabItem(2)
                )# Termino de tabItems() -- Entorno principal de pestañas en sidebar
              ), #Termino de dashboardBody() -- Entorno principal para elementos, inputs, tables & plots
  rightSidebar(
    background = "dark",
    rightSidebarTabContent(
      id = 1,
      title = "Tab 1 (en desarrollo)",
      icon = "desktop",
      active = TRUE
    ),
    rightSidebarTabContent(id = 3,
                           icon = "paint-brush",
                           title = "Tab 3")
    ), 
  dashboardFooter(left_text  = "Observatorio de Cohesión Social -  COES",
                  right_text = "@jciturras"),
  
          ) #Termino de dashboardPage()




