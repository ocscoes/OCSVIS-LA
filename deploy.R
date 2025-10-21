library(pacman)
p_load(rsconnect,
       quarto)

install.packages("http://cran.r-project.org/src/contrib/Archive/curl/curl_6.2.3.tar.gz",
                 repos = NULL, type = "source")

install.packages("devtools")
devtools::install_github("rstudio/rsconnect")


rsconnect::setAccountInfo(name='gabrielcortesp', token='8ED1A66A016F143C75BD71D230D3C0A2', 
                          secret='sQ0pJkQZepkHpzWbjLM/d3oVh9QDN2r1wET6ry+l')

quarto::quarto_publish_app(input = "visualizador-la.qmd",
                   server="shinyapps.io",
                   name = "visualizador-la",
                   account = "gabrielcortesp")



