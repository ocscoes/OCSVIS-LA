
# SERVIDOR LAPOP_Iturra-observatorio-cohesion -----------------------------

# SERVER ------------------------------------------------------------------

function(input, output){
  lapop_subset <- eventReactive(
    eventExpr = input$boton1,
    {lapop_ind1 %>% dplyr::select(input$items2,pais,year) %>% dplyr::filter(pais %in% input$country) %>% copy_labels(lapop_ind1) # Actualiza el subset variable / pais / año  - reacciona a boton1
                                                                                                                                 # Para usar plotly tuve que agregar un na.omit(), de lo contrario siempre aparecía una barra "null"
  })                                                                                                                             # - Problema: al agregar na.omit() pierdo los attr labels de sjlabelled
                            
  
  # Gráfico de Barras  ---------------------------------------------------------
  etiq1 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset())) # Crear data con los labels para gráficos
  })
 
  eje_x1    <-  eventReactive(eventExpr = input$boton1,{input$items2})    # Actualiza la variable para el barplot - reacciona a boton1

  etiq1a <- reactive({sjlabelled::get_label(lapop_subset())})  # Crear data con los labels para gráficos

# Usando ggplot2 barras -------------------------------------------------------

  
  output$hist1 <-  renderPlot({
    
    req({input$boton1})
    p1 <-ggplot(lapop_subset(), aes_string(x = eje_x1(),group = "pais")) +
      geom_bar(aes(group = "pais",
                   y = stat(prop)),
               color     = "black",
               fill =  "#497abd") +
      scale_y_continuous(labels = scales::percent) +
      scale_x_discrete(na.translate = FALSE)+
      xlab(label = etiq1()$lab1) +
      ylab("") +
      facet_wrap("pais~.") +
      geom_label(aes(y = stat(prop),
                     label = paste0(round(stat(prop)* 100,1), '%')),
                 stat    = 'count',
                 vjust   = 0.7,
                 nudge_x = 0,
                 nudge_y = 0,
                 color   = "black",
                 size    = 4,
                 fontface = "plain",
                 label.padding = unit(0.1, "lines"), 
                 alpha=0.9)+
      theme_hc()+
      theme(strip.text.x     = element_text(size   = 18,face = "bold"),
            strip.text.y     = element_text(size   = 15,
                                            family = "Lato", 
                                            face   = "bold"),
            strip.background = element_rect(colour = "grey", 
                                            fill   = "white"),
            panel.spacing    = unit(2, "lines"),
            axis.title       = element_text(size  = 13, 
                                            face  = "bold"),
            axis.text.x      = element_text(size  = 12,
                                            face = "bold"),
            axis.text.y      = element_text(size  = 12,
                                            face = "bold"),
            plot.title       = element_text(size  = 20,
                                            face  = "plain",
                                            hjust = 0.5,
                                            family = "Lato"),
            plot.caption     = element_text(size  = 13,family = "Lato",hjust = 0,face = "italic"))+
      labs(title    = paste(etiq1()$lab1,"\n"),
           subtitle = NULL,
           caption  = "Fuente: Encuesta LAPOP (2004 - 2014) \nObservatorio de Cohesión Social - Centro de Estudios de Conflicto y Cohesión Social ")
    

  print(p1)

  })
  
# Usando plotly barras (INTERACTIVO) -------------------------------------------------------
  # 
  # output$plotly2 <-  renderPlotly({
  #   req({input$boton1})
  # p1 <-ggplot(lapop_subset(), aes_string(x = input$items2,group = "pais")) +
  #     geom_bar(aes(group = "pais",
  #                  y = stat(prop),
  #                  text= paste0(round(stat(prop)*100,1),"%")),
  #              color     = "black",
  #              fill =  "#497abd") +
  #     scale_y_continuous(name=" ",labels = scales::percent) +
  #     scale_x_discrete(name=" ")+
  #     facet_wrap("pais~.") +
  #   theme_classic() + theme(strip.text.x = element_text(size = 12,face = "bold"))
  # 
  # 
  # 
  # p1a <- ggplotly(p1,tooltip = c("text"))   # 1. crear objeto plotly
  # t1 <- etiq1a()[[1]]                       # 2. guardar character vector con titulo
  # 
  # p1a %>% layout(title = t1,
  #                margin=list(t = 75) # Esto es para mantener el titulo sobre el gráfico. Sin overlap.
  #                )
  # 
  # })

# GUARDAR ggplot2 barras ----------------------------------------------------------------------

  output$saveplot1 <- downloadHandler(
    filename = function() {paste(stringr::str_replace_all(string = etiq1()$lab1,
                                                 pattern = " ",
                                                 replacement = "_"),
                                 "_lapop",
                                 ".",
                                 input$format1,
                                 sep = "")},
    content = function(file) {
      ggsave(file,
             plot = ggplot2::last_plot(),  #----last_plot() toma el ultimo gráfico creado por ggplot
             device = input$format1,
             dpi = "retina",
             width = input$ancho1*1.294118,
             height = input$ancho1,
             units = "cm")
    }
  )


