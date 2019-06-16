# INTERFAZO LAPOP_Iturra-observatorio-cohesion -----------------------------


# INTERFAZ ----------------------------------------------------------------

dashboardPage(dashboardHeader(title = 'Observatorio de Cohesión',
                              titleWidth =260, disable = FALSE),
              # Barra Lateral: tabs--------------------------------------------------------
              dashboardSidebar(width = 150,
                               tags$head(
                                 tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                               ),
                               sidebarMenu(
                                 menuItem("Inicio            ",tabName = "home" ),
                                 menuItem("Corte Transversal",tabName = "transversal" ),
                                 menuItem("Longitudinal"     ,tabName = "longitudinal"),
                                 menuItem("Correlacionar"    ,tabName = "correlacionar")
                               )),
              # Cuerpo del UI ------------------------------------------------------------
              dashboardBody(
                tabItems(
                  tabItem(tabName = "home",
                          htmlOutput(outputId="home1")
                    
                  ), #Termino tabItem (0)
                  # tab0: Home-------------------------------------------------------------------------------------
                  # tab1: Análisis transversal --------------------------------------------------------------------
                  tabItem(tabName = "transversal",
                          fluidPage(
                            box(title = NULL,width = 10, height = 1000, status = "success",
                                plotOutput(outputId = "hist1",
                                           width = "100%",
                                           height = 930)),
                            box(title = "Opciones",width = 2,height = 500,
                                selectInput(inputId = "items2",
                                            label = "Selecionar Indicador",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = 500),
                                selectInput(inputId = "country",
                                            label = "Seleciona País",
                                            choices = levels(lapop$pais),
                                            multiple = TRUE,
                                            selected = "Chile",
                                            width = 500),
                                actionButton(inputId = "boton1",
                                             label = "Graficar", icon = icon(name = "chart-bar",lib = "font-awesome")),
                                collapsible = TRUE),
                            box(title = "Exportar gráfico",width = 2,height = 250,
                                numericInput(inputId="ancho1","Ancho de gráfico (cm)", min = 10, max = 30,value = 20),
                                selectInput(inputId="format1",
                                            label = "Formato exportación",
                                            choices = c("pdf" = "pdf",
                                                        "png" = "png"),
                                            multiple = FALSE,
                                            selected = "png"),
                                downloadButton("saveplot1",label =  "Guardar"))
                            
                           ) #termino fluidPage(1)
                  ), #termino tabItem(1)
                  # tab2 : Analisis Longitudinal --------------------------------------------------------------------
                  tabItem(tabName = "longitudinal", 
                          fluidPage(
                            box(title = NULL,width = 3,height = 150,
                                selectInput(inputId = "items_long",
                                            label = "Seleciona Indicador",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = 500),
                                actionButton(inputId = "boton2",
                                             label = "Graficar", 
                                             icon = icon(name = "chart-bar",
                                                         lib = "font-awesome"),)),
                            box(title = NULL,width = 5,height = 150,
                                selectInput(inputId = "country_long",
                                            label = "Seleciona el País - Longitudinal",
                                            choices = levels(lapop$pais),
                                            multiple = TRUE,
                                            selected = c("Chile","Venezuela","Argentina","Mexico"),
                                            width = 500)),
                            # box(title = "Variable de Cohesion  - Longitudinal",width = 3,height = 200,
                            #     selectInput(inputId = "year_long",
                            #                 label = "Seleciona el año",
                            #                 choices = levels(lapop$year),
                            #                 multiple = TRUE,
                            #                 selected = c(2004,2006,2007,2008,2009,2010,2012,2014),
                            #                 width = 500)),
                            box(title = "Evolución temporal de las Medidas de Cohesión Social",width = 12, height = 1100, # ggplot2 
                                # plotOutput(outputId = "plotlong1",
                                #            width = "100%",
                                #            height = 1000),
                                plotlyOutput(outputId = "plotly1",
                                             width = "100%",
                                             height = 800))
                          ) #termino fluidPage(2)
                  ), #termino tabItem(2)
                  # tab2 : Analisis de Correlación  --------------------------------------------------------------------
                  tabItem(tabName = "correlacionar", 
                          fluidPage(
                            box(title = "Variable de Cohesion  - Correlacion (EN DESARROLLO)",width = 5,height = 500,
                                selectInput(inputId = "items_x",
                                            label = "Seleciona Indicador (Eje X)",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = 500),
                                selectInput(inputId = "items_y",
                                            label = "Seleciona Indicador (Eje Y)",
                                            choices = var_label,
                                            selected = FALSE,
                                            selectize = FALSE,
                                            multiple = FALSE,
                                            width = 500)
                                )
                          ) #termino fluidPage(2)
                  ) #termino tabItem(2)

                )# Termino de tabItems() -- Entorno principal de pestañas en sidebar
              ) #Termino de dashboardBody() -- Entorno principal para elementos, inputs, tables & plots
) #Termino de dashboardPage()



