
# SERVIDOR LAPOP_Iturra-observatorio-cohesion -----------------------------

# SERVER ------------------------------------------------------------------

function(input, output){

# Efecto collapse en sidebar ------------------------------------------------------------------
  onevent("mouseenter", "sidebarCollapsed", shinyjs::removeCssClass(selector = "body", class = "sidebar-collapse"))
  onevent("mouseleave", "sidebarCollapsed", shinyjs::addCssClass(selector = "body", class = "sidebar-collapse"))

# Subset para barplot -------------------------------------------------------------------------

  lapop_subset <- eventReactive(
    eventExpr = input$boton1,
    {lapop_ind_2004to2018 %>% dplyr::select(input$items2,pais,wave) %>% 
        dplyr::filter(pais %in% input$country & wave %in% input$year) %>%
        copy_labels(lapop_ind_2004to2018) # Actualiza el subset variable / pais / año  - reacciona a boton1
                                          # Para usar plotly tuve que agregar un na.omit(), de lo contrario siempre aparecía una barra "null"
  })                                      # - Problema: al agregar na.omit() pierdo los attr labels de sjlabelled
                            
  
  # Gráfico de Barras  ---------------------------------------------------------
  etiq1 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset())) # Crear data con los labels para gráficos
  })
 
  eje_x1    <-  eventReactive(eventExpr = input$boton1,{input$items2})    # Actualiza la variable para el barplot - reacciona a boton1

  etiq1a <- reactive({sjlabelled::get_label(lapop_subset())})  # Crear data con los labels para gráficos
  

# -------------------------------------------------------------------------------------------------
  fraseo01 <- eventReactive(
    eventExpr = input$boton1,
    {fraseo %>%  
        dplyr::filter(var == input$items2) %>% 
        dplyr::select(phrase)
    })         
  
  
# Gráfico de barras (estático) --------------------------------------------------------------------