# Subset longtudinal -------------------------------------------------------------------------

  lapop_subset_long <- eventReactive(
    eventExpr = input$boton2,
    {lapop %>% dplyr::select(input$items_long,pais,year,pais_year) %>% dplyr::filter(pais %in% input$country_long) %>% copy_labels(lapop) # Actualiza el subset variable / pais / año  - reacciona a boton2
    })

  # Etiquetas para Gráfico longitudinal  ---------------------------------------------------------
  etiq2 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset_long())) # Crear data con los labels para gráficos
  })
  eje_x2   <-  eventReactive(eventExpr = input$boton2,{input$items_long})     # Actualiza la variable para el plot  - reacciona a boton2

  # Grafico longitudinal (estatico) ------------------------------------------------------------------------

  output$plotlong1 <-  renderPlot({
    
    # req({input$items_long})
    req({input$boton2})
    ggplot(data = lapop_subset_long(),aes_string(x = "year", y = eje_x2(),group ="pais", color = "pais")) +
      geom_line(size=1.5) +
      geom_point(shape=21,size=3, color ="black",fill="white") +
      stat_summary(data = lapop, aes_string(y = eje_x2(),x = "year",group = 1), fun.y=mean, colour="navyblue", size=1,alpha =0.3, linetype= "dotted", geom="line") +
      stat_summary(data = lapop, aes_string(y = eje_x2(),x = "year",group = 1, shape="promedio"), fun.y=mean, colour='cornflowerblue',size=4, geom="point") +
      xlab(label = NULL) +
      ylab(label = NULL) +
      scale_x_discrete(name=" ",na.translate = FALSE)+
      guides(shape=guide_legend(title = NULL),
             color=guide_legend(title = NULL))+
      theme_classic() + 
    theme(axis.text.x  = element_text(size   = 18,family = "Lato",face = "bold"),
          axis.text.y  = element_text(size   = 15,family = "Lato",face = "bold"),
          axis.title.x = element_text(size   = 18,family = "Lato",face = "bold"),
          axis.title.y = element_text(size   = 18,family = "Lato",face = "bold"),
          legend.text  = element_text(size   = 12,family = "Lato"),
          plot.title   = element_text(size   = 18,family = "Lato",face = "bold",hjust = 0.5),
          plot.caption = element_text(size   = 12,family = "Lato",hjust = 0,face = "italic")) +
      labs(title    = paste(etiq2()$lab1,"\n"),
           caption  = "Fuente: Encuesta LAPOP (2004 - 2014) \nObservatorio de Cohesión Social - Centro de Estudios de Conflicto y Cohesión Social ")
    
  })

  # Grafico longitudinal (interactivo) ------------------------------------------------------------------------
  # setiq3 <- reactive({sjlabelled::get_label(lapop_subset_long())})  # Crear data con los labels para gráficos

  # output$plotly1 <-  renderPlotly({
  #   req({input$boton2})
  #   req({input$items_long})
  #   ply1 <- ggplot(data = lapop_subset_long(),aes_string(x = "year", y = eje_x2(),group =1,color = "pais",text = "pais_year")) +
  #     geom_line(size=1.5) +
  #     # geom_point(size=1.8, color ="blue") +
  #     stat_summary(data = lapop, aes_string(text = NULL), fun.y="mean", colour="navyblue" , size=1, linetype= "dashed", geom="line") +
  #     stat_summary(data = lapop, aes_string(text = NULL), fun.y="mean", colour='blue', size=4, alpha  =0.3, geom="point") +
  #     xlab("Año") +
  #     ylab(etiq2()$lab1) +
  #     ggtitle(etiq2()$lab1)
  #     guides(color=FALSE) +
  #     theme_classic()
  # 
  #   p <- ggplotly(ply1,tooltip = c("text")) #  1. crear objeto plotly
  #   x <- list(title = "Año")                #  2. guardar list con nombre axis x
  #   y <- list(title = etiq3()[[1]])         #  3. guardar list con nombre axis y
  #   t <- etiq3()[[1]]                       #  4. guardar character vector con titulo
  # 
  #   p %>% layout(title = t, # Layout del objeto plotly
  #                xaxis = x, #   - Requiere de atributos especiales
  #                yaxis = y  #   - no usa los de ggplot
  #                ) %>% config(displayModeBar = F)
  # 
  # 
  # })
  # Homepage del sitio web (archivo fuente en .rmd)------------------------------------------------------------
  output$home1 <- renderUI(includeHTML(path = "home.html"))

}


