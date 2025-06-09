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
 #install_version("shinydashboardPlus", version = "0.7.5")

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinyEffects)
library(shinydashboardPlus)
library(shinydashboard)
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
library(plotly)
library(V8)
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

ui <- dashboardPage(
  shinydashboardPlus::dashboardHeader(title = NULL,
                                      disable = TRUE,
                                      titleWidth = 300
                                      #enable_rightsidebar = FALSE
                                      ),
  shinydashboardPlus::dashboardSidebar(
                                       minified = TRUE,
                                       width = 110,
                                       id='sidebarCollapsed',
                                       sidebarMenu(
                                        menuItem("Instruc.", tabName = "home", icon = icon("house")),
                                        menuItem("Mapa", tabName = "mapa", icon = icon("globe-americas")),
                                        menuItem("Longit.", tabName = "longitudinal", icon = icon("chart-line")),
                                        menuItem("Bivar.", tabName = "bivariado", icon = icon("project-diagram"))
                                        # Código para el botón de pantalla completa (si lo necesitas)
                                        # div(HTML("<button type='button'>Toggle Fullscreen</button>"), onclick = "shinyjs.toggleFullScreen();")
                                        )
                                       ),
  dashboardBody(
    tags$style(".content-wrapper {
               background-color: #FFFFFF !important;
               padding-top: 2% !important;
               padding-bottom: 2% !important;
               }"),
    
    setShadow(class = "box"),
    setShadow(class= "main-header"), 
    setShadow(class= "sidebar-collapse"),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/custom-a.css"),
      tags$link(rel="preconnect", href="https://fonts.googleapis.com"),
      tags$link(rel="preconnect", href="https://fonts.gstatic.com", crossorigin=TRUE),
      tags$link(href="https://fonts.googleapis.com/css2?family=Noto+Color+Emoji&display=swap", rel="stylesheet")
      ),
    useShinyjs(),  # Inicialización de shinyjs
    extendShinyjs(text = jsToggleFS, functions = c("toggleFullScreen")),
    # Otros elementos JS y CSS
    inlineCSS(appCSS),
    tabItems(
      tabItem(tabName = "home",
              htmlOutput(outputId = "home1")
              ),
      tabItem(tabName = "mapa", # Inicio mapa -----
              tags$style("
                          #shiny-tab-mapa .main-container { display: flex; justify-content: center;
                                            align-items: flex-start; min-width: 800px;}
                          #shiny-tab-mapa .container-fluid { max-width: 1200px;}
                          #shiny-tab-mapa .map-container { width: 66%; }
                          #shiny-tab-mapa .controls-container { width: 34%; text-align: right; padding-top: 20px;
                                                align-items: center; height: 800px; padding-top: 0%;}
                          #shiny-tab-mapa .slider-wrapper { display: flex; align-items: center; }
                          #shiny-tab-mapa .slider-title {width: 33%; font-size: 2em; color: #383838; font-weight: 500; letter-spacing: 2px;}
                          #shiny-tab-mapa .shiny-input-container:not(.shiny-input-container-inline) { width: 62%; max-width: 100%;}
                          #shiny-tab-mapa .btn {font-weight: 300; border-radius: 17px; padding: 4px 0px; font-size: 16px; width: 40%; margin: 0px 0px 3% 5%;}
                          #shiny-tab-mapa img {max-width: 44%!important;}
                         "),
              div(class = "main-container",
              div(class = "map-container",
                  leafletOutput("map", height = "800px", width = "100%")),
              div(class = "controls-container",
              div(class = "slider-wrapper",
                div(class = "slider-title", "AÑO: "),
                sliderInput("Ola", "", min = min(unique_years),
                            max = max(unique_years),
                            value = min(unique_years),
                            step = step_size, sep = "")
                ),
              actionButton("btn_var1",
                           label = HTML('<img src="img/Confianza interpersonal.svg" alt="Confianza interpersonal" width="75"><span><br>Confianza<br>interpersonal</span>')),
              actionButton("btn_var2",
                           label = HTML('<img src="img/seguridad publica.svg" alt="Seguridad Pública" width="75"><span><br>Seguridad<br>Pública</span>')),
              actionButton("btn_var3",
                           label = HTML('<img src="img/Confianza en instituciones.svg" alt="Confianza en instituciones" width="75"><span><br>Confianza en<br>instituciones</span>')),  
              actionButton("btn_var4",
                           label = HTML('<img src="img/Actitud hacia la democracia.svg" alt="Actitud hacia la democracia" width="75"><span><br>Actitud hacia<br>la democracia</span>')),
              actionButton("btn_var5",
                           label = HTML('<img src="img/Justicia distributiva.svg" alt="Justicia distributiva" width="75"><span><br>Justicia<br>distributiva</span>')),
              actionButton("btn_var6",
                           label = HTML('<img src="img/cohesion-horizontal.svg" alt="Cohesión horizontal" width="75"><span><br>Cohesión<br>horizontal</span>')),
              actionButton("btn_var7",
                           label = HTML('<img src="img/cohesion-vertical.svg" alt="Cohesión vertical" width="75"><span><br>Cohesión<br>vertical</span>')),
              actionButton("btn_var8",
                           label = HTML('<img src="img/cohesion-general.svg" alt="Cohesión general" width="75"><span><br>Cohesión<br>general</span>'))
        )
    ), # Fin mapa -----
      ),
      tabItem(tabName = "longitudinal", # Inicio longitudinal -----
              plotlyOutput("longitudinal_plotly", height = "800px")
      ), # Fin longitudinal -----
      tabItem(tabName = "bivariado", # Inicio Bivariado -----
              tags$head(
                tags$script(
                  HTML(
                    "$(document).ready(function() {
           // Código JavaScript para modificar el HTML del selector.
           // Añadir SVG para 'Actitud hacia la democracia'
           var optionValue = 'Actitud hacia la democracia';
           $('option:contains(' + optionValue + ')').each(function(){
             if ($(this).text() == optionValue) {
               $(this).html('<img src=\"www/img/Actitud hacia la democracia.svg\" style=\"width:20px; height:auto;\"> ' + optionValue);
             }
           });

           // Similarmente, añadir SVG para 'Confianza interpersonal'
           optionValue = 'Confianza interpersonal';
           $('option:contains(' + optionValue + ')').each(function(){
             if ($(this).text() == optionValue) {
               $(this).html('<img src=\"www/img/Confianza interpersonal.svg\" style=\"width:20px; height:auto;\"> ' + optionValue);
             }
           });
           // Añadir más aquí para otras variables
         });"
                  )
                )
              ),
         tags$style("
        #shiny-tab-bivariado .main-container { display: flex; justify-content: center; align-items: flex-start; min-width: 800px; height: 800px;}
        #shiny-tab-bivariado .container-fluid { max-width: 1200px;}
        #shiny-tab-bivariado .map-container { width: 67%; }
        #shiny-tab-bivariado .controls-container { width: 32%; align-items: center; height: 800px; padding-top: 0%; padding-left: 3%;}
        #shiny-tab-bivariado .slider-wrapper { display: flex; align-items: center; }
        #shiny-tab-bivariado .slider-title {width: 33%; font-size: 2em; color: #383838; font-weight: 500; letter-spacing: 2px;}
        #shiny-tab-bivariado .shiny-input-container:not(.shiny-input-container-inline) { width: 62%; max-width: 100%;}
        #shiny-tab-bivariado .btn {font-weight: 300; border-radius: 17px; padding: 4px 0px; font-size: 16px; width: 40%; margin: 0px 0px 3% 5%;}
        text {font-family: 'Noto Color Emoji', 'Open Sans', verdana, arial, sans-serif;}
    "),
    
    div(class = "main-container",
        div(class = "map-container",
            plotlyOutput("plot", height = "800px")
        ),
        div(class = "controls-container",
            sliderInput("Ola_bi", "", min = min(unique_years_bi), max = max(unique_years_bi), value = min(unique_years_bi), step = step_size_bi, sep = ""),
            selectInput("x_var", "Variable para el eje X:", choices = unique(df$Variable), selected = "Actitud hacia la democracia"),
            selectInput("y_var", "Cariable para el eje Y:", choices = unique(df$Variable), selected = "Confianza interpersonal"),
            checkboxInput("show_flags", "Banderas en lugar de puntos.", TRUE),
            hidden(div(id = "noDataDiv", style = "color: red;", "No hay datos disponibles para la variable en este año. Por favor, seleccione otro."))
        )
    )
      )
    )
  )
)