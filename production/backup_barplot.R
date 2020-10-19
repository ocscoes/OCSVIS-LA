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


geom_label(aes(y = stat(prop),
               label = paste0(round(stat(prop)* 100,1), '%')),
           stat    = 'count',
           vjust   = 1.2,
           nudge_x = 0,
           nudge_y = 0,
           color   = "black",
           size    = 5,
           fontface = "plain",
           alpha=0.9)+

