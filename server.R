
# SERVIDOR LAPOP_Iturra-observatorio-cohesion -----------------------------

# SERVER ------------------------------------------------------------------

function(input, output){
  lapop_subset <- eventReactive(
    eventExpr = input$boton1,
    {lapop_ind1 %>% select(input$items2,pais,year) %>% filter(pais %in% input$country) %>% na.omit() # Actualiza el subset variable / pais / año  - reacciona a boton1
                                                                                                     # Para usar plotly tuve que agregar un na.omit(), de lo contrario siempre aparecía una barra "null"
  })                                                                                                 # - Problema: al agregar na.omit() pierdo los attr labels de sjlabelled    
  
  lapop_labels <- eventReactive(
    eventExpr = input$boton1,
    {lapop_ind1 %>% select(input$items2,pais,year) %>% filter(pais %in% input$country) # UPDATE: Crearé un data solamente para las etiquetas de variables
      
    })                                                                                  
  
  # Gráfico de Barras  ---------------------------------------------------------
  etiq1 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_labels()))  # Crear data con los labels para gráficos
                                                                          # UPDATE: agrege un lapop_labels porque usando el na.omit() se borraban las estiquetas
  })
  eje_x1    <-  eventReactive(eventExpr = input$boton1,{input$items2})    # Actualiza la variable para el barplot - reacciona a boton1
  
  etiq1a <- reactive({sjlabelled::get_label(lapop_labels())})  # Crear data con los labels para gráficos
  
# Usando ggplot2 barras -------------------------------------------------------

  output$plotly2 <-  renderPlotly({
    # req({input$items2})
    req({input$boton1})
  p1 <-ggplot(lapop_subset(), aes_string(x = input$items2,group = "pais")) +
      geom_bar(aes(group = "pais", 
                   y = stat(prop), 
                   text= paste0(round(stat(prop)*100,1),"%")),
               color     = "black",
               fill =  "#497abd") +
      scale_y_continuous(name=" ",labels = scales::percent) +
      scale_x_discrete(name=" ")+
      facet_wrap("pais~.") +
    theme_classic() + theme(strip.text.x = element_text(size = 12,face = "bold"))
  
  
  
  p1a <- ggplotly(p1,tooltip = c("text"))   # 1. crear objeto plotly     
  t1 <- etiq1a()[[1]]                       # 2. guardar character vector con titulo
  
  p1a %>% layout(title = t1,
                 margin=list(t = 75) # Esto es para mantener el titulo sobre el gráfico. Sin overlap.
                 ) 

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
      theme_classic()
      
    p <- ggplotly(ply1,tooltip = c("text")) #  1. crear objeto plotly     
    x <- list(title = "Año")                #  2. guardar list con nombre axis x          
    y <- list(title = etiq3()[[1]])         #  3. guardar list con nombre axis y                   
    t <- etiq3()[[1]]                       #  4. guardar character vector con titulo
    
    p %>% layout(title = t, # Layout del objeto plotly
                 xaxis = x, #   - Requiere de atributos especiales
                 yaxis = y  #   - no usa los de ggplot
                 ) %>% config(displayModeBar = F)
    
  })
  # Homepage del sitio web (archivo fuente en .rmd)------------------------------------------------------------
  output$home1 <- renderUI(includeHTML(path = "home.html"))
  
}