output$hist1 <-  renderPlot({
    req({input$boton1})
    p1 <- ggplot(lapop_subset(), aes_string(x = eje_x1(),group = "pais")) + 
      geom_bar(aes(group = "pais",y = stat(prop)), fill =  "#497abd"
               ) +
      scale_y_continuous(name = NULL,labels = scales::percent,expand = expand_scale(mult = 0.25)) +
      scale_x_discrete(name = NULL,na.translate = FALSE) +
      facet_wrap("pais~.") +
      geom_label(aes(y     = stat(prop),
                     label = paste0(round(stat(prop) * 100, 1), '%')),
                 stat     = 'count',
                 vjust    = -0.2,
                 nudge_x  = 0,
                 nudge_y  = 0,
                 color    = "black",
                 size     = 5,
                 fontface = "plain",
                 label.padding = unit(0.1, "lines"),
                 alpha = 0.5) +
      theme_hc() +
      theme(strip.text.x     = element_text(size   = 18, face = "bold"),
            strip.text.y     = element_text(size   = 15, family = "Lato",face   = "bold"),
            strip.background = element_rect(colour = "grey",fill   = "white"),panel.spacing= unit(2, "lines"),
            axis.title       = element_text(size  = 13,face   = "bold"),
            axis.text.x      = element_text(size  = 12,face   = "bold"),
            axis.text.y      = element_text(size  = 12,face   = "bold"),
            plot.title       = element_text(size  = 20,face   = "plain",hjust = 0.5,family = "Lato"),
            plot.subtitle    = element_text(size  = 15,family = "Lato", hjust = 0.5   ,face = "italic"),
            plot.caption     = element_text(size  = 13,family = "Lato", hjust = 0   ,face = "plain") ) +
      labs(title    = paste(etiq1()$lab1, "\n \n"),
           subtitle = paste(strwrap(paste(fraseo01(),"\n"), width = 100), collapse = "\n"),
           caption  = "\nFuente: Encuesta LAPOP (2004 - 2018) \nObservatorio de Cohesión Social - Centro de Estudios de Conflicto y Cohesión Social (www.coes.cl)")
    ggdraw() +
      draw_plot(p1) +
      draw_image(
        logo_file, x = 0.98, y = 1.465, hjust = 1, vjust = 1,width = 0.08)
    
    #print(p1)

  })
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

  # Subset 1: sirve para calcular la linea para cada pais y agno -------------
  
  lapop_subset_long <- eventReactive(
    eventExpr = input$boton2,
    {lapop_country_2004to2018 %>% dplyr::select(input$items_long,pais,wave) %>% 
        dplyr::filter(pais %in% input$country_long) %>%
        dplyr::filter(wave %in% c(min(input$year_long):max(input$year_long))) %>% # seleciona el min y max de year
        copy_labels(lapop_country_2004to2018) # Actualiza el subset variable / pais / año  - reacciona a boton2
    })

  # Subset 2: sirve para calcular la linea promedio general | no se filtra por pais -------------#

  lapop_subset_all <- eventReactive(
    eventExpr = input$boton2,
    {lapop_country_2004to2018 %>% dplyr::select(input$items_long,pais,wave,promedio) %>% 
        dplyr::filter(wave %in% c(min(input$year_long):max(input$year_long))) %>%
        copy_labels(lapop_country_2004to2018) # Actualiza el subset variable / pais / año  - reacciona a boton2
    })
  
  # Etiquetas para Gráfico longitudinal  ---------------------------------------------------------
  etiq2 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_subset_long())) # Crear data con los labels para gráficos
  })
  eje_x2    <-  eventReactive(eventExpr = input$boton2,{input$items_long})     # Actualiza la variable para el plot  - reacciona a boton2
  
  fraseo02 <- eventReactive(
    eventExpr = input$boton2,
    {fraseo %>%  
        dplyr::filter(var == input$items_long) %>% 
        dplyr::select(phrase)
    })    
  

  # Etiquetas de valores para longitudinal ------------------------------------------------------
  
  # range [min, max]
  range_val<- eventReactive(
    eventExpr = input$boton2,
    {range(seq(levels(lapop_ind_2004to2018[,input$items_long])))
    })

  # breaks 
  breaks_val<- eventReactive(
    eventExpr = input$boton2,
    {seq(levels(lapop_ind_2004to2018[,input$items_long]))
    })
  
  # value labels
  val_labels <- eventReactive(
    eventExpr = input$boton2,
    {levels(lapop_ind_2004to2018[,input$items_long])
    })
  
  # Grafico longitudinal (estatico) ------------------------------------------------------------------------

  output$plotlong1 <-  renderPlot({
    
    # req({input$items_long})
    req({input$boton2})
    p2<- ggplot(data = lapop_subset_long(),aes_string(x = "wave", y = eje_x2(),group ="pais", color = "pais")) +
      geom_line(size=1.0) +
      geom_point(shape=21,size=3, color ="black",fill="white") +
      stat_summary(data = lapop_subset_all(), aes_string(y = eje_x2(),x = "wave",group = 1), fun.y=mean, colour="black", size=1,alpha =0.8, linetype= "dotted", geom="line") +
      stat_summary(data = lapop_subset_all(), aes_string(y = eje_x2(),x = "wave",group = 1, shape="promedio"), fun.y=mean, colour='navyblue',size=2, geom="point") +
      xlab(label = NULL) +
      ylab(label = NULL) +
      scale_x_discrete(name=NULL,na.translate = FALSE)+
      scale_y_continuous(limits = range_val(),
                         breaks = breaks_val(),  
                         labels = val_labels()) +
      guides(shape=guide_legend(title = NULL),
             color=guide_legend(title = NULL))+
      theme_ipsum_rc()+
      scale_color_brewer(palette = "Set1")+
    theme(axis.text.x  = element_text(size   = 18,family = "Lato",face = "bold"),
          axis.text.y  = element_text(size   = 13,family = "Lato",face = "bold"),
          axis.title.x = element_text(size   = 18,family = "Lato",face = "bold"),
          axis.title.y = element_text(size   = 18,family = "Lato",face = "bold"),
          legend.text  = element_text(size   = 12,family = "Lato"),
          legend.position = "right",
          plot.title   = element_text(size   = 18,family = "Lato",face = "bold",hjust = 0.5),
          plot.subtitle= element_text(size   = 16,family = "Lato",hjust = 0.5   ,face = "italic"),
          plot.caption = element_text(size   = 13,family = "Lato",hjust = 0,face = "plain")) +
      labs(title    = paste(etiq2()$lab1,"\n \n"),
           subtitle = paste(strwrap(paste(fraseo02(),"\n"), width = 150), collapse = "\n"),
           caption  = "\nFuente: Encuesta LAPOP (2004 - 2018) \nObservatorio de Cohesión Social - Centro de Estudios de Conflicto y Cohesión Social (www.coes.cl)")
    ggdraw() +
      draw_plot(p2) +
      draw_image(
        logo_file, x = 0.98, y = 1.462, hjust = 1, vjust = 1,width = 0.08)
  })

  # subset scatterplot  (estatico) ------------------------------------------------------------------------
 
  # Subset A: sirve para calcular la linea para cada pais y agno -------------
  
  # lapop_scatter <- eventReactive(
  #   eventExpr = input$boton3,
  #   {lapop_long_wave %>% dplyr::select(input$items_x,input$items_y,wave) %>% 
  #       dplyr::filter(wave == input$year_scatter) %>% # seleciona el year
  #       copy_labels(df_origin = lapop_long_wave)                  # Actualiza el subset variable / pais / año  - reacciona a boton3
  #   })
  # 
  # Subset B: sirve para calcular la linea para cada pais y agno -------------
  
  lapop_scatter <- eventReactive(
    eventExpr = input$boton3,
    {lapop_long_wave %>% dplyr::select(input$items_x,input$items_y,wave,pais) %>%
        dplyr::filter(pais!="Promedio Región") %>%
        dplyr::filter(wave %in% c(min(input$year_scatter):max(input$year_scatter))) %>% # seleciona el min y max de year
        copy_labels(lapop_long_wave) # Actualiza el subset variable / pais / año  - reacciona a boton2
    })
  lapop_scat_mean <- eventReactive(
    eventExpr = input$boton3,
    {lapop_long_wave %>% 
        dplyr::select(input$items_x,input$items_y,wave,pais) %>%
        dplyr::filter(pais=="Promedio Región") %>% 
        dplyr::filter(wave %in% c(min(input$year_scatter):max(input$year_scatter))) %>%
        copy_labels(lapop_long_wave) # Actualiza el subset variable / pais / año  - reacciona a boton2
    })
    
  # Etiquetas para scatterplot  ---------------------------------------------------------
  etiq3 <- reactive({
    data.table::data.table("lab1"=sjlabelled::get_label(lapop_scatter())) # Crear data con los labels para gráficos
  })
  
  eje_x_scat    <-  eventReactive(eventExpr = input$boton3,{input$items_x})    # Actualiza la variable X para el scatterplot - reacciona a boton1
  eje_y_scat    <-  eventReactive(eventExpr = input$boton3,{input$items_y})    # Actualiza la variable X para el scatterplot - reacciona a boton1
  
  # Etiquetas de valores para longitudinal ------------------------------------------------------#
  
  # range [min, max] - eje X -------------------------------------------------------------------#
  range_val_x<- eventReactive(
    eventExpr = input$boton3,
    {range(seq(levels(lapop_ind_2004to2018[,input$items_x])))
    })
  
  # breaks 
  breaks_val_x<- eventReactive(
    eventExpr = input$boton3,
    {seq(levels(lapop_ind_2004to2018[,input$items_x]))
    })
  
  # value labels
  val_labels_x <- eventReactive(
    eventExpr = input$boton3,
    {levels(lapop_ind_2004to2018[,input$items_x])
    })
  
  # range [min, max] - eje Y -------------------------------------------------------------------#
  range_val_y<- eventReactive(
    eventExpr = input$boton3,
    {range(seq(levels(lapop_ind_2004to2018[,input$items_y])))
    })
  
  # breaks 
  breaks_val_y<- eventReactive(
    eventExpr = input$boton3,
    {seq(levels(lapop_ind_2004to2018[,input$items_y]))
    })
  
  # value labels
  val_labels_y <- eventReactive(
    eventExpr = input$boton3,
    {levels(lapop_ind_2004to2018[,input$items_y])
    })
  
  # Grafico scatterplot (estatico) ------------------------------------------------------------------------

  output$plotscat1 <-  renderPlot({

    # req({input$items_long})
    #req({input$boton3})
    p3<- ggplot(lapop_scatter(),
           aes_string(x=eje_x_scat(),
                      y=eje_y_scat(), 
                      label ="pais",
                      group ="wave")) +
      geom_point() +
      geom_smooth(method = "lm",colour = "black",fill="lightblue",size=0.5) + 
      geom_label_repel(family="Lato",size=4,label.r = 0,position = )+
      geom_label_repel(data=lapop_scat_mean(),family="Lato",size=3,label.r = 0,color="red")+
      xlab(label = paste("\n",etiq3()$lab1[1]))+
      ylab(label = paste(etiq3()$lab1[2],"\n")) +
      facet_wrap("wave~.",ncol = 2,nrow = 4)+
      theme_ipsum_rc()+
      scale_fill_brewer()+
      theme(strip.text.x     = element_text(size   = 18, face = "bold",hjust = 0.5),
            strip.text.y     = element_text(size   = 15, family = "Lato",face   = "bold"),
            strip.background = element_rect(colour = "grey",fill   = "white"),panel.spacing= unit(2, "lines"),
            axis.text.x  = element_text(size   = 18,family = "Lato",face = "bold"),
            axis.text.y  = element_text(size   = 15,family = "Lato",face = "bold"),
            axis.title.x = element_text(size   = 18,family = "Lato",face = "bold"),
            axis.title.y = element_text(size   = 18,family = "Lato",face = "bold"),
            legend.text  = element_text(size   = 12,family = "Lato"),
            plot.title   = element_text(size   = 18,family = "Lato",face = "bold",hjust = 0.5),
            plot.caption = element_text(size   = 12,family = "Lato",hjust = 0,face = "plain")) +
      labs(title    = paste("Asociación entre", etiq3()$lab1[1], "y", etiq3()$lab1[2],"\n"),
           subtitle = "\n \n",
           fill = "Medición (Ola)",
           caption  = "\nFuente: Encuesta LAPOP (2004 - 2018); World Bank Data \nObservatorio de Cohesión Social - Centro de Estudios de Conflicto y Cohesión Social (www.coes.cl)") +
      guides(
        fill = guide_legend(title = NULL,
                            override.aes = aes(label = "")
                            ))
    ggdraw() +
      draw_plot(p3) +
      draw_image(
        logo_file, x = 0.95, y = 1.45, hjust = 1, vjust = 1,width = 0.09)
  })

  
  # Homepage del sitio web (archivo fuente en .rmd)------------------------------------------------------------
  output$home1 <- renderUI(includeHTML(path = "instrucciones.html"))
  
  # Funcion para mensaje de carga------------------------------------------------------------
  # Simulate work being done for 1 second
  Sys.sleep(1)
  
  # Hide the loading message when the rest of the server function has executed
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  show("app-content")
}


