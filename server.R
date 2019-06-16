
# SERVIDOR LAPOP_Iturra-observatorio-cohesion -----------------------------

# SERVER ------------------------------------------------------------------

function(input, output){
  lapop_subset <- eventReactive(
    eventExpr = input$boton1,
    {lapop_ind1 %>% select(input$items2,pais,year) %>% filter(pais %in% input$country) # Actualiza el subset variable / pais / año  - reacciona a boton1
  })
  
  # Gráfico de Barras  ---------------------------------------------------------
  etiq1 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset()))  # Crear data con los labels para gráficos
  })
  
  eje_x1    <-  eventReactive(eventExpr = input$boton1,{input$items2})    # Actualiza la variable para el barplot - reacciona a boton1
  
# Usando ggplot2 barras -------------------------------------------------------

  output$hist1 <-  renderPlot({
    # req({input$items2})
    req({input$boton1})
  p1 <-ggplot(lapop_subset(), aes_string(x = eje_x1(),group = "pais")) +
      geom_bar(aes(group = "pais", y = ..prop..),
               color     = "black",
               fill =  "#497abd",
               position  = "dodge")+
      geom_label(aes(y = (..prop..),
                    position="dodge",
                    label = paste0(round((..prop..)* 100,1), '%')), 
              stat    = 'count',
              vjust   = 1.2, 
              nudge_x = 0,
              nudge_y = 0,
              color   = "black",
              size    = 3,
              fontface = "plain", 
              alpha=0.9) +
      scale_x_discrete(na.translate = FALSE) + 
      scale_y_continuous(labels = scales::percent) +
      expand_limits(y=c(0, max()))+
      facet_wrap(facets = "pais", 
                 ncol   = 5) +
      theme_classic() + 
      theme(strip.text.x     = element_text(size   = 18,face = "bold"),
            strip.text.y     = element_text(size   = 15,
                                            family = "Lato", 
                                            face   = "bold",),
            strip.background = element_rect(colour = "grey", 
                                            fill   = "white"),
            panel.spacing    = unit(1, "lines",),
            axis.title       = element_text(size  = 13, 
                                            face  = "bold"),
            axis.text.x      = element_text(size  = 10,
                                            face = "bold"),
            plot.title       = element_text(size  = 30,
                                            face  = "plain",
                                            hjust = 0.5,
                                            family = "Lato"),
            plot.caption     = element_text(size  = 13)) + 
      ylab(label    = "Porcentaje (%)") + 
      xlab(label    = paste("\n",etiq1()$lab1)) +
      labs(title    = paste(etiq1()$lab1,"\n"),
           subtitle = NULL,
           caption  = "Fuente: Encuesta LAPOP (2008 - 2014)") +
      guides(fill   = FALSE, 
             colour = FALSE) +
    scale_fill_grey()
  
  print(p1) 
  })

# Guardar ggplot2 barras ----------------------------------------------------------------------

  output$saveplot1 <- downloadHandler(
    filename = function() {paste(str_replace_all(string = etiq1()$lab1,
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
    {lapop %>% select(input$items_long,pais,year,pais_year) %>% filter(pais %in% input$country_long) # Actualiza el subset variable / pais / año  - reacciona a boton1
    })
  
  # Etiquetas para Gráfico longitudinal  ---------------------------------------------------------
  etiq2 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset_long())) # Crear data con los labels para gráficos
  })
  eje_x2   <-  eventReactive(eventExpr = input$boton2,{input$items_long})     # Actualiza la variable para el plot  - reacciona a boton2

  # Grafico longitudinal ------------------------------------------------------------------------
  
  # output$plotlong1 <-  renderPlot({
  #   req({input$items_long})
  #   req({input$boton2})
  #   ggplot(data = lapop_subset_long(),aes_string(x = "year", y = eje_x2(),group ="pais", color = "pais")) +
  #     geom_line(size=1.5) +
  #     geom_point(size=1, color ="black") +
  #     stat_summary(data = lapop, aes_string(y = eje_x2(),x = "year",group = 1), fun.y=mean, colour="red" , size=2, linetype= 5, geom="line") +
  #     stat_summary(data = lapop, aes_string(y = eje_x2(),x = "year",group = 1), fun.y=mean, colour='blue', size=4, alpha  =0.3, geom="point") +
  #     xlab("Año") +
  #     ylab(etiq2()$lab1) +
  #     geom_label_repel(data  = subset(lapop_subset_long(), year %in% c(2014)),
  #                     aes_string(label="pais")) +
  #     guides(color=FALSE)
  # })

  # Grafico longitudinal (interactivo) ------------------------------------------------------------------------
  etiq3 <- reactive({sjlabelled::get_label(lapop_subset_long())})  # Crear data con los labels para gráficos

  output$plotly1 <-  renderPlotly({
    req({input$boton2})
    req({input$items_long})
    ply1 <- ggplot(data = lapop_subset_long(),aes_string(x = "year", y = eje_x2(),group =1,color = "pais",text = "pais_year")) +
      geom_line(size=1.5) +
      # geom_point(size=1.8, color ="blue") +
      stat_summary(data = lapop, aes_string(text = NULL), fun.y="mean", colour="navyblue" , size=1, linetype= "dashed", geom="line") +
      stat_summary(data = lapop, aes_string(text = NULL), fun.y="mean", colour='blue', size=4, alpha  =0.3, geom="point") +
      xlab("Año") +
      ylab(etiq2()$lab1) +
      ggtitle(etiq2()$lab1)
      guides(color=FALSE) +
        theme(panel.background = element_rect(fill='green', colour='red'))
      
    p <- ggplotly(ply1,tooltip = c("text")) #  1. crear objeto plotly     
    x <- list(title = "Año")                #  2. guardar list con nombre axis x          
    y <- list(title = etiq3()[[1]])         #  3. guardar list con nombre axis y                   
    t <- etiq3()[[1]]                       #  4. guardar character vector con titulo
    
    p %>% layout(title = t, # Layout del objeto plotly
                 xaxis = x, #   - Requiere de atributos especiales
                 yaxis = y  #   - no usa los de ggplot
                 ) %>% config(displayModeBar = F)  %>%
        rangeslider()
    
  })
  # Homepage del sitio web (archivo fuente en .rmd)------------------------------------------------------------
  output$home1 <- renderUI(includeHTML(path = "home.html"))
  
}


